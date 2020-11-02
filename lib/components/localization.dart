//localization e Internacionalization

import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/components/error.dart';
import 'package:bytebank_app/components/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalicationContainer extends BlocContainer {
  final Widget child;

  LocalicationContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (_) {
        return CurrentLocaleCubit();
      },
      child: this.child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("en");

  void load(Widget child) {}
}

class ViewI18N {
  String _language;

  ViewI18N(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
    print('Language: $_language');
  }

  String localize(Map<String, String> values) {
    assert(values != null);
    assert(values.containsKey(_language));
    return values[_language];
  }
}

abstract class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class InitI8NMessagesState extends I18NMessagesState {
  const InitI8NMessagesState();
}

@immutable
class LoadingI8NMessagesState extends I18NMessagesState {
  const LoadingI8NMessagesState();
}

@immutable
class LoadedI8NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;

  LoadedI8NMessagesState(this._messages);
}

@immutable
class FatalErrorI8NMessagesState extends I18NMessagesState {
  final String message;

  const FatalErrorI8NMessagesState(this.message);
}

typedef Widget I18NWidgetCreate(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreate creator;

  I18NLoadingContainer({this.creator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (_) {
        final cubit = I18NMessagesCubit();
        cubit.reload();
        return cubit;
      },
      child: I18NLoadingView(this.creator),
    );
  }
}

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreate _creator;

  const I18NLoadingView(this._creator) : assert(_creator != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is InitI8NMessagesState || state is LoadingI8NMessagesState)
          return ProgressView(message:'Processing i18n');
        if (state is LoadedI8NMessagesState) {
          print('creating creator');
          return this._creator.call(state._messages);
        }
        return ErrorView("Erro buscando mensagem da tela");
      },
    );
  }
}

class I18NMessages {
  final Map<String, String> _messages;

  I18NMessages(this._messages);

  String get(String key) {
    assert(key != null);
    assert(_messages.containsKey(key));

    return _messages[key];
  }
}

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  I18NMessagesCubit() : super(InitI8NMessagesState());

  void reload() async{
    emit(LoadingI8NMessagesState());
    //load messages
    final messages = {'chave': 'valor'};
    await Future.delayed(Duration(seconds: 2));

    emit(LoadedI8NMessagesState(
      I18NMessages(messages),
    ));
  }
}
