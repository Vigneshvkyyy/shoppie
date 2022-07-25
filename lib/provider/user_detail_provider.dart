import 'package:flutter/material.dart';
import 'package:shoppie_app/resources/cloud_firestore_methods.dart';

import '../model/user_model.dart';

class UserDetailsProvider with ChangeNotifier {
  userDetailModel userDetails;

  UserDetailsProvider()
      : userDetails = userDetailModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
