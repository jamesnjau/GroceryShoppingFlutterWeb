import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin/services/sidebar.dart';
import 'package:grocery_admin/widgets/banner/banner_upload_widget.dart';
import 'package:grocery_admin/widgets/banner/banner_widget.dart';

class BannerScreen extends StatelessWidget {
  static const String id = 'banner-screen';

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
      sideBar: _sideBar.sideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Banner Screen',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              ),
              Text('Add / Delete Home Screen Banner Images'),
              Divider(
                thickness: 5,
              ),
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              BannerUploadWidget()
            ],
          ),
        ),
      ),
    );
  }
}
