import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(InitContactsListState());

  void reload(ContactDao dao) async {
    emit(LoadingContactsListState());

    final contacts = await dao.findAll();

    emit(LoadedContactsListState(contacts));
  }
}
