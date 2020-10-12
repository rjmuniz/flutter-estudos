import 'package:bytebank_app/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:flutter/material.dart';

const String AppBarTitle = 'Contatos';

class ContactsList extends StatefulWidget {
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
                    return _ContactItem(contacts[index]);
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
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ),
              )
              .then((context) => this.setState(() {
                    debugPrint('Refresh');
                  }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        contact.fullName,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
      ),
      subtitle: Text(contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0)),
    ));
  }
}
