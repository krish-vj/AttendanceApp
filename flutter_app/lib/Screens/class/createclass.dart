import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestore_service.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});
  

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  Future<void> createClassFun(String className, String section, String room, String subject) async {
  final user = await FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not authenticated');
  }

  await _firestoreService.db.collection('classes').add({
    'name': className,
    'section': section,
    'room': room,
    'subject': subject,
    'teacherId': user.uid,
    'createdAt': FieldValue.serverTimestamp(),
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create class"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 8, bottom: 8),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.lightBlue)),
            
              onPressed: () async {
                if (_formKey.currentState!.validate()) {  // Add this check first
                  String className = _classNameController.text.trim();  // Trim whitespace for safety
                  String section = _sectionController.text.trim();
                  String room = _roomController.text.trim();
                  String subject = _subjectController.text.trim();
                  
                  try {
                    await createClassFun(className, section, room, subject);
                    if (mounted) {  // Check if widget is still mounted before navigating
                      Navigator.pushNamed(context, '/home');
                    }
                  } catch (e) {
                    // Handle errors (e.g., auth or Firestore issues)
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error creating class: $e')),
                      );
                    }
                  }
                }
                // If validation fails, errors show automatically, and nothing else happens
              },
              child: Center(
                child: const Text(
                  "Create",
                  style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Class details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _classNameController,
                decoration: const InputDecoration(
                  labelText: "Class name *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Class name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sectionController,
                decoration: const InputDecoration(
                  labelText: "Section",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _roomController,
                decoration: const InputDecoration(
                  labelText: "Room",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: "Subject",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}