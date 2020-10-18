import 'dart:convert';

import 'package:bytebank_app/http/webclient.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:http/http.dart';


const String transactionUrl = WebClient.baseUrl + "/transactions";
class TransactionsWebClient{


  Future<List<Transaction>> findAll() async {
    final Response response =
    await WebClient.client.get(transactionUrl).timeout(Duration(seconds: 5));

    return parseTransactions(response);
  }

  Future<Transaction> save(Transaction transaction) async {
    print(transaction.toJson());
    final Response response = await WebClient.client.post(transactionUrl,
        headers: {"Content-Type": "application/json", "password": "1000"},
        body: jsonEncode(transaction.toJson()));

    return Transaction.fromJson(jsonDecode(response.body));
  }

  List<Transaction> parseTransactions(Response response) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return parsed.map((json) => Transaction.fromJson(json)).toList();
  }

}