import 'dart:convert';

import 'package:bytebank_app/http/webclient.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:http/http.dart';

const String transactionUrl = WebClient.baseUrl + "/transactions";

class TransactionsWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await WebClient.client.get(transactionUrl);

    return parseTransactions(jsonDecode(response.body));
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    print(transaction.toJson());
    await Future.delayed(Duration(seconds: 1));
    final Response response = await WebClient.client.post(transactionUrl,
        headers: {"Content-Type": "application/json", "password": password},
        body: jsonEncode(transaction.toJson()));

    if (response.statusCode == 200 || response.statusCode == 201)
      return Transaction.fromJson(jsonDecode(response.body));

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode))
      return _statusCodeResponses[statusCode];

    return 'unknown error';
  }

  List<Transaction> parseTransactions(List<dynamic> listEntities) {
    final parsed = listEntities.cast<Map<String, dynamic>>();

    return parsed.map((json) => Transaction.fromJson(json)).toList();
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting transaction!',
    401: 'Authentication failed!',
    409: 'Transaction always exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
