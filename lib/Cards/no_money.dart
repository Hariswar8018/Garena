import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/login/login_screen.dart';
import 'package:garena/main.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:provider/provider.dart';

class No_M extends StatelessWidget {
  const No_M({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body : Column(
        children: [
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: SizedBox(),
          ),
          Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: 130,
              child: Center(
                child: Row(
                  children: [
                    Spacer(),
                    Icon(Icons.currency_bitcoin,
                        color: Colors.orangeAccent, size: 80),
                    Text(_user!.Won.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 43,
                            fontWeight: FontWeight.w900)),
                    Spacer(),
                  ],
                ),
              )),
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  a(context, "Deposited"),
                  a(context, "Winning"),
                  a(context, "Bonus"),
                ]),
          ),
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: SizedBox(),
          ),
          SizedBox(height : 50),
          Text("   Match Entry Fee per Player :   ",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w800)),
          Text("   You don't have sufficent Funds   ",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
        ],
      )
    );
  }
  Widget a(BuildContext context, String str) {
    return Container(
      height: MediaQuery.of(context).size.width / 3 - 5,
      width: MediaQuery.of(context).size.width / 3 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.monetization_on, size: 35, color: Colors.orange),
            label: Text("0",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
        SizedBox(height: 5),
        Text(str, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
      ]),
    );
  }
}
