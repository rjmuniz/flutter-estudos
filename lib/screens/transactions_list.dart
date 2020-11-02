import 'package:bytebank_app/components/message.dart';
import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/http/webclients/transactions_webclient.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:flutter/material.dart';

const String AppBarTitle = 'Transactions';

class TransactionList extends StatelessWidget {
  static const route = '/transactionFeed_list';
  final TransactionsWebClient _webClient = TransactionsWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppBarTitle),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(Duration(seconds: 1)).then((done) => _webClient.findAll()),
        builder: (context, snapshot) {
          Widget control = Text('Unknow error');

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              control = CenteredMessage(
                  message: 'No transactions found', icon: Icons.warning);
              break;
            case ConnectionState.active:
              control = CenteredMessage(message: 'active');
              break;
            case ConnectionState.waiting:
              control = Progress();
              break;
            case ConnectionState.done:
              control = populateTransactions(snapshot);
              break;
          }
          return control;
        },
      ),
    );
  }

  Widget populateTransactions(AsyncSnapshot<List<Transaction>> snapshot) {
    if (snapshot.hasError) {
      print(snapshot.error.toString());
      return CenteredMessage(message: "Erro ao acessar a api",//snapshot.error.toString(),
          icon: Icons.error);
    }
    if (snapshot.hasData) {
      final List<Transaction> transactions = snapshot.data;
      if (transactions.isNotEmpty)
        return ListView.builder(
          itemBuilder: (context, index) {
            final Transaction transaction = transactions[index];
            return Card(
              child: ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text(
                  transaction.value.toString(),
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  transaction.contact.showName(),
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
          itemCount: transactions.length,
        );
    }

    return CenteredMessage(message: 'No transactions found', icon: Icons.warning);
  }
}
