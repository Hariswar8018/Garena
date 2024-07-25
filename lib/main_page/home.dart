import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:garena/Cards/Games_Cards.dart';
import 'package:garena/Cards/All_Game_Cards.dart';
import 'package:garena/main_page/wallet.dart';
import 'package:garena/main_page/my_battle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:garena/main.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:garena/page/add_notify.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  String hh(double h) {
    double myDouble = h;

    // Convert double to string with no decimal places
    String myString = myDouble.toStringAsFixed(0);
    return myString;
  }

  bool pc = false ;

  bool mo = true ;
bool tb = false ;
  void asyyy(){
    setState((){
      pc = false ;
      mo = false ;
      tb = false ;
    });
  }

  Widget asyy( BuildContext context, bool v, String st, Widget a){
    return Container(
      height : 50,
      decoration : BoxDecoration(
        color : v ? Color(0xffB39BE5) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15), // Circular border radius
        border: Border.all(
          color: Color(0xffB39BE5), // Border color
          width: 3, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // Spread radius
            blurRadius: 7, // Blur radius
            offset: Offset(0, 3), // Shadow offset
          ),
        ],
      ),
      child : Padding(
        padding: const EdgeInsets.only( top : 4, bottom : 4, left : 9, right : 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [
            a,
            SizedBox(width : 5),
            Text(st, style : TextStyle(fontWeight : FontWeight.w800, fontSize : 13))
          ]
        ),
      )
    );
  }
bool mobile = true ;
  String tofind = "Mobile";
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
            backgroundColor: Colors.transparent,
            leading: Image.asset("assets/logo-Photoroom.png"),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back,",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
                Text("Playbees",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Wallet()),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(children: [
                        SizedBox(width: 9),
                        Text("₹",
                            style:
                            TextStyle(fontWeight: FontWeight.w900, fontSize: 22,color:Colors.orange)),
                        SizedBox(width: 3),
                        Text(hh(_user!.Won),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w900)),
                        SizedBox(width: 10),
                      ]),
                    )),
              ),
              IconButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Not(viewonly:true, id: '', str: '', b: true,)),
                );
              }, icon: Icon(Icons.notifications_rounded, color : Colors.red,size: 30,)),
              SizedBox(width: 8),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0), // Adjust the radius value as needed
                        topRight: Radius.circular(10.0), // Adjust the radius value as needed
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: CustomCarouselSlider(
                        items: itemList,
                        height: 190,
                        subHeight: 50,
                        width: MediaQuery.of(context).size.width - 10,
                        autoplay: true,indicatorPosition: IndicatorPosition.bottom,boxPaddingVertical: 4,
                        indicatorShape: BoxShape.circle,dotSpacing: 9,
                        showSubBackground: false,
                        autoplayDuration: Duration(seconds: 5),
                        showText: false,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: (){
                          asyyy();
                          setState((){
                            mo = true ;
                            mobile = true;
                            tofind="Mobile";
                          });
                        },
                        child: asyy( context, mo , "MOBILE", Icon(Icons.mobile_friendly_sharp, size : 16, color : mo ? Colors.yellow : Colors.black))),
                    InkWell(
                        onTap: (){
                          asyyy();
                          setState((){
                            tb = true ;
                            mobile = false;
                            tofind="PC";
                          });
                        },
                        child: asyy( context, tb , "COMPUTER", Icon(Icons.computer, size : 16, color : tb ? Colors.yellow : Colors.black))),
                    InkWell(onTap: (){
                      asyyy();
                      setState((){
                        pc = true ;
                        mobile = false;
                        tofind="Emulator";
                      });
                    }, child: asyy( context, pc , "EMULATOR", Icon(Icons.calculate, size : 16, color : pc ? Colors.yellow : Colors.black))),
                  ],
                ),
                SizedBox(height: 10),
                tofind=="PC"? mk(context, "Valorant", "EASY", "Valorant"):SizedBox(),
                SizedBox(height: 5),
                tofind =="PC"? hjg(context, "Valorant"):SizedBox(),
                SizedBox(height: 20),
                tofind!="PC"?mk(context, "BGMI", "EASY", "BGMI"):SizedBox(),
                SizedBox(height: 5),
                tofind!="PC"?hjg(context, "BGMI"):SizedBox(),
                SizedBox(height: 20),
                tofind!="PC"?mk(context, "New State", "EASY", "New State"):SizedBox(),
                SizedBox(height: 5),
                tofind!="PC"?hjg(context, "New State"):SizedBox(),
                SizedBox(height: 20),
                tofind!="PC"?mk(context, "Free Fire", "EASY", "Free Fire"):SizedBox(),
                SizedBox(height: 5),
                tofind!="PC"?hjg(context, "Free Fire"):SizedBox(),
                SizedBox(height: 20),
                tofind!="PC"?mk(context, "Call of Duty", "EASY", "Call of  Duty"):SizedBox(),
                SizedBox(height: 1),
                tofind!="PC"?hjg(context, "Duty"):SizedBox(),
                SizedBox(height: 20),

              ],
            ),
          )),
    );
  }

  Widget mk(BuildContext context, String str, String glevel, String gname) {
    return Padding(
      padding: const EdgeInsets.only( top : 14.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Text("   $str",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 19,
                      fontWeight: FontWeight.w900)),
              Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllG(
                                glevel: glevel,
                                gname: gname, typei: tofind,
                              )),
                    );
                  },
                  child: Text("Show More",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w700))),
              SizedBox(width: 20)
            ],
          )),
    );
  }

  Widget hjg(BuildContext context, String g9) {
    List<SessionModel> list = [];

    late Map<String, dynamic> userMap;
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(g9).where("modes",arrayContains: tofind).snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data
                        ?.map((e) => SessionModel.fromJson(e.data()))
                        .toList() ??
                    [];
                if (list.isEmpty) {
                  return Center(child: Text("Games Coming Soon"));
                } else {
                  return ListView.builder(
                    itemCount: list.length > 5 ? 5 : list.length,
                    padding: EdgeInsets.only(left: 1, right: 18),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index ) {
                      return ChatUser(user: list[index], str: "BGMI");
                    },
                  );
                }
            }
          }),
    );
  }

  Widget aa(BuildContext context, String str, String image) {
    return Container(
      height: MediaQuery.of(context).size.width / 3 - 5,
      width: MediaQuery.of(context).size.width / 3 - 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        Container(
            width: MediaQuery.of(context).size.width / 3 - 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.orange,
            ),
            child: Center(
                child: Text(str,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14))))
      ]),
    );
  }

  Widget a(BuildContext context, String str, bool bhh, bool bhj) {
    return Container(
      height: MediaQuery.of(context).size.width / 3 - 5,
      width: MediaQuery.of(context).size.width / 3 - 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        bhh
            ? (bhj
                ? Icon(Icons.event_available_outlined,
                    size: 65, color: Colors.blueAccent)
                : Icon(Icons.timelapse_outlined,
                    size: 65, color: Colors.blueAccent))
            : Icon(Icons.verified_outlined, size: 65, color: Colors.blueAccent),
        SizedBox(height: 5),
        Text(str, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))
      ]),
    );
  }
}

class ChatUser extends StatelessWidget {
  SessionModel user;
  String str;

  ChatUser({required this.user, required this.str});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Gamy(
                      gname: str,
                      glevel: user.Name,
                    )),
          );
        },
        child: Container(
          height: 140,
          width: 120,
          child: Column(
            children: [
              Container(
                height: 115,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(user.pic),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(height : 4),
              Text(user.Name, style : TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
