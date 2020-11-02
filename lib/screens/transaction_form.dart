import 'dart:async';

import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/components/error.dart';
import 'package:bytebank_app/components/failure_dialog.dart';
import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/components/progress_view.dart';
import 'package:bytebank_app/components/success_dialog.dart';
import 'package:bytebank_app/components/transaction_auth_dialog.dart';
import 'package:bytebank_app/http/webclients/transactions_webclient.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:bytebank_app/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class SendingState extends TransactionFormState {
  const SendingState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class SentState extends TransactionFormState {
  const SentState();
}

@immutable
class FatalErrorFormState extends TransactionFormState {
  final String _message;

  const FatalErrorFormState(this._message);
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(ShowFormState());

  void save(Transaction transactionCreated, String password,
      BuildContext context) async {
    emit(SendingState());
    await _send(transactionCreated, password, context);
    emit(SentState());
  }

  _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    final dependencies = AppDependencies.of(context);
    final transactionSaved = await dependencies.transactionsWebClient
        .save(transactionCreated, password)
        .catchError(
            (e) => emit(FatalErrorFormState("HttpException:" + e.message)),
            test: (e) => e is HttpException)
        .catchError(
            (e) => emit(FatalErrorFormState(
                "TimeoutException:" + 'timeout submitting the transaction')),
            test: (e) => e is TimeoutException)
        .catchError(
          (e) => emit(FatalErrorFormState("Exception:" + e.message)),
        );

    emit(SentState());
  }
}

class TransactionFormContainer extends BlocContainer {
  static const String route = "transaction/new";
  final Contact _contact;

  TransactionFormContainer(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionFormCubit(),
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (context, state) {
          if (state is SentState) Navigator.pop(context);
        },
        child: TransactionForm(_contact),
      ),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final Contact _contact;

  const TransactionForm(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        builder: (context, state) {
      if (state is ShowFormState) return _BasicForm(_contact);

      if (state is SendingState || State is SentState) return ProgressView();

      if (state is FatalErrorFormState) return ErrorView(state._message);

      return const ErrorView('Unknown Error');
    });
  }

  Future _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
        context: context,
        builder: (contextDialog) => SuccessDialog('Successful transaction'),
      );

      Navigator.pop(context);
    }
  }

  Future _showFailureMessage(BuildContext context,
      {String message = 'Unknown error'}) async {
    await showDialog(
      context: context,
      builder: (contextDialog) => FailureDialog(message),
    );

    Navigator.pop(context);
  }
}

class _BasicForm extends StatelessWidget {
  final String appName = "New transaction";
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
  final Contact _contact;

  _BasicForm(this._contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appName),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _contact.fullName,
                  style: TextStyle(fontSize: 24.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _contact.accountNumber.toString(),
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _valueController,
                    style: TextStyle(fontSize: 24.0),
                    decoration: InputDecoration(
                        labelText: 'Value', hintText: '1234.00'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: RaisedButton(
                      child: Text('Transfer'),
                      onPressed: () {
                        final double value =
                            double.tryParse(_valueController.text);
                        final transactionCreated =
                            Transaction(transactionId, value, _contact);

                        showDialog(
                            context: context,
                            builder: (contextDialog) => TransactionAuthDialog(
                                  onConfirm: (password) {
                                    BlocProvider.of<TransactionFormCubit>(
                                            context)
                                        .save(transactionCreated, password,
                                            context);
                                  },
                                ));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
