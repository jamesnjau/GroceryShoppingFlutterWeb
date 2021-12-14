import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin/screens/admin_users.dart';
import 'package:grocery_admin/screens/category_screen.dart';
import 'package:grocery_admin/screens/manage_banners.dart';
import 'package:grocery_admin/screens/notification_screen.dart';
import 'package:grocery_admin/screens/order_screen.dart';
import 'package:grocery_admin/screens/settings_screen.dart';
import 'package:grocery_admin/services/sidebar.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';
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
      sideBar: _sideBar.sideBarMenus(context, HomeScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Dashboard',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          ),
        ),
      ),
    );
  }
}
