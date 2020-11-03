
import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/components/localization/i18n_cubit.dart';
import 'package:bytebank_app/components/localization/locale.dart';
import 'package:bytebank_app/components/localization/i18n_view.dart';
import 'package:bytebank_app/http/webclients/i18n_webclient.dart';
import 'package:bytebank_app/models/i18n_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Widget I18NWidgetCreate(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreate creator;
  final String viewKey;

  I18NLoadingContainer({@required this.viewKey, @required this.creator});

  @override
  Widget build(BuildContext context) {
    String language = BlocProvider.of<CurrentLocaleCubit>(context).state;
    return BlocProvider<I18NMessagesCubit>(
      create: (_) {
        final cubit = I18NMessagesCubit(this.viewKey);
        cubit.reload(I18NWebClient(language, this.viewKey));
        return cubit;
      },
      child: I18NLoadingView(this.creator),
    );
  }
}