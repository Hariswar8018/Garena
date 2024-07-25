import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:garena/models/transaction.dart';
import 'package:garena/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';
import 'package:flutter_upi_pay/flutter_upi_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/providers.dart';

class Pay extends StatefulWidget {
  double amount; String str;
  Pay({super.key,required this.amount,required this.str});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  late final upiDetails;
  FlutterPayment flutterPayment = FlutterPayment();

  @override
  void initState() {
    upiDetails = UPIDetails(upiID: "kushankkm9535-2@okhdfcbank", payeeName: "KUSHANK K M", amount: widget.amount);
    super.initState();
    startTimer();
  }

  @override
  void dispose() {

    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;
  int _start = 600; // 10 minutes in seconds

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer.cancel();
          // Call your function here
          onTimerComplete();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void onTimerComplete() {
    Navigator.pop(context);
    print('Timer completed');
  }


bool phonepe=false;
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    String time = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return Container(
      width: MediaQuery.of(context).size.width,
      height : MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/Screenshot_2024-01-20-14-04-58-25_8ee8015dd2b473d44c46c2d8d6942cec.jpg")
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Payment Progress", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          body:SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Use PhonePe Scan"),
                    CupertinoSwitch(
                      value: phonepe,
                      onChanged: (value) {
                        setState(() {
                          phonepe = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                phonepe?Container(
                  height: 200,width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/photo_2024-07-17_14-13-43.jpg"),
                      fit: BoxFit.cover
                    )
                  ),
                ):
                Center(
                  child: UPIPaymentQRCode(
                    upiDetails: upiDetails,
                    size: 200,
                    embeddedImagePath: 'assets/Untitled design.png',
                    embeddedImageSize: const Size(60, 60),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: Text(
                    "Complete Payment before : " + time,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context)
                        .size
                        .width-100,
                    height: 40,
                    child: ElevatedButton(
                     onPressed: (){
                       flutterPayment.launchUpi(
                           name: "KUSHANK K M",
                           amount: widget.amount.toString(),
                           message:widget.str,upiId: "kushankkm9535-2@okhdfcbank",
                           currency: "INR");
                     },
                      child: Text("Launch UPI App",
                          style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.purple.shade100),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Text("Aleady Done Payment ?",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(textAlign: TextAlign.center,"Please Paste the 12 Digit Transaction ID of Payment, and we will verify within 3-5 Business Days",style:TextStyle(fontWeight: FontWeight.w500)),
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
                Padding(
                  padding: const EdgeInsets.only(left:18.0,right:18,top:10),
                  child: SocialLoginButton(
                    backgroundColor:!(c.text.length>=12&&c.text.length<=24)?Colors.grey: Color(0xff6001FF),
                    height: 40,
                    text: 'Submit',
                    borderRadius: 20,
                    fontSize: 21,
                    buttonType: SocialLoginButtonType.generalLogin,
                    onPressed: () async {
                      if(c.text.length>=12&&c.text.length<=24){
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 550,
                              child: SizedBox(
                                height: 550,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:  <Widget>[
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Icon(Icons.warning,size:100,color:Colors.blue),
                                      Text("Submit Your Details",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(textAlign: TextAlign.center,"We will took as soon as 1 hour and max 3 days to Verify your Payment "),
                                      ),
                                      SizedBox(height:10),
                                      ListTile(
                                        leading: Icon(Icons.warning,color:Colors.red),
                                        title: Text("Don't Submit Double Transaction Request",style:TextStyle(color:Colors.red)),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.warning,color:Colors.red),
                                        title: Text("The Transaction must be done Today ",style:TextStyle(color:Colors.red)),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.warning,color:Colors.red),
                                        title: Text("The Amount must be Equal to specified above",style:TextStyle(color:Colors.red)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SocialLoginButton(
                                          backgroundColor:  Color(0xff6001FF),
                                          height: 40,
                                          text: 'Yes ! Submit my Transaction',
                                          borderRadius: 20,
                                          fontSize: 21,
                                          buttonType: SocialLoginButtonType.generalLogin,
                                          onPressed: () async {
                                            try {
                                              String g = DateTime
                                                  .now()
                                                  .millisecondsSinceEpoch
                                                  .toString();
                                              TransactionModel h = TransactionModel(
                                                  answer: false, name: _user!.Name,method: "UPI",
                                                  rupees: widget.amount, status: "Waiting", coins: 0,
                                                  time: g, time2: g, nameUid: _user.uid, id: g,
                                                  pic: _user.Pic_link,pay: false, transactionId: c.text
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection("Transaction").doc(
                                                  g).set(h.toJson());
                                              UserProvider _userprovider = Provider.of(context, listen: false);
                                              await _userprovider.refreshuser();
                                              Navigator.pop(context);
                                              donee();
                                            }catch(e){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text("The Transaction ID must be 12 Digit"),
                                                ),
                                              );
                                            }
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
                      }else{
                        print(c.text.length);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("The Transaction ID must be 12 Digit"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  void donee(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: SizedBox(
            height: 550,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Icon(Icons.verified_rounded,size:100,color:Colors.green),
                  Text("Submitted",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(textAlign: TextAlign.center,"Thank You ! We will took as soon as 1 hour and max 3 days to Verify your Payment "),
                  ),
                  SizedBox(height:10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SocialLoginButton(
                      backgroundColor:  Color(0xff6001FF),
                      height: 40,
                      text: 'Done Payment',
                      borderRadius: 20,
                      fontSize: 21,
                      buttonType: SocialLoginButtonType.generalLogin,
                      onPressed: ()async{

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        UserProvider _userprovider = Provider.of(context, listen: false);
                        await _userprovider.refreshuser();
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
  TextEditingController c = TextEditingController();
}
