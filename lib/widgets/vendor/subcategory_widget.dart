import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/services/firebase_services.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;
  SubCategoryWidget(this.categoryName);

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  FirebaseServices _services = FirebaseServices();
  var _subCatNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<DocumentSnapshot>(
              future: _services.category.doc(widget.categoryName).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong ..'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('No subcategories Added'),
                    );
                  }
                  Map<String, dynamic> data = snapshot.data!.data();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Main Category: '),
                                Text(
                                  widget.categoryName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 3,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //subcategory list
                        child: Expanded(
                          child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(data['subCat'][index]['name']),
                                );
                              },
                              itemCount: data['subCat'] == null
                                  ? 0
                                  : data['subCat'].length),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Divider(
                              thickness: 4,
                            ),
                            Container(
                              color: Colors.grey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add new Sub Category',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 30,
                                          child: TextField(
                                            controller:
                                                _subCatNameTextController,
                                            decoration: InputDecoration(
                                              hintText: 'Sub Category Name',
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                                  OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        color: Colors.black54,
                                        child: Text(
                                          'Save',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (_subCatNameTextController
                                              .text.isEmpty) {
                                            _services.showMyDialog(
                                              context: context,
                                              title: 'Add new SubCategory',
                                              message:
                                                  'Need to give subcategory name',
                                            );
                                          }
                                          DocumentReference doc = _services
                                              .category
                                              .doc(widget.categoryName);
                                          doc.update({
                                            'subCat': FieldValue.arrayUnion([
                                              {
                                                'name':
                                                    _subCatNameTextController
                                                        .text
                                              }
                                            ]),
                                          });
                                          //if you want to see the update real time
                                          setState(() {});
                                          //it will  rerun entire widget tree, so update will show
                                          //after update clear edittext
                                          _subCatNameTextController.clear();
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
