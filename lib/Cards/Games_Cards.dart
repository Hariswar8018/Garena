import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:garena/Cards/no_money.dart';
import 'package:garena/Cards/single_card.dart';
import 'package:garena/main_page/add_money.dart';
import 'package:garena/main_page/wallet.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:garena/other/result.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:garena/models/game_models.dart' ;
import 'package:image_picker/image_picker.dart' ;
import 'package:provider/provider.dart' ;
import 'package:social_login_buttons/social_login_buttons.dart' ;
import 'package:simple_progress_indicators/simple_progress_indicators.dart' ;
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../models/upload.dart' ;
import '../page/add_game.dart' ;

class Gamy extends StatefulWidget {
  String gname ;
  String glevel ;

  Gamy({required this.gname, required this.glevel});

  @override
  State<Gamy> createState() => _GamyState();
}

class _GamyState extends State<Gamy> {
  final Color kDarkBlueColor = const Color(0xFF053149);

  final BoxShadow kDefaultBoxshadow = const BoxShadow(
    color: Color(0xFFDFDFDF),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(2, 2),
  );

  List<GameModel> list = [];

  late Map<String, dynamic> userMap;
  int currentIndex = 0;
  String user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
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
          title: Text(widget.glevel + " Events",
              style: TextStyle(color: Colors.black, fontWeight : FontWeight.w600)),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GameModel sj = GameModel(Name: "", About: "", Fee:
            0, Important: "", Kill: "", Mapp: "", ytlink : "", link : "n", status : "",
                Notes:"", Participants:[],
                Picture: "", Type:"", Version: "",
                limit: 0, date_e:"", date_f: "",
                first: "", hostedby: "", hosteid: "",
                hostname:"", Level: "", mode: "",
                second: "", Server: "", Team: "",
                time_e: "", time_s: "");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Add(id: widget.gname, uid: widget.glevel, changing: false, isleague: false, user: sj,),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                AppinioAnimatedToggleTab(
                  duration: const Duration(milliseconds: 150),
                  offset: 0,
                  callback: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  tabTexts: const [
                    'Solo',
                    'Duo',
                    'Squad',
                  ],
                  height: 40,
                  width: 300,
                  boxDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      kDefaultBoxshadow,
                    ],
                  ),
                  animatedBoxDecoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFc3d2db).withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                    color: Color(0xffB39BE5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  activeStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  inactiveStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 60,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(widget.gname)
                          .doc("GAME")
                          .collection(widget.glevel)
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
                                    ?.map((e) => GameModel.fromJson(e.data()))
                                    .toList() ??
                                [];
                            if (list.isEmpty) {
                              return Center(child: Text("No Events Registered"));
                            } else {
                              return ListView.builder(
                                itemCount: list.length,
                                padding: EdgeInsets.only(top: 1),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ChatUser(
                                    user: list[index],
                                    gname : widget.gname,
                                    glevel : widget.glevel,
                                    i: currentIndex,
                                  );
                                },
                              );
                            }
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatUser extends StatefulWidget {
  GameModel user;
  String gname ;
  String glevel ;
  int i ;
  ChatUser({required this.user, required this.gname, required this.glevel, required this.i});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {

  void initState(){
    g();
    super.initState();
  }

  Future<void> g() async {
    String dateTimeString = widget.user.date_f;
    DateTime targetDateTime = DateTime.parse(dateTimeString);

    String dateTimeString2 = widget.user.date_e;
    DateTime targetDateTime2 = DateTime.parse(dateTimeString2);

    // Get the current date and time
    DateTime now = DateTime.now();
    CollectionReference collection = FirebaseFirestore
        .instance
        .collection(widget.gname)
        .doc('GAME')
        .collection(widget.glevel);
    // Compare the two DateTime objects
    if (targetDateTime.isBefore(now)) {
      await collection.doc(widget.user.Name).update({
        "status" : "U",
      });
    } else if (targetDateTime.isAfter(now) && targetDateTime2.isBefore(now)) {
      await collection.doc(widget.user.Name).update({
        "status" : "O",
      });
    } else {
      await collection.doc(widget.user.Name).update({
        "status" : "C",
      });
    }
  }

  TextEditingController cs = TextEditingController();
  TextEditingController cd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap : (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Single_C(user : widget.user)),
          );
        },
        onDoubleTap: (){

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add(id: widget.gname, uid: widget.glevel, changing: true, isleague: false, user: widget.user,),
            ),
          );
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffF3EDF9), Color(0xffBEC0E7)],
              ),
              border: Border.all(
                color: Color(0xff2055B5), // Set the border color here
                width: 1.5, // Set the border width if needed
              ),
            ),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffF3EDF9), Color(0xffBEC0E7)],
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text( " Hosted by :- " + widget.user.Name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w800)),
                      ),
                    )),
                Container(
                  height : 4,
                  width: MediaQuery.of(context).size.width,
                  color : Colors.blue
                ),
                Container(
                  color : Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top : 10, bottom : 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          as("DATE", widget.user.date_f),
                          r1(),
                          as("TIME",  widget.user.time_s),
                          r1(),
                          as("MAP", widget.user.Mapp),
                          r1(),
                          as("VIEW", widget.user.Version),
                        ]),
                  ),
                ),
                Container(
                    color : Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Divider( thickness: 1, color : Colors.blue)),
                Container(
                  color : Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top : 2, bottom : 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          asf("ENTRY", widget.user.Fee.toString(), true, false, false),
                          r1(),
                          asf("#1", widget.user.first, true, true, false),
                          r1(),
                          asf("PER KILL", widget.user.Kill, true, false, true),
                          r1(),
                          asf("RATING", "4", false, false, false),
                        ]),
                  ),
                ),
                Container(
                    color : Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height : 8),

                SizedBox(height : 9),
                widget.i == 0 ? Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ProgressBar(
                              value: findn( widget.user.Participants, widget.user.limit), height: 5,
                              //specify only one: color or gradient
                              color: Color(0xffB39BE5), backgroundColor: Colors.white,
                            ),
                            Text( widget.user.Participants.length.toString() + " / " + widget.user.limit.toString(), style : TextStyle(color : Colors.black, fontSize : 18)),
                          ],
                        ),
                        ElevatedButton( onPressed :() async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Create the AlertDialog
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/Screenshot_2024-01-20-14-04-58-25_8ee8015dd2b473d44c46c2d8d6942cec.jpg")),
                                  ),
                                  height: 370,
                                  width : MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.backspace, color : Colors.black)),
                                              Text("PLAYBEES.IO",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w900,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: TextFormField(
                                              controller: cs,
                                              decoration: InputDecoration(
                                                label: Text("BGMI Username"),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: TextFormField(
                                              controller: cd,
                                              decoration: InputDecoration(
                                                label: Text("BGMI ID"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Text("Note : ROOM ID and Password will be displayed in Leagues or Registered Matches before 15 min of each time", textAlign : TextAlign.center,),
                                          SizedBox(height: 24),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 40,
                                              child: Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (_user!.Won >=
                                                        widget.user.Fee) {
                                                      String userjj = FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(userjj)
                                                          .update({
                                                        "Won":
                                                        FieldValue.increment(
                                                            - widget.user.Fee),
                                                      });
                                                      CollectionReference
                                                      collection =
                                                      FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          "League");
                                                      await collection
                                                          .doc(widget.user.Name)
                                                          .update({
                                                        "Participants":
                                                        FieldValue.arrayUnion(
                                                            [_user!.Name]),
                                                      });
                                                      ScaffoldMessenger.of(
                                                          context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'You joined this Event Successfully'),
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                      String s = DateTime.now().microsecondsSinceEpoch.toString();
                                                      String s1 = DateTime.now().toString();
                                                      Payments g = Payments(id: s, time: s1,
                                                          status: "Debited", amount: widget.user.Fee.toString() );
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(user)
                                                          .collection("Transaction").doc(s).set(g.toJson());
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                          context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'You don\'t have much coin'),
                                                        ),
                                                      );
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                No_M()),
                                                      );
                                                    }
                                                  },
                                                  child: Text("REGISTER",
                                                      style: TextStyle(
                                                        color: Colors.black, )),
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      Colors.purple.shade100),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                        }, child : Text( widget.user.Participants.contains(['${_user!.uid}']) ? "JOINED !" : "JOIN", style : TextStyle(color : Colors.black)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffB39BE5)
                          ),)
                      ]
                  ),
                ) :
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only( left : 18.0, right : 18),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(onPressed: () async {
                            final Uri _url = Uri.parse('https://youtu.be/2n4nTYwAQN0?si=OsqJ2YRyBiNju3E4');
                            if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                            }
                          }, icon: Icon(Icons.ondemand_video_rounded, color : Colors.red), label: Text("  WATCH  "),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mumm()),
                              );
                            },
                            child: Text("VIEW",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffB39BE5)
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
  Widget r1(){
    return Container(
        width : 2, height: 30,
        color : Colors.blue
    );
  }

  double findn( List l , int g){
    int jh = l.length ;
    double j = jh/g ;
    return j ;
  }

  Widget as(String s1, String n1) {
    return Container(
      width: 80,
      color: Colors.white,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(s1,
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w900,
                fontSize: 17)),
        Container(
            color: Colors.white,
            child: Text("$n1",  style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 17))),
      ]),
    );
  }

  Widget asf(String s1, String n1, bool b , bool b2, bool b3) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white, // Set your desired color
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(s1,
            style: TextStyle(
                color: b2 ? Colors.green : ( b3 ?  Colors.red : Colors.blueGrey ) ,
                fontWeight: FontWeight.w900,
                fontSize: 17, )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if( b) Icon(Icons.diamond, color : Colors.blue),
            Text(n1,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 18)),
          ],
        ),
      ]),
    );
  }
}
