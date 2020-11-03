//localization e Internacionalization

import 'package:bytebank_app/components/error.dart';
import 'package:bytebank_app/components/localization/i18n_container.dart';
import 'package:bytebank_app/components/localization/i18n_cubit.dart';
import 'package:bytebank_app/components/localization/i18n_state.dart';
import 'package:bytebank_app/components/progress/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreate _creator;

  const I18NLoadingView(this._creator) : assert(_creator != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is InitI8NMessagesState || state is LoadingI8NMessagesState)
          return ProgressView(message: 'Downloading i18n');
        if (state is LoadedI8NMessagesState) {
          return this._creator.call(state.messages);
        }
        return ErrorView("Erro buscando mensagem da tela");
      },
    );
  }
}
