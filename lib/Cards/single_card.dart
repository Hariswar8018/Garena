import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/no_money.dart';
import 'package:garena/models/game_models.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:provider/provider.dart';

class Single_C extends StatelessWidget {
  GameModel user ;
   Single_C({super.key, required this.user});
  TextEditingController cs = TextEditingController();
  TextEditingController cd = TextEditingController();
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
        extendBodyBehindAppBar: true,
        appBar : AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
        ),
        body : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              Image.network(user.Picture, width : MediaQuery.of(context).size.width, fit : BoxFit.cover, height : 260),
              SizedBox(height : 25),
              r("Match Details"),
              SizedBox(height : 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  g("Map", user.Mapp, Icon(Icons.map_rounded, color : Colors.green, size : 30), context),
                  g("Team", user.Team, Icon(Icons.supervised_user_circle, color : Colors.blue, size : 30), context),
                  g("Level", user.Level, Icon(Icons.star_sharp, color : Colors.yellow, size : 30), context),
                ],
              ),
              SizedBox(height : 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  g("TYPE", user.Type, Icon(Icons.accessibility, color : Colors.orange, size : 30), context),
                  g("VIEW", user.Type, Icon(Icons.remove_red_eye, color : Colors.red, size : 30), context),
                  g("SERVER", user.Server, Icon(Icons.language, color : Colors.purple, size : 30), context),
                ],
              ),

              SizedBox(height : 30),
              r("Game Details"),
              SizedBox(height : 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  g("Hosted By", user.hostedby, Icon(Icons.person, color : Colors.pink, size : 30), context),
                  g("GAME ID", user.hosteid, Icon(Icons.gamepad, color : Colors.blue, size : 30), context),
                  g("Host Name", user.hostedby, Icon(Icons.person_pin, color : Colors.orange, size : 30), context),
                ],
              ),
              SizedBox(height : 30),
              r("Prize Details"),
              SizedBox(height : 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gv("#1", user.first, Icon(Icons.plus_one_outlined, color : Colors.green, size : 30), context),
                  gv("#2", user.second, Icon(Icons.settings_input_component, color : Colors.blue, size : 30), context),
                  gv("Per Kill", user.Kill, Icon(Icons.water_drop, color : Colors.red, size : 30), context),
                ],
              ),
              SizedBox(height : 30),
              r("Shedule Details"),
              SizedBox(height : 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  g("DATE", user.date_f, Icon(Icons.calendar_month, color : Colors.orange, size : 30), context),
                  g("TIME", user.time_s, Icon(Icons.access_time_filled_outlined, color : Colors.greenAccent, size : 30), context),
                  g("MODE", user.mode, Icon(Icons.mobile_friendly_sharp, color : Colors.purpleAccent, size : 30), context),
                ],
              ),
              SizedBox(height : 30),
              r("Terms & Condition"),
              SizedBox(height : 15),
              Padding(
                padding: const EdgeInsets.only(left : 10.0, right : 10),
                child: Text(user.Important),
              ),
          Container(
            height: user.Participants.length + 40,
            child: ListView.builder(
              itemCount: user.Participants.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    '  ${index + 1}. ${user.Participants[index]}',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
              SizedBox(height : 25),
            ]
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width : 12),
                  Icon(Icons.diamond, color : Colors.green, size : 35),
                  SizedBox(width : 19),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Entry", style : TextStyle(color : Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text("100/SOLO", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),)
                    ],
                  ),
                  Spacer(),
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
                  }, child : Text("JOIN", style : TextStyle(color : Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade100
                    ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget gv( String h , String j, Widget a , BuildContext context){
    return Container(
        width: MediaQuery.of(context).size.width / 3 - 20,
        height: MediaQuery.of(context).size.width / 3 - 35,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),  child : Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          a,
          SizedBox(height : 3),
          Text(j, style : TextStyle( fontWeight: FontWeight.w800, fontSize: 15), textAlign : TextAlign.center)
        ],
      ),
    ));
  }
  Widget g( String h , String j, Widget a , BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
        height: MediaQuery.of(context).size.width / 3 - 35,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
      borderRadius: BorderRadius.circular(20),
    ),  child : Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          a,
          SizedBox(height : 3),
          Text(h, style : TextStyle( fontWeight: FontWeight.w500, fontSize: 13), textAlign : TextAlign.center),
          Text(j, style : TextStyle( fontWeight: FontWeight.w800, fontSize: 15), textAlign : TextAlign.center)
        ],
      ),
    ));
  }
  Widget r(String str){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("  $str  ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w700), textAlign : TextAlign.center),
        Container( color : Colors.black, height : 18, width : 3),
      ],
    );
  }
}
