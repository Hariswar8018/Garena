
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garena/models/user_model.dart';
import 'package:garena/other/before.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../models/transaction.dart';

class ChatUserW extends StatefulWidget {
  TransactionModel user;bool admin;

  ChatUserW({required this.user,required this.admin});

  @override
  State<ChatUserW> createState() => _ChatUserWState();
}

class _ChatUserWState extends State<ChatUserW> {
  @override
  Widget build(BuildContextcontext) {
    return !widget.admin? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(

          title: Text(widget.user.pay?"Amount Debited":"Amount Credited",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19)),
          subtitle: Text("Requested on : " + formatDateTime(widget.user.id),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
          trailing: Text(" +  ₹" + widget.user.rupees.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 18, color: widget.user.pay?Colors.red:Colors.green)),
        ),
        widget.user.answer?Padding(
          padding: const EdgeInsets.only(bottom:8.0),
          child: Text("      Answered on : "+formatDateTime(widget.user.time2),
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        ):SizedBox(),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.red,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(widget.user.status=="Waiting"?"Status : Waiting for Confirmation":"Status : "+widget.user.status,style:TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
        ),
        SizedBox(height: 10,),
      ],
    ): InkWell(
      onTap: (){
        openn();
      },
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !widget.user.pay?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Transaction Id : "+widget.user.transactionId,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19)),
            ):SizedBox(),
            ListTile(
              onTap: () async {
                try {
                  // Reference to the 'users' collection
                  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                  // Query the collection based on uid
                  QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: widget.user.nameUid).get();
                  // Check if a document with the given uid exists
                  if (querySnapshot.docs.isNotEmpty) {
                    // Convert the document snapshot to a UserModel
                    UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
                    Navigator.push(
                        context, PageTransition(
                        child: Before_Update(user:user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 500)
                    ));
                  } else {
                    // No document found with the given uid
                    print("Empty");
                  }
                } catch (e) {
                  print("Error fetching user by uid: $e");
                  return null;
                }
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.pic),
              ),
              title: Text(widget.user.name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19)),
              subtitle: Text("Credited from " + widget.user.id,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
              trailing: Icon(Icons.arrow_forward_ios_rounded,color:Colors.blue),
            ),
            ListTile(
              title: Text(widget.user.pay?"Amount Debited":"Amount Credited",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19,color:widget.user.pay?Colors.red:Colors.green)),
              subtitle: Text("Requested on : " + formatDateTime(widget.user.id),
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
              trailing: Text(" +  ₹" + widget.user.rupees.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 18, color: widget.user.pay?Colors.red:Colors.green)),
            ),
            widget.user.answer?Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Text("      Answered on : "+formatDateTime(widget.user.time2),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            ):SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.user.status=="Waiting"?"Status : Waiting for Confirmation":"Status : "+widget.user.status,style:TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  String formatDateTime(String s) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(s));
    DateFormat dateFormat = DateFormat('dd:MM:yy \'at\' HH:mm');
    return dateFormat.format(dateTime);
  }
  TextEditingController c = TextEditingController();
  void donee(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          child: SizedBox(
            height: 630,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Icon(Icons.verified_rounded,size:100,color:Colors.green),
                  Text("Submit Transaction ID",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(textAlign: TextAlign.center,"Submit the Transaction ID"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: c,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: ' Enter Reference Transaction ID',
                        isDense: true,
                        suffixIconColor: Colors.blueAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0), // Adjust the value as needed
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height:10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SocialLoginButton(
                      backgroundColor:  Color(0xff6001FF),
                      height: 40,
                      text: 'Mark as Done Payment',
                      borderRadius: 20,
                      fontSize: 21,
                      buttonType: SocialLoginButtonType.generalLogin,
                      onPressed: () async {
                        String g = DateTime
                            .now()
                            .millisecondsSinceEpoch
                            .toString();
                        await FirebaseFirestore.instance.collection("Transaction").doc(widget.user.id).update({
                          "status":"Approve",
                          "time2":g,
                          "answer":true,
                          "coins":(widget.user.rupees).toInt(),
                          "transactionId":c.text
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void openn(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          child: SizedBox(
            height: 550,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  SizedBox(
                    height: 26,
                  ),
                  widget.user.pay?ListTile(
                    onTap: (){
                      donee();
                    },
                    leading: Icon(Icons.all_inclusive),
                    title: Text("Approve Payment",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
                    subtitle: Text("Approve that the Transaction was Successfull"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ): ListTile(
                    onTap: (){
                      setState(() async {
                        String g = DateTime
                            .now()
                            .millisecondsSinceEpoch
                            .toString();
                        await FirebaseFirestore.instance.collection("Transaction").doc(widget.user.id).update({
                          "status":"Approve",
                          "time2":g,
                          "answer":true,
                          "coins":(widget.user.rupees).toInt(),
                        });
                        await FirebaseFirestore.instance.collection("users").doc(widget.user.nameUid).update({
                          "Won":FieldValue.increment(widget.user.rupees),
                          "deposit":FieldValue.increment(widget.user.rupees),
                        });
                        Navigator.pop(context);
                      });
                    },
                    leading: Icon(Icons.all_inclusive),
                    title: Text("Approve / Give Coins",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
                    subtitle: Text("Approve that the Transaction was Successfull, and Pay the Coins"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  r("Reject",Icon(Icons.sunny,color:Colors.red)),
                  r("Reject with Suspicious Act",Icon(Icons.sunny_snowing,color:Colors.orange)),
                  r("Ask for Clarification",Icon(Icons.nightlight,color:Colors.black)),
                  SizedBox(height:10)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget r(String str,Widget rt){
    return ListTile(
      onTap: () async {
        String g = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        await FirebaseFirestore.instance.collection("Transaction").doc(widget.user.id).update({
          "status":str,
          "time2":g,
          "answer":true,
        });
        Navigator.pop(context);
      },
      leading: rt,
      title: Text(str,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
      subtitle: Text("$str the Transaction"),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}