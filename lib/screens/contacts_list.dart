import 'package:bytebank_app/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:flutter/material.dart';

const String AppBarTitle = 'Contatos';

class ContactsList extends StatefulWidget {
  static const route = '/contact_list';

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppBarTitle)),
      body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: _dao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return _ContactItem(contacts[index], _dao, this);
                  },
                  itemCount: contacts.length,
                );
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Loading...',
                          style: TextStyle(fontSize: 24.0),
                        ),
                      )
                    ],
                  ),
                );
              case ConnectionState.none:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No contacts saved",
                          style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                );
              case ConnectionState.active:
                debugPrint('active');
                return Text('active');
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

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final ContactDao _dao;
  final _ContactsListState parent;
  static const editValue = "edit";
  static const deleteValue = "delete";

  _ContactItem(this.contact, this._dao, this.parent);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (details) {
        debugPrint('tapping');
        RelativeRect position =
            RelativeRect.fromLTRB(0, details.globalPosition.dy, -1, 0);
        _showPopup(context, position);
      },
      onLongPress: () {},
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
  }
}
