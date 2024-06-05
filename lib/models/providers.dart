import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/models/user_model.dart';


class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get getUser => _user!;

  Future<void> refreshuser() async{
    UserModel user = await GetUser();
    _user = user;
    notifyListeners();

  }

  Future <UserModel> GetUser() async{
    String s = FirebaseAuth.instance.currentUser?.uid ?? "9LDf2qVAFtSVuiBQ06oNuMrNX5D3";
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users')
        .doc(s).get();
    return UserModel.fromSnap( snap );
  }
}


