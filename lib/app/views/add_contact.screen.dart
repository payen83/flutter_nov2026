import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  final Function(Map<String, String>) onAddContact;
  const AddContact({super.key, required this.onAddContact});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {  
    if (_formKey.currentState!.validate()) {
      final contactData = {
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim()
      };

      // Add contact using callback
      widget.onAddContact(contactData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contact added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form and navigate back
      _nameController.clear();
      _phoneController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Enter Contact Info', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                // validator: (value) {
                //   if (value == null || value.trim().isEmpty) {
                //     return 'Please enter a phone number';
                //   }
                //   // Basic phone number validation
                //   if (!RegExp(r'^[+]?[0-9\s\-()]{10,}$').hasMatch(value)) {
                //     return 'Please enter a valid phone number';
                //   }
                //   return null;
                // },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Contact',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}