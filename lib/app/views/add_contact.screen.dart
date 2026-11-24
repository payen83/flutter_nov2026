import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {
  final Function(Map<String, String>) onAddContact;
  AddContact({super.key, required this.onAddContact});

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  // @override 
  // void dispose(){
  //   _nameController.dispose();
  //   _phoneController.dispose();
  //   super.dispose();
  // }

  void _submitForm(){
    final contactData = {
      'name': _nameController.text,
      'phone': _phoneController.text
    };

    widget.onAddContact(contactData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contact added!'), 
        backgroundColor: Colors.green
      )
    );
    _nameController.clear();
    _phoneController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Add New'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Enter contact information', 
              style: TextStyle(fontSize: 24), 
              textAlign: TextAlign.center
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
            SizedBox(height: 16,),
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
              onPressed: _submitForm, 
              icon: const Icon(Icons.add),
              label: const Text('Add Contact'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white)
            )

          ],
        ),
      ),
    );
  }
}