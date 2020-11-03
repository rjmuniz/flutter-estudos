
import 'package:bytebank_app/components/localization/i18n_state.dart';
import 'package:bytebank_app/http/webclients/i18n_webclient.dart';
import 'package:bytebank_app/models/i18n_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = LocalStorage('local_v1.json');
  final String _viewKey;

  I18NMessagesCubit(this._viewKey) : super(InitI8NMessagesState());

  void reload(I18NWebClient client) async {
    emit(LoadingI8NMessagesState());
    await storage.ready;
    final items = storage.getItem(this._viewKey);
    if (items != null) {
      print('loaded from cache');
      emit(LoadedI8NMessagesState(I18NMessages(items)));
      return;
    }

    await Future.delayed(Duration(seconds: 1));
    final messages = await client.findAll();
    await saveAndRefresh(messages);
  }

  saveAndRefresh(Map<String, dynamic> messagesJson) async {
    print('loaded from web');
    final state = LoadedI8NMessagesState(I18NMessages(messagesJson));
    await storage.setItem(_viewKey, messagesJson);

    emit(state);
  }
}
