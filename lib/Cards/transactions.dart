import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garena/main.dart';
import 'package:garena/main_page/add_money.dart';

import '../main_page/wallet.dart';

class Transaction extends StatelessWidget {
   Transaction({super.key});
  List<Payments> list = [];

  late Map<String, dynamic> userMap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title : Text("Your Transactions", style : TextStyle(color : Colors.white)),

      ),
      body : StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection('users').doc(user).collection("Transaction").snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data
                    ?.map((e) => Payments.fromJson(e.data()))
                    .toList() ??
                    [];
                if(list.isEmpty){
                  return Center(
                      child : Text("No Transaction to show")
                  );
                }else{
                  return ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(top: 1),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUser(
                        user: list[index],
                      );
                    },
                  );
                }
            }
          }
      ),
    );
  }
}
