import 'package:flutter/material.dart';
import 'package:flutter_nov2026/app/views/add_contact.screen.dart';
import 'package:flutter_nov2026/app/views/edit_contact.screen.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  String imageUrl = 'https://s3.eu-central-1.amazonaws.com/uploads.mangoweb.org/shared-prod/visegradfund.org/uploads/2021/08/placeholder-male.jpg';
  final List<Map<String, String>> contacts = [
    {
      'name': 'John Doe',
      'phone': '+1-555-0123'
    },
    {
      'name': 'Jane Smith',
      'phone': '+1-555-0456'
    }
    // add more data here
  ];

  void addNewContact(Map<String, String> contactData) {
    setState(() {
      contacts.add(contactData);
    });
  }

  // Method to edit existing contact
  void editContact(int index, Map<String, String> contactData) {
    setState(() {
      contacts[index] = contactData;
    });
  }

  // Method to delete contact
  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Contact List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContact(onAddContact: addNewContact),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          // ListTile implementation will be in next step
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
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
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contact tapped: ${contact['name']}'),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditContact(
                      contact: contact,
                      contactIndex: index,
                      onEditContact: editContact,
                      onDeleteContact: deleteContact,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
