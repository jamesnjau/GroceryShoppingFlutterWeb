import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:grocery_admin/services/firebase_services.dart';

class NewBoys extends StatefulWidget {
  @override
  _NewBoysState createState() => _NewBoysState();
}

class _NewBoysState extends State<NewBoys> {
  bool status = false;
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream:
              _services.boys.where('accVerified', isEqualTo: false).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            QuerySnapshot snap = snapshot.data;
            if (snap.size == 0) {
              return Center(child: Text('No new delivery boys to list'));
            }

            return SingleChildScrollView(
              child: DataTable(
                showBottomBorder: true,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: <DataColumn>[
                  DataColumn(label: Expanded(child: Text('Profile Pic'))),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Mobile')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Actions')),
                ],
                // rows: [
                //   DataRow(cells: [
                //     DataCell(Text('Name')),
                //     DataCell(Text('Name')),
                //     DataCell(Text('Name')),
                //     DataCell(Text('Name')),
                //     DataCell(Text('Name')),
                //     DataCell(Text('Name')),
                //   ]),
                // ],
                rows: _boysList(snapshot.data, context),
              ),
            );
          }),
    );
  }

  List<DataRow> _boysList(QuerySnapshot snapshot, context) {
    List<DataRow>? newList = snapshot.docs
        .map((DocumentSnapshot document) {
          if (document != null) {
            return DataRow(cells: [
              DataCell(
                Container(
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: document.data()['imageUrl'] == ''
                        ? Icon(
                            Icons.person,
                            size: 40,
                          )
                        : Image.network(
                            document.data()['imageUrl'],
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              DataCell(Text(document.data()['name'])),
              DataCell(Text(document.data()['email'])),
              DataCell(Text(document.data()['mobile'])),
              DataCell(Text(document.data()['address'])),
              DataCell(document.data()['mobile'] == ''
                  ? Text('Not Registered')
                  : FlutterSwitch(
                      activeText: 'Approved',
                      inactiveText: 'Not Approved',
                      value: document.data()['accVerified'],
                      valueFontSize: 10.0,
                      width: 110,
                      borderRadius: 30.0,
                      showOnOff: true,
                      onToggle: (val) {
                        _services.updateBoysStatus(
                            id: document.id, context: context, status: true);
                      })),
            ]);
          }
        })
        .cast<DataRow>()
        .toList();
    return newList;
  }
}
