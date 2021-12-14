import 'package:flutter/material.dart';
import 'package:grocery_admin/screens/HomeScreen.dart';
import 'package:grocery_admin/screens/admin_users.dart';
import 'package:grocery_admin/screens/category_screen.dart';
import 'package:grocery_admin/screens/delivery_boy_screen.dart';
import 'package:grocery_admin/screens/login_screen.dart';
import 'package:grocery_admin/screens/manage_banners.dart';
import 'package:grocery_admin/screens/order_screen.dart';
import 'package:grocery_admin/screens/settings_screen.dart';
import 'package:grocery_admin/screens/splash_screen.dart';
import 'package:grocery_admin/screens/vendor_screen.dart';

import 'screens/notification_screen.dart';

// flutter run --no-sound-null-safety --web-renderer html
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery App admin Dash Board',
      theme: ThemeData(
        primaryColor: Color(0xFF84C225),
      ),
      home: SplashScreen(),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        BannerScreen.id: (context) => BannerScreen(),
        CategoryScreen.id: (context) => CategoryScreen(),
        OrderScreen.id: (context) => OrderScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        AdminUsers.id: (context) => AdminUsers(),
        SettingsScreen.id: (context) => SettingsScreen(),
        VendorScreen.id: (context) => VendorScreen(),
        DeliveryBoyScreen.id: (context) => DeliveryBoyScreen(),
      },
    );
  }
}
