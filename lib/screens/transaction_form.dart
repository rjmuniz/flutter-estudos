import 'dart:async';

import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/components/success_dialog.dart';
import 'package:bytebank_app/components/transaction_auth_dialog.dart';
import 'package:bytebank_app/http/webclients/transactions_webclient.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  static const String route = "transaction/new";

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final String appName = "Transaction";
  final TextEditingController _valueController = TextEditingController();
  final TransactionsWebClient _webClient = TransactionsWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final Contact contact = ModalRoute.of(context).settings.arguments;
    print(contact);
    return Scaffold(
        appBar: AppBar(
          title: Text(appName),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Progress(message: 'Sending...',),
                  ),
                  visible: _sending,
                ),
                Text(
                  contact.fullName,
                  style: TextStyle(fontSize: 24.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    contact.accountNumber.toString(),
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _valueController,
                    style: TextStyle(fontSize: 24.0),
                    decoration: InputDecoration(
                        labelText: 'Value', hintText: '1234.00'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) => TransactionAuthDialog(
                                onConfirm: (password) {
                                  print(password);
                                  _save(transactionCreated, password, context);
                                },
                              ));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _save(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      this._sending = true;
    });
    final Transaction transactSaved = await _webClient
        .save(transactionCreated, password)
        .catchError(
          (e) => _showFailureMessage(context,
              message: "timeout submitting the transation"),
          test: (e) => e is TimeoutException,
        )
        .catchError(
          (e) => _showFailureMessage(context, message: e.message),
          test: (e) => e is HttpException,
        )
        .catchError(
          (e) => _showFailureMessage(context),
          test: (e) => e is Exception,
        ).whenComplete(() =>
        setState(() {
          this._sending = false;
        }));



    if (transactSaved != null) {
      await showDialog(
          context: context,
          builder: (_) => SuccessDialog("Successful Transaction"));

      Navigator.pop(context);
    }
  }

  Future _showFailureMessage(BuildContext context,
      {String message = 'Unknow error'}) async {
    return await showDialog(
        context: context, builder: (contextDialog) => FailureDialog(message));
  }
}
