import 'package:flutter/material.dart';

import '../layout_type.dart';
import '../main_app_bar.dart';


class Contact {
  Contact({this.name, this.email});
  final String name;
  final String email;
}

class WritingPage extends StatelessWidget implements HasLayoutGroup {
  WritingPage({Key key, this.layoutGroup, this.onLayoutToggle}) : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        layoutGroup: layoutGroup,
        layoutType: LayoutType.writing,
        onLayoutToggle: onLayoutToggle,
      ),
      body: Container(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
        itemCount: allContacts.length,
        itemBuilder: (BuildContext content, int index) {
          Contact contact = allContacts[index];
          return ContactListTile(contact);
        });
  }
}

class ContactListTile extends ListTile {
  ContactListTile(Contact contact)
      : super(
    title: Text(contact.name),
    subtitle: Text(contact.email),
    leading: CircleAvatar(child: Text(contact.name[0])),
  );
}

List<Contact> allContacts = [
  Contact(name: 'dadadad Tusa', email: 'isa.tusa@me.com'),
  Contact(name: 'Racquel Ricciardi', email: 'racquel.ricciardi@me.com'),
  Contact(name: 'Teresita Mccubbin', email: 'teresita.mccubbin@me.com'),

];