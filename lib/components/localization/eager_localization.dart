import 'package:bytebank_app/components/localization/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewI18N {
  String _language;

  ViewI18N(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
    print('Current language: $_language');
  }

  String localize(Map<String, String> values) {
    assert(values != null);
    assert(values.containsKey(_language));
    return values[_language];
  }
}
