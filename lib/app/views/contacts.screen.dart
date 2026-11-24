import 'package:flutter/material.dart';
import 'package:flutter_nov2026/app/views/add_contact.screen.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  final List<Map<String, String>> contacts = [
    { 'name': 'James Wong', 'phone': '+60189987663' },
    { 'name': 'Alice Thomas', 'phone': '+60192238383' },
    { 'name': 'Muthusamy Vellu', 'phone': '+60145556789' },
  ];

  String imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png';

  void addNewContact(Map<String, String> contactData){

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
            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
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