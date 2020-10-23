import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:bytebank_app/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

const String AppBarTitle = 'Transfer';

class ContactsList extends StatefulWidget {
  static const route = '/contact_list';

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppBarTitle)),
      body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: dependencies.contactDao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return ContactItem(
                      contact,
                      this,
                      onClick: () {
                        Navigator.pushNamed(context, TransactionForm.route,
                            arguments: contact);
                      },
                    );
                  },
                  itemCount: contacts.length,
                );
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.none:
                return Progress(
                    message: "No contacts saved", showLoading: false);
              case ConnectionState.active:
                return Progress(message: 'active');
            }

            return Text('Unknow error');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(ContactForm.route)
              .then((context) => this.setState(() {
                    debugPrint('Refresh');
                  }));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void modifyMe() {
    this.setState(() {
      debugPrint('updated');
    });
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final _ContactsListState parent;
  final Function onClick;
  static const editValue = "edit";
  static const deleteValue = "delete";

  ContactItem(this.contact, this.parent, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /*  onTapDown: (details) {
        debugPrint('tapping');
        RelativeRect position =
            RelativeRect.fromLTRB(0, details.globalPosition.dy, -1, 0);
        _showPopup(context, position);
      },*/
      // onLongPress: () {},
      onTap: () {
        onClick();
      },
      child: Card(
        child: ListTile(
          title: Text(
            contact.fullName,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
          ),
          subtitle: Text(contact.accountNumber.toString(),
              style: TextStyle(fontSize: 16.0)),
        ),
      ),
    );
  }
/*
  void _showPopup(BuildContext context, RelativeRect position) async {
    final String choice =
        await showMenu<String>(context: context, position: position, items: [
      PopupMenuItem(
        value: editValue,
        child: Row(
          children: [
            Icon(Icons.edit),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Edit...", style: TextStyle(fontSize: 24.0)),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        value: deleteValue,
        child: Row(
          children: [
            Icon(Icons.delete),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Delete", style: TextStyle(fontSize: 24.0)),
            ),
          ],
        ),
      ),
    ]);

    if (choice == editValue) {
      Navigator.pushNamed(
        context,
        ContactForm.route,
        arguments: ContactFormArguments(this.contact.id),
      ).then((value) => this.parent.modifyMe());
    } else {
      _dao.delete(this.contact);
      this.parent.modifyMe();
    }
  }*/
}
