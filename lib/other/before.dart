import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garena/Cards/transaction_card.dart';
import 'package:garena/main_page/history.dart';
import 'package:garena/main_page/wallet.dart';
import 'package:garena/models/transaction.dart';
import 'package:garena/models/user_model.dart';
import 'package:garena/other/after.dart';
import 'package:page_transition/page_transition.dart';

import 'package:image_picker/image_picker.dart';

import '../models/upload.dart';


class Before_Update extends StatefulWidget {
  UserModel user;
  Before_Update({super.key,required this.user});

  @override
  State<Before_Update> createState() => _Before_UpdateState();
}

class _Before_UpdateState extends State<Before_Update> {
  initState() {
    super.initState();

  }
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
    List<TransactionModel> list = [];
  String go(double i){
    int jp=i.toInt();
    return jp.toString();
  }
    late Map<String, dynamic> userMap ;
  @override
  Widget build(BuildContext context) {
    String s = FirebaseAuth.instance.currentUser!.uid ;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color:Colors.black
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.user!.Pic_link,
                  ),
                  minRadius: 50,
                  maxRadius: 60,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(" Your Coins :  ₹"+go(widget.user.Won)+" ",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap:(){
                  Clipboard.setData(
                      new ClipboardData(text: widget.user!.uid));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copied to ClipBoard'),
                    ),
                  );
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(" My ID : "+widget.user.uid+" ",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 13,color:Colors.white)),
                        ),
                      ),
                      Icon(Icons.copy)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              ListTile(
                onTap: ()async{
                  Uint8List? _file = await pickImage(ImageSource.gallery);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Uploading Please wait"),
                    ),
                  );
                  String photoUrl =  await StorageMethods().uploadImageToStorage('Users', _file!, true);
                  await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
                    "Pic_link":photoUrl,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Done ! Updated in few seconds"),
                    ),
                  );
                },
                leading: Icon(Icons.account_circle_sharp, color: Colors.black, size: 30,),
                title: Text("Update Profile Picture"),
                splashColor: Colors.orange.shade200, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.redAccent, size: 30),
                title: Text(widget.user.Name),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Name', doc: s, Firebasevalue: 'Name', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Name"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.greenAccent, size: 30),
                title: Text(widget.user.Email),
                onTap: () {
                  /*Navigator.push(
                      context, PageTransition(
                      child: Teacher_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));*/
                },
                subtitle: Text("Your Email ( can't be changed )"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.credit_card, color: Colors.redAccent, size: 30),
                title: Text(widget.user.Chess_Level),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Your UPI ID', doc: s, Firebasevalue: 'Chess_Level', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your UPI Id for Receiving Money ( Name must Match )"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("   Transaction History",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 19,
                          fontWeight: FontWeight.w400)),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: History(st:widget.user.uid),
                                type: PageTransitionType.leftToRight,
                                duration: Duration(milliseconds: 100)));
                      },
                      child: Text("Show All",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700))),
                  SizedBox(width: 20)
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 2,
                child: SizedBox(),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 460,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Transaction").where("nameUid",isEqualTo: widget.user.uid)
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
                                    user: list[index],admin:false
                                );
                              },
                            );
                          }
                      }
                    }),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
