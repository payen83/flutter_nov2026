import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  final Map<String, String> contact;
  final int contactIndex;
  final Function(int, Map<String, String>) onEditContact;
  final Function(int) onDeleteContact;

  const EditContact({
    super.key,
    required this.contact,
    required this.onEditContact,
    required this.contactIndex,
    required this.onDeleteContact
  });


  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override 
  void dispose(){
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController(text: widget.contact['name']);
    _phoneController = TextEditingController(text: widget.contact['phone']);
  }

  void _editForm(){
    final contactData = {
      'name': _nameController.text,
      'phone': _phoneController.text
    };
    widget.onEditContact(widget.contactIndex, contactData);

    Navigator.pop(context);
  }

  void _showDeleteConfirmation(){
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Contact'),
          content: Text('Are you sure you want to delete ${widget.contact['name']}?'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.of(context).pop();
              _deleteContact();
            }, child: const Text('Delete', style: TextStyle(color: Colors.red),)),
          ],
        );
      }
    );
  }

  void _deleteContact(){
    widget.onDeleteContact(widget.contactIndex);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Edit Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter contact information',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter contact name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.call),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _editForm,
              icon: const Icon(Icons.add),
              label: const Text('Update Contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _showDeleteConfirmation, 
              label: const Text('Delete Contact'),
              icon: Icon(Icons.delete),
              style: OutlinedButton.styleFrom(                
                foregroundColor: Colors.red,
                side: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              
            )
          ],
        ),
      ),
    );
  }
}
