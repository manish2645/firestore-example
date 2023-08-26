import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UpdataData.dart';

class RetrieveUserData extends StatefulWidget {
  const RetrieveUserData({super.key});

  @override
  State<RetrieveUserData> createState() => _RetrieveUserDataState();
}

class _RetrieveUserDataState extends State<RetrieveUserData> {
  late Stream<QuerySnapshot> userDataStream;

  @override
  void initState() {
    super.initState();
    userDataStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  List<Object?>? userDataList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: Container(
                padding:const EdgeInsets.symmetric(vertical: 10),
                child: const Text('User Data')),
          ),
          child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: userDataStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No user data available.'));
                }

                userDataList = snapshot.data!.docs
                    .map((documentSnapshot) => documentSnapshot.data())
                    .toList();

                return buildUserDataList(userDataList!, snapshot.data!.docs);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserDataList(List<Object?> userDataList, List<QueryDocumentSnapshot> documentSnapshots) {
    return ListView.builder(
      itemCount: userDataList.length,
      itemBuilder: (context, index) {
        var userData = userDataList[index] as Map<String, dynamic>?;
        var documentSnapshot = documentSnapshots[index];

        if (userData == null) {
          return const SizedBox(); // Handle the case where userData is null
        }

        final name = userData['name'] as String? ?? '';
        final gender = userData['gender'] as String ?? '';
        final email = userData['email'] as String? ?? '';

        return InkWell(
          onLongPress: () {
            _showOptionsDialog(context, index, documentSnapshot);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Image.asset('assets/logo.png',),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(email),
                    Text(gender),
                  ],
                ),
                trailing: CupertinoButton(
                  onPressed: (){
                  _showOptionsDialog(context, index, documentSnapshot);
                  },
                  child: Icon(Icons.more_vert_outlined, color: Colors.grey,),
              ),
            ),
          ),),
        );
      },
    );
  }

  Future<void> _showOptionsDialog(BuildContext context, int userIndex, QueryDocumentSnapshot documentSnapshot) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Options'),
          actions: <Widget>[
            Column(
              children: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    _showUpdateScreen(context, userIndex, documentSnapshot);
                  },
                  child: Text('Update'),
                ),
                Divider(thickness: 1,),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _deleteData(documentSnapshot);// Close the dialog
                  },
                  child: Text('Delete'),
                  isDestructiveAction: true,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUpdateScreen(BuildContext context, int userIndex, QueryDocumentSnapshot documentSnapshot) async {
    var userData = documentSnapshot.data() as Map<String, dynamic>?;
    var documentId = documentSnapshot.id;

    if (userData == null) {
      return;
    }

    String currentName = userData['name'] as String? ?? '';
    int currentAge = userData['age'] as int? ?? 0;
    String currentEmail = userData['email'] as String? ?? '';

    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => UpdateUserDataScreen(
          documentId: documentId,
          currentName: currentName,
          currentAge: currentAge,
          currentEmail: currentEmail,
        ),
      ),
    );
  }

  Future<void> _deleteData(QueryDocumentSnapshot documentSnapshot) async {
    var documentId = documentSnapshot.id;
    final collectionRef = FirebaseFirestore.instance.collection('users');
    try {
      await collectionRef.doc(documentId).delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

}
