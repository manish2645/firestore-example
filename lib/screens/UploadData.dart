
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'UserModel.dart';

class UploaduserData extends StatefulWidget {
  const UploaduserData({super.key});

  @override
  State<UploaduserData> createState() => _UploaduserDataState();
}

class _UploaduserDataState extends State<UploaduserData> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Form'),
              SizedBox(height: 16.0,),
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Name',
                padding: EdgeInsets.all(16.0),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 16.0),
              CupertinoTextField(
                controller: _genderController,
                placeholder: 'Gender',
                padding: EdgeInsets.all(16.0),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Email',
                padding: EdgeInsets.all(16.0),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  onPressed: () {
                    // Handle form submission
                    String name = _nameController.text;
                    String gender = _genderController.text;
                    String email = _emailController.text;
                    print('Name: $name, Email: $email, Age: $gender');
                    uploadUserData();
                  },
                  child: Text('Submit'),
                  color: CupertinoColors.activeBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearTextFields() {
    _nameController.text = '';
    _genderController.text = '';
    _emailController.text = '';
  }

  Future<void> uploadUserData() async {
    UserData userData = UserData(
      name: _nameController.text,
      gender: _genderController.text,
      email: _emailController.text,
      createdAt: Timestamp.now(), // Current timestamp
    );
    final collectionRef = FirebaseFirestore.instance.collection('users');
    try {
      await collectionRef.add(userData.toMap());
      print('User data uploaded successfully');
      clearTextFields();
    } catch (e) {
      print('Error uploading user data: $e');
    }
  }
}