import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin/services/sidebar.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = 'settings-screen';

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Grocery App DashBoard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      sideBar: _sideBar.sideBarMenus(context, SettingsScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          ),
        ),
      ),
    );
  }
}
