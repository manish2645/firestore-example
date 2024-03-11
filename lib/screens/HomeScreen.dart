import 'package:firestore_example/screens/QueryData.dart';
import 'package:firestore_example/screens/UploadData.dart';
import 'package:firestore_example/screens/RetrieveData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cloud Firestore'),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(label: 'Adding Data', icon: Icon(Icons.add)),
            BottomNavigationBarItem(label: 'Display data', icon: Icon(Icons.note)),
            BottomNavigationBarItem(label: 'Querying Data', icon: Icon(Icons.query_builder)),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) => UploadUserData(onDataUploaded: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data uploaded successfully'),
                    ),
                  );
                }),
              );
            case 1:
              return CupertinoTabView(builder: (context) => RetrieveUserData());
            case 2:
              return CupertinoTabView(builder: (context) => DataQuery());
            default:
              return CupertinoTabView(builder: (context) => Center(child: Text('Placeholder')));
          }
        },
      ),
    );
  }
}
