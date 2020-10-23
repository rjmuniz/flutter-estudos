import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/http/webclients/transactions_webclient.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionsWebClient transactionsWebClient;

  AppDependencies({
    @required this.contactDao,
    @required this.transactionsWebClient,
    @required Widget child,
  }) : super(child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) =>
      this.contactDao != oldWidget.contactDao ||
      this.transactionsWebClient != oldWidget.transactionsWebClient;
}
