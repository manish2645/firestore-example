import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UpdateUserDataScreen extends StatefulWidget {
  final String documentId;
  final String currentName;
  final int currentAge;
  final String currentEmail;

  UpdateUserDataScreen({
    required this.documentId,
    required this.currentName,
    required this.currentAge,
    required this.currentEmail,
  });

  @override
  _UpdateUserDataScreenState createState() => _UpdateUserDataScreenState();
}

class _UpdateUserDataScreenState extends State<UpdateUserDataScreen> {
  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _genderController = TextEditingController(text: widget.currentAge.toString());
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Update User Data'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
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
                    placeholder: 'Age',
                    padding: EdgeInsets.all(16.0),
                    keyboardType: TextInputType.number,
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
                    child: CupertinoButton.filled(
                      onPressed: () async {
                        String newName = _nameController.text;
                        int newGender = int.tryParse(_genderController.text) ?? 0;
                        String newEmail = _emailController.text;
                        await _updateUserData(widget.documentId, newName, newGender, newEmail);
                        Navigator.of(context).pop(); // Close the update screen
                      },
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _updateUserData(String documentId, String newName, int newAge, String newEmail) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(documentId).update({
        'name': newName,
        'age': newAge,
        'email': newEmail,
      });
      print('User data updated successfully');
    } catch (error) {
      print('Error updating user data: $error');
    }
  }

}
