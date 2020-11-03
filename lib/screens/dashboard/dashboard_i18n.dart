
import 'package:bytebank_app/components/localization/eager_localization.dart';
import 'package:bytebank_app/models/i18n_messages.dart';
import 'package:flutter/material.dart';

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) :super(context);

  String get transfer => localize({'pt-br': 'Transferir', 'en': 'Transfer'});

  String get transactionFeed =>
      localize({'pt-br': 'Transações', 'en': 'Transacion feed'});

  String get changeName =>
      localize({'pt-br': 'Mudar o nome', 'en': 'Change name'});
}

class DashboardViewLazyI18N {
  final I18NMessages _messages;
  DashboardViewLazyI18N(this._messages);

  String get transfer => this._messages.get('transfer');

  String get transactionFeed =>this._messages.get('transaction_feed');

  String get changeName =>this._messages.get('change_name');
}