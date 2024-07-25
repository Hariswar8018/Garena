import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/transaction_card.dart';
import 'package:garena/login/login_screen.dart';
import 'package:garena/main.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/transaction.dart';
import 'package:garena/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'add_money.dart';

class History extends StatelessWidget {
  String st;
  History({super.key,required this.st});

  List<TransactionModel> list = [];

  late Map<String, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/Screenshot_2024-01-20-14-04-58-25_8ee8015dd2b473d44c46c2d8d6942cec.jpg")),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            automaticallyImplyLeading: true,
            title: Text(
              "My Transaction History",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            elevation: 0,
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Transaction").where("nameUid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    list = data
                        ?.map((e) => TransactionModel.fromJson(e.data()))
                        .toList() ??
                        [];
                    if (list.isEmpty) {
                      return Center(child: Text("No Transaction to show"));
                    } else {
                      return ListView.builder(
                        itemCount: list.length,
                        padding: EdgeInsets.only(top: 1),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatUserW(
                            user: list[index],admin:false,
                          );
                        },
                      );
                    }
                }
              }),
        ));
  }
}
