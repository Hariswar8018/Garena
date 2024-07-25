import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/transaction_card.dart';
import 'package:garena/main.dart';
import 'package:garena/main_page/add_money.dart';
import 'package:garena/models/transaction.dart';

import '../main_page/wallet.dart';

class Transaction extends StatefulWidget {
   Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<TransactionModel> list = [];

   bool on =  true;
String st="jhu";
   Widget r(String str,Widget rt){
     return ListTile(
       onTap: (){
         setState((){
           on=false;
           st=str;
         });
       },
       leading: rt,
       title: Text(str,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
       subtitle: Text("View all $str Games with Filter"),
       trailing: Icon(Icons.arrow_forward_ios),
     );
   }

  late Map<String, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title : Text("Your Transactions", style : TextStyle(color : Colors.white)),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: SizedBox(
                    height: 500,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  <Widget>[
                          SizedBox(
                            height: 16,
                          ),
                          r("Waiting",Icon(Icons.sunny,color:Colors.red)),
                          r("Approve",Icon(Icons.sunny,color:Colors.red)),
                          r("Reject",Icon(Icons.sunny_snowing,color:Colors.orange)),
                          r("Reject with Suspicious Act",Icon(Icons.nightlight,color:Colors.black)),
                          r("Ask for Clarification",Icon(Icons.sunny_snowing,color:Colors.orange)),
                          SizedBox(height:10)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }, icon: Icon(Icons.filter_alt_sharp)),
          SizedBox(width: 10,)
        ],
      ),
      body : StreamBuilder(
          stream:
          on?FirebaseFirestore.instance.collection("Transaction").snapshots():
          FirebaseFirestore.instance.collection("Transaction").where("status",isEqualTo: st).snapshots(),
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
                      return ChatUserW(
                        user: list[index],admin: true,
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
