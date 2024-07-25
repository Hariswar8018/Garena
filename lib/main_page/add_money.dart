import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:garena/models/transaction.dart';
import 'package:page_transition/page_transition.dart';
import 'package:upi_payment_flutter/upi_payment_flutter.dart';
import 'package:garena/page/pay.dart' ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/login/login_screen.dart';
import 'package:garena/main_page/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garena/firebase_options.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/navigation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/login/login_screen.dart';
import 'package:garena/main.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:provider/provider.dart';

import 'add_money.dart';

class Add_Money extends StatefulWidget {
  bool bh ;
  Add_Money({super.key, required this.bh});

  @override
  State<Add_Money> createState() => _Add_MoneyState();
}

class _Add_MoneyState extends State<Add_Money> {
  List<CarouselItem> itemList = [
    CarouselItem(
      image: const NetworkImage(
        'https://images6.alphacoders.com/510/thumb-1920-510018.jpg',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title:
      'Push your creativity to its limits by reimagining this classic puzzle!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '\$51,046 in prizes',
      rightSubtitle: '4882 participants',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://images4.alphacoders.com/123/1232906.jpg',
      ),
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '11 Feb 2022',
      rightSubtitle: 'v1.0.0',
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://c4.wallpaperflare.com/wallpaper/507/613/171/video-game-conflict-desert-storm-ii-back-to-baghdad-wallpaper-preview.jpg',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title:
      'Push your creativity to its limits by reimagining this classic puzzle!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '\$51,046 in prizes',
      rightSubtitle: '4882 participants',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
  ];

  TextEditingController c = TextEditingController();

  final upiPaymentHandler = UpiPaymentHandler();

  String user = FirebaseAuth.instance.currentUser!.uid ;
  String go(double i){
    int jp=i.toInt();
    return jp.toString();
  }
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color : Colors.black
          ),
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( widget.bh ? "Add Money" : "Withdraw Money", style : TextStyle(color : Colors.black, fontSize : 17, fontWeight: FontWeight.w700)),
                Text( "Balance : ₹" + go(_user!.Won), style : TextStyle(color : Colors.black, fontSize : 13, fontWeight: FontWeight.w500))
              ],
            ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0), // Adjust the radius value as needed
                    topRight: Radius.circular(30.0), // Adjust the radius value as needed
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: CustomCarouselSlider(
                    items: itemList,
                    height: 190,
                    subHeight: 50,
                    width: MediaQuery.of(context).size.width - 10,
                    autoplay: true,
                    indicatorShape: BoxShape.circle,
                    showSubBackground: false,
                    autoplayDuration: Duration(seconds: 5),
                    showText: false,
                  ),
                ),
              ),
            ),
            SizedBox(height : 10),
            Text("     Enter the Amount ? ", style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: c,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '  Enter Amount',
                  isDense: true,
                  prefixText: "₹ ",
                  suffixIcon: InkWell(
                      onTap: () async {
                        if(widget.bh){
                          Navigator.push(
                              context, PageTransition(
                              child: Pay(amount: double.parse(c.text), str: "Playbees Order"), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                          ));
                        }else{
                          await showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                              title: new Text('Amount will be Debited'),
                              content: Text('You sure to Withdraw Money? Amount will be Reflected in your Account within 3-5 Days'),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () async {
                                    if(int.parse(c.text)<100){
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Minimum amount should be 100"),
                                        ),
                                      );
                                    }else if(_user.Won<int.parse(c.text)){
                                      print(int.parse(c.text));
                                      print(_user.Won);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('You have Less Amount than your Desiring Withdrawl'),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }else{
                                      print(int.parse(c.text));
                                      print(_user.Won);
                                      String g = DateTime
                                          .now()
                                          .millisecondsSinceEpoch
                                          .toString();
                                      TransactionModel h = TransactionModel(
                                          answer: false,
                                          name: _user!.Name,
                                          method: "UPI",
                                          rupees: double.parse(c.text),
                                          status: "Waiting",
                                          coins:int.parse(c.text),
                                          time: g,
                                          time2: g,
                                          nameUid: _user.uid,
                                          id: g,
                                          pic: _user.Pic_link,
                                          pay: true, transactionId:""
                                      );
                                      await FirebaseFirestore.instance
                                          .collection("Transaction").doc(g).set(h.toJson());
                                      double df=double.parse(c.text);
                                      await FirebaseFirestore.instance.collection("users").doc(_user.uid).update({
                                        "Won":FieldValue.increment(- df),
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Success ! It will be Withdrawl within 2-3 days'),
                                        ),
                                      );

                                      UserProvider _userprovider = Provider.of(context, listen: false);
                                      await _userprovider.refreshuser();
                                    }
                                  },
                                  child: new Text('YES'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: new Text('NO'),
                                ),
                              ],
                            ),
                          );
                        }

                      },
                      child: Icon(Icons.arrow_forward_outlined, size : 30)),
                  suffixIconColor: Colors.blueAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0), // Adjust the value as needed
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onFieldSubmitted: (value) async {
                  Navigator.push(
                      context, PageTransition(
                      child: Pay(amount: double.parse(c.text), str: "Playbees Order"), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("   Or Select Predefined Amount",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w700)),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                a(100.0, context),
                a(200.0, context),
              ],
            ),
            SizedBox(height : 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                a(500.0, context),
                a(1000.0, context),
              ],
            ),
            SizedBox(height : 16),

            Center(child: Image.network("https://www.shutterstock.com/image-vector/kerala-india-may-08-2023-260nw-2304421791.jpg", width : 250)),
          ],
        ),
      ),
    );
  }

  Widget a(
    double s, BuildContext context) {
    int gf = s.toInt() ;
    String str = gf.toString();
    double r = s + (5 / 100 * s);
    String coins = r.toString();
    String g = DateTime.now().microsecondsSinceEpoch.toString();
    return InkWell(
      onTap : (){
        setState((){
          c.text = str ;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 2 - 20,
          height: MediaQuery.of(context).size.width / 2 - 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),  child : Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text( "₹ " + str , style : TextStyle( fontWeight: FontWeight.w800, fontSize: 30))),
            ],
        ),
      )),
    );
  }

  String calculatePercentage(double d) {
    double percentage = 5 / 100 * d;
    String result = percentage.toStringAsFixed(0); // Adjust the decimal places as needed
    return result;
  }

  void _initiateTransaction(BuildContext context, double g) async {
    String s = DateTime.now().microsecondsSinceEpoch.toString();

  }
}

class Payments {
  Payments(
      {required this.id,
      required this.time,
      required this.status,
      required this.amount});

  late final String time;

  late final String amount;

  late final String id;

  late final String status;

  Payments.fromJson(Map<String, dynamic> json) {
    time = json['time'] ?? "88";
    amount = json['amount'] ?? "20";
    id = json['id'] ?? "56AJ";
    status = json['status'] ?? "Done";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time;
    data['amount'] = amount;
    data['id'] = id;
    data['status'] = status;
    return data;
  }
}
