import 'package:bytebank_app/http/webclients/transactions_webclient.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  static const String route = "transaction/new";

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final String appName = "Transaction";
  TextEditingController _valueController = TextEditingController();
  final TransactionsWebClient _webClient  = TransactionsWebClient(); 

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
                      final transactionCreated = Transaction(value, contact);
                      _webClient.save(transactionCreated).then((transactSaved) {
                        if (transactSaved != null) Navigator.pop(context);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
