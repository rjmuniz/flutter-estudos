import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ContactsListState {
  const ContactsListState();
}

@immutable
class LoadingContactsListState extends ContactsListState {
  const LoadingContactsListState();
}

@immutable
class InitContactsListState extends ContactsListState {
  const InitContactsListState();
}

@immutable
class LoadedContactsListState extends ContactsListState {
  final List<Contact> contacts;

  const LoadedContactsListState(this.contacts);
}

@immutable
class FatalErrorContactsListState extends ContactsListState {
  const FatalErrorContactsListState();
}
