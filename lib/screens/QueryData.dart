import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataQuery extends StatefulWidget {
  const DataQuery({Key? key});

  @override
  State<DataQuery> createState() => _DataQueryState();
}

class _DataQueryState extends State<DataQuery> {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController queryController = TextEditingController();
  TextEditingController limitController = TextEditingController();
  QuerySnapshot? querySnapshot;
  int totalCount = 0;
  bool orderByAscending = true;
  String selectedOrderBy = 'Order by Name';
  bool showAllGenders = false;
  bool showMale = false;
  bool showFemale = false;

  void fetchData(String query) async {
    Query filteredQuery = users.where('name', isGreaterThanOrEqualTo: query).where('name', isLessThan: query + 'z');

    if (!showAllGenders) {
      if (showMale) {
        filteredQuery = filteredQuery.where('gender', isEqualTo: 'Male');
      }
      if (showFemale) {
        filteredQuery = filteredQuery.where('gender', isEqualTo: 'Female');
      }
    }

    if (selectedOrderBy == 'Order by Name') {
      filteredQuery = filteredQuery.orderBy('name', descending: !orderByAscending);
    }

    int dataLimit = int.tryParse(limitController.text) ?? -1;

    if (dataLimit > 0) {
      filteredQuery = filteredQuery.limit(dataLimit);
    }

    final newQuerySnapshot = await filteredQuery.get();

    setState(() {
      querySnapshot = newQuerySnapshot;
      totalCount = querySnapshot!.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: queryController,
                      decoration: InputDecoration(
                        labelText: 'Enter the name',
                        border: OutlineInputBorder(),
                        suffixIcon:   PopupMenuButton<String>(
                          icon: Icon(Icons.filter_alt),
                          onSelected: (selectedOption) {
                            setState(() {
                              selectedOrderBy = selectedOption;
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return ['Order by Name'].map((String option) {
                              return PopupMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: limitController,
              decoration: InputDecoration(
                labelText: 'Data Limit',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Checkbox(
                  value: showAllGenders,
                  onChanged: (value) {
                    setState(() {
                      showAllGenders = value!;
                      if (showAllGenders) {
                        showMale = false;
                        showFemale = false;
                      }
                    });
                  },
                ),
                Text('Show All Genders'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: showMale,
                  onChanged: (value) {
                    setState(() {
                      showMale = value!;
                      if (showMale) {
                        showAllGenders = false;
                      }
                    });
                  },
                ),
                Text('Show Male Users'),
                SizedBox(width: 16),
                Checkbox(
                  value: showFemale,
                  onChanged: (value) {
                    setState(() {
                      showFemale = value!;
                      if (showFemale) {
                        showAllGenders = false;
                      }
                    });
                  },
                ),
                Text('Show Female Users'),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                fetchData(queryController.text);
              },
              child: Text('Get User'),
            ),
            Row(
              children: [
                Text(
                  'Total Count: ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '$totalCount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: querySnapshot == null
                  ? Center(child: Text('Enter a query and click Search.'))
                  : ListView.builder(
                itemCount: querySnapshot!.docs.length,
                itemBuilder: (context, index) {
                  var userData = querySnapshot!.docs[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoListTile(
                      title: Text(userData['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gender: ${userData['gender']}'),
                          Text('Email: ${userData['email']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
