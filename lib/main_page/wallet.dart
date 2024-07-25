import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/transaction_card.dart';
import 'package:garena/login/login_screen.dart';
import 'package:garena/main.dart';
import 'package:garena/main_page/history.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/transaction.dart';
import 'package:garena/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'add_money.dart';

class Wallet extends StatelessWidget {
  Wallet({super.key});

  List<TransactionModel> list = [];

  late Map<String, dynamic> userMap ;

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
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
          automaticallyImplyLeading: false,
          title: Text(
            "My Wallet",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2 + 60,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("₹",
                                          style:
                                          TextStyle(fontWeight: FontWeight.w900, fontSize: 40)),
                                      Text(((_user!.Won).toInt()).toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 40))
                                    ],
                                  ),
                                  Text("Available Balance",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13)),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 94,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("₹",
                                          style:
                                          TextStyle(fontWeight: FontWeight.w900, fontSize: 29)),
                                      Text(((_user!.bonus).toInt()).toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 24))
                                    ],
                                  ),
                                  Text("Bonus Points",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13)),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      g(
                          "Deposited",
                          _user!.deposit,
                          Icon(Icons.diamond, color: Colors.orange),
                          context),
                      g(
                          "Utilized",
                          _user!.utilize,
                          Icon(Icons.diamond, color: Colors.orange),
                          context),
                      g(
                          "Winned",
                          _user!.win,
                          Icon(Icons.diamond, color: Colors.orange),
                          context),
                    ],
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              child: SizedBox(),
            ),
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
                              child: History(st:FirebaseAuth.instance.currentUser!.uid),
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
                                user: list[index],admin:false
                              );
                            },
                          );
                        }
                    }
                  }),
            ),
          ],
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(left:35.0,right:35),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color:Colors.black,
                  width:1,
                ),borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 35,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:  Color(0xffB39BE5)
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Add_Money(
                                        bh: true,
                                      )),
                            );
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, double.infinity)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Adjust the radius as needed
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xffB39BE5)),
                          ),
                          child:
                              Text("Deposit", style: TextStyle(color: Colors.white))),
                    ),
                    Container(
                        height: 35,
                        width: 105,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  Size(double.infinity, double.infinity)),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Adjust the radius as needed
                                ),
                                // Change background color here
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xffB39BE5)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Add_Money(
                                          bh: false,
                                        )),
                              );
                            },
                            child: Text("WithDraw",
                                style: TextStyle(color: Colors.white))))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
            icon: Icon(Icons.diamond, size: 35, color: Colors.orange),
            label: Text("0",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
        SizedBox(height: 5),
        Text(str, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
      ]),
    );
  }

  Widget aa(BuildContext context, String str) {
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
            icon: Icon(Icons.diamond, size: 35, color: Colors.orange),
            label: Text("0",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
        SizedBox(height: 5),
        Text(str, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
      ]),
    );
  }

  Widget g(String h, double j, Widget a, BuildContext context) {
    int o = j.toInt();
    return Container(
        width: MediaQuery.of(context).size.width / 3 - 20,
        height: MediaQuery.of(context).size.width / 3 - 35,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("₹",
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 29)),
                  Text(" $o",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 22))
                ],
              ),
              SizedBox(height: 10),
              Text(h,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15))
            ],
          ),
        ));
  }
}

