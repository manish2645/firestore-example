import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserModel.dart';

class UploadUserData extends StatefulWidget {
  const UploadUserData({Key? key, required Null Function() onDataUploaded}) : super(key: key);

  @override
  State<UploadUserData> createState() => _UploadUserDataState();
}

class _UploadUserDataState extends State<UploadUserData> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Form'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.indigo], // Customize your gradient colors here
          ),
        ),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 24.0),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : _handleSubmit,
                    child: isSubmitting
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() async {
    setState(() {
      isSubmitting = true;
    });

    String name = _nameController.text;
    String gender = _genderController.text;
    String email = _emailController.text;

    // Validate the form data here if needed

    UserData userData = UserData(
      name: name,
      gender: gender,
      email: email,
      createdAt: Timestamp.now(), // Current timestamp
    );

    final collectionRef = FirebaseFirestore.instance.collection('users');

    try {
      await collectionRef.add(userData.toMap());
      print('User data uploaded successfully');
      _clearTextFields();
    } catch (e) {
      print('Error uploading user data: $e');
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  void _clearTextFields() {
    _nameController.clear();
    _genderController.clear();
    _emailController.clear();
  }
}
