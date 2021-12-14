import 'dart:js';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  CollectionReference boys = FirebaseFirestore.instance.collection('boys');

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<DocumentSnapshot> getAdminCredentials(id) {
    var result = FirebaseFirestore.instance.collection('Admin').doc(id).get();
    return result;
  }

  //banner
  Future<String> uploadBannerImageToDb(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    // String downloadUrl = await storage.ref().child('logo.png').getDownloadURL();
    print('mydownload:$downloadUrl');
    if (downloadUrl != null) {
      firestore.collection('slider').add({
        'image': downloadUrl,
      });
    }

    return downloadUrl;
  }

  deleteBannerImageFromDb(id) async {
    firestore.collection('slider').doc(id).delete();
  }

  //vendor
  updateVendorStatus({id, status}) async {
    vendors.doc(id).update({'accVerified': status ? false : true});
  }

  updateTopPickedVendor({id, status}) async {
    vendors.doc(id).update({'isTopPicked': status ? false : true});
  }

  //Category
  Future<String> uploadCategoryImageToDb(url, catName) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      category.doc(catName).set({
        'image': downloadUrl,
        'name': catName,
      });
    }

    return downloadUrl;
  }

  Future<void> saveDeliveryBoys(email, password) async {
    boys.doc(email).set({
      'accVerified': false,
      'address': '',
      'email': email,
      'imageUrl': '',
      'location': GeoPoint(0, 0),
      'mobile': '',
      'name': '',
      'password': password,
      'uid': '',
    });
  }

  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  deleteBannerImageFromDb(id);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

//Update delivery boy approved status
  updateBoysStatus({id, context, status}) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Color(0xFF84c225).withOpacity(.3),
        animationDuration: Duration(milliseconds: 500));
    progressDialog.show();

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('boys').doc(id);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        return Exception('User does not exis');
      }
      transaction.update(documentReference, {'accVerified': status});
    }).then((value) {
      progressDialog.dismiss();
      showMyDialog(
          title: 'Delivery boy status',
          message: status == true
              ? 'Delivery boy approved status updated as Approved'
              : 'Delivery boy approved status updated as Not Approved',
          context: context);
    }).catchError((error) => showMyDialog(
          context: context,
          title: 'Delivery boy status',
          message: 'Delivery boy approved status updated as $error',
        ));
  }
}
