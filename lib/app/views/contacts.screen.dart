import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nov2026/app/views/add_contact.screen.dart';
import 'package:flutter_nov2026/app/views/edit_contact.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  static const String _contactsKey = 'CONTACTS';
  late SharedPreferences _prefs;
  final List<Map<String, String>> contacts = [];

  String imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png';

  @override
  void initState(){
    super.initState();
    _initPrefs();
  }
  
  Future<void> _initPrefs() async{
    _prefs = await SharedPreferences.getInstance();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final String? contactsJson = _prefs.getString(_contactsKey);
    if(contactsJson != null){
      final List<dynamic> decoded = jsonDecode(contactsJson);
      setState(() {
        contacts.clear();
        contacts.addAll(decoded.map((item) => Map<String, String>.from(item)));
      });
    }
  }

  Future<void> _saveContacts() async {
    final List<Map<String, dynamic>> toEncode = 
      contacts.map((contact) => Map<String, dynamic>.from(contact)).toList();
    await _prefs.setString(_contactsKey, jsonEncode(toEncode));
  }

  void addNewContact(Map<String, String> contactData){
    setState(() {
      contacts.add(contactData);
    });
    _saveContacts();
  }

  void editContact(int index, Map<String, String> contactData){
    setState(() {
      contacts[index] = contactData;
    });
    _saveContacts();
  }

  void deleteContact(int index){
    setState(() {
      contacts.removeAt(index);
    });
    _saveContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(  
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl, 
                width: 40, 
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              contact['name']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(contact['phone']!),
            trailing: IconButton(
              onPressed: (){
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => EditContact(
                      contact: contact, 
                      onEditContact: editContact, 
                      contactIndex: index, 
                      onDeleteContact: deleteContact
                    )
                  )
                );
              }, 
              icon: Icon(Icons.edit)
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => AddContact(onAddContact: addNewContact,)
            )
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}