
import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/components/localization/i18n_container.dart';
import 'package:bytebank_app/models/name.dart';
import 'package:bytebank_app/screens/dashboard/Dashboard_view.dart';
import 'package:bytebank_app/screens/dashboard/dashboard_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Ricardo"),
      child: I18NLoadingContainer(
          viewKey: 'dashboard',
          creator: ( messages) => DashboardView(DashboardViewLazyI18N(messages))
      ),
    );
  }
}