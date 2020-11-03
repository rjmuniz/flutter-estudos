
import 'package:bytebank_app/models/i18n_messages.dart';
import 'package:flutter/material.dart';

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
  final I18NMessages messages;

  LoadedI8NMessagesState(this.messages);
}

@immutable
class FatalErrorI8NMessagesState extends I18NMessagesState {
  final String message;

  const FatalErrorI8NMessagesState(this.message);
}