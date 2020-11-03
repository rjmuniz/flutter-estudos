import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/components/progress/progress.dart';
import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/contacts_list/components/contact_item.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_cubit.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_state.dart';
import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String AppBarTitle = 'Transfer';




class ContactsListView extends BlocContainer {
  final ContactDao dao;

  ContactsListView(this.dao) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppBarTitle)),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
        builder: (context, state) {
          if (state is InitContactsListState ||
              state is LoadingContactsListState) return Progress();

          if (state is LoadedContactsListState) {
            final contacts = state.contacts;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return ContactItem(
                  contact,
                  onClick: () {
                    // push(context, TransactionFormContainer(contact));
                    push(context, TransactionFormContainer(contact));
                    // Navigator.pushNamed(context, TransactionForm.route,
                    //     arguments: contact);
                  },
                );
              },
              itemCount: contacts.length,
            );
          }
          return const Text('Unknow error');
        },
      ),
      floatingActionButton: buildAddContactButton(context),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).pushNamed(ContactForm.route);
        update(context);
      },
      child: Icon(Icons.add),
    );
  }

  void update(BuildContext context) {
    context.bloc<ContactsListCubit>().reload(dao);
  }
}
