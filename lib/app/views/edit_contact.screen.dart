import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  final Map<String, String> contact;
  final int contactIndex;
  final Function(int, Map<String, String>) onEditContact;
  final Function(int) onDeleteContact;
  
  const EditContact({
    super.key,
    required this.contact,
    required this.contactIndex,
    required this.onEditContact,
    required this.onDeleteContact,
  });

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text editing controllers for form fields
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current contact data
    _nameController = TextEditingController(text: widget.contact['name']);
    _phoneController = TextEditingController(text: widget.contact['phone']);
  }

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If validation passes, process the form data
      final contactData = {
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim()
      };
      
      // Update the contact using the callback
      widget.onEditContact(widget.contactIndex, contactData);
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contact updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate back to contacts list
      Navigator.pop(context);
    }
  }

  // Method to show delete confirmation dialog
  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Contact'),
          content: Text('Are you sure you want to delete ${widget.contact['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _deleteContact(); // Delete the contact
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to delete the contact
  void _deleteContact() {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.contact['name']} deleted successfully!'),
        backgroundColor: Colors.red,
      ),
    );
    
    // Delete the contact using the callback
    widget.onDeleteContact(widget.contactIndex);
    
    // Navigate back to contacts list
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Edit Contact'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header text
              const Text(
                'Edit Contact Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // Name field
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
              
              // Phone number field
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 32),
              
              // Save button
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Delete button
              ElevatedButton.icon(
                onPressed: _showDeleteConfirmation,
                icon: const Icon(Icons.delete),
                label: const Text(
                  'Delete Contact',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Cancel button
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.cancel),
                label: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}