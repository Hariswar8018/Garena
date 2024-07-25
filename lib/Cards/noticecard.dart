

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/models/notices.dart';
import 'package:garena/models/providers.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class Noticec extends StatefulWidget {
  Notice user ; String id ; bool admin;
  Noticec({super.key, required this.user, required this.id,required this.admin});

  @override
  State<Noticec> createState() => _NoticecState();
}

class _NoticecState extends State<Noticec> {

  bool teac() {
    UserModel? _user = Provider.of<UserProvider>(context, listen: false).getUser;
    if (_user!.Chess_Level == "Teacher") {
      return false;
    } else {
      return true;
    }
  }

  void as()async{
    if(teac()) {
      String s = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("Users").doc(s).update({
        "Notices": FieldValue.arrayUnion([widget.user.id]),
      });
      await FirebaseFirestore.instance.collection("Classroom").doc(widget.id)
          .collection("Notices")
          .doc(widget.user.id)
          .update({
        "follo": FieldValue.arrayUnion([s]),
      });
    }
  }
  void initState(){
    as();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width-20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Colors.blue,
              width: 1
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width-100,
                      child: Text(widget.user.name, style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w800),)),
                  SizedBox(width:15),
                  Spacer(),
                  InkWell(
                      onTap: () async {
                        if(widget.admin){
                          print("UUu");
                          await FirebaseFirestore.instance.collection("Notices").doc(widget.user.id).delete();
                        }
                      },
                      child: Icon(Icons.delete, color: Colors.red,))
                ],
              ),
              Text(widget.user.description, style: TextStyle(color: Colors.black, fontSize: 12),),
              Text(c(widget.user.date), style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
            ],
          ),
        ),
      ),
    );
  }
  String c(String dateTimeString) {
    // Parse the input string into a DateTime object
    try{
      // Parse the input string into an int and then to a DateTime object
      int millisecondsSinceEpoch = int.parse(dateTimeString);
      DateTime inputDateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      DateTime now = DateTime.now();

      // Calculate the difference
      Duration difference = now.difference(inputDateTime);

      if (difference.inMinutes < 1) {
        return "Recently";
      } else if (difference.inMinutes >= 1 && difference.inMinutes < 60) {
        return difference.inMinutes.toString() + " min ago";
      } else if (difference.inHours >= 1 && difference.inHours < 24) {
        return difference.inHours.toString() + " hours ago";
      } else if (difference.inDays >= 1 && difference.inDays < 30) {
        return difference.inDays.toString() + " days ago";
      } else {
        return "Long Time ago";
      }
    }catch(e){
      return "Long Time ago";
    }
  }
}
