import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:bytebank_app/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String AppBarTitle = 'Transfer';

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
  final List<Contact> _contacts;

  const LoadedContactsListState(this._contacts);
}

@immutable
class FatalErrorContactsListState extends ContactsListState {
  const FatalErrorContactsListState();
}

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(InitContactsListState());

  void reload(ContactDao dao) async {
    emit(LoadingContactsListState());

    final contacts = await dao.findAll();

    emit(LoadedContactsListState(contacts));
  }
}

class ContactsListContainer extends BlocContainer {
  static const route = '/contact_list';

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return BlocProvider(
      create: (BuildContext context) {
        final cubit = ContactsListCubit();

        cubit.reload(dependencies.contactDao);

        return cubit;
      },
      child: ContactsList(dependencies.contactDao),
    );
  }
}

class ContactsList extends BlocContainer {
  final ContactDao dao;

  ContactsList(this.dao) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppBarTitle)),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
        builder: (context, state) {
          if (state is InitContactsListState ||
              state is LoadingContactsListState) return Progress();

          if (state is LoadedContactsListState) {
            final contacts = state._contacts;
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

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;
  static const editValue = "edit";
  static const deleteValue = "delete";

  ContactItem(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: ()=>onClick(),
        title: Text(
          contact.fullName,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
        ),
        subtitle: Text(contact.accountNumber.toString(),
            style: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}