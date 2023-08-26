import 'package:firestore_example/screens/UploadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RetrieveData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cloud Firestore'),
      ),
      child: DefaultTabController(
        length: 2,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(label: 'Adding Data', icon: Icon(Icons.add)),
              BottomNavigationBarItem(label: 'Querying Data', icon: Icon(Icons.query_builder)),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) => const UploaduserData());
              case 1:
                return CupertinoTabView(builder: (context) => const RetrieveUserData());
              default:
                return CupertinoTabView(builder: (context) => const Center(child: Text('Placeholder')));
            }
          },
        ),
      ),
    );
  }
}
