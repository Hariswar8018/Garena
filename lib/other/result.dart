import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garena/models/player_model.dart';
import 'package:provider/provider.dart';

import '../models/game_models.dart';
import '../models/providers.dart';
import '../models/user_model.dart';

class Mumm extends StatefulWidget {
  GameModel user;
  String gname ;
  String glevel ;int i;
  Mumm({super.key,required this.user, required this.gname, required this.glevel, required this.i});

  @override
  State<Mumm> createState() => _MummState();
}
int i = 0;
class _MummState extends State<Mumm> {
  void initState(){
    super.initState();
    i=0;
  }
  List<PlayerModel> list = [];

  late Map<String, dynamic> userMap;
  bool op(){
    if(widget.gname.isEmpty||widget.glevel.isEmpty||widget.glevel==""||widget.gname==""){
      return true;
    }else{
      return false;
    }
  }
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
          title: Text("View Participants",
              style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: true,
        ),
        body : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [
            Padding(
              padding: const EdgeInsets.only(left:15.0,right:15,top:10),
              child: Container(
                height : 40, width : MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color : Color(0xFF053149),
                  borderRadius: BorderRadius.circular(15)
                ),
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children : [
                    SizedBox(width : 18),
                    Text("NO", style : TextStyle(color : Colors.white)),
                    SizedBox(width : 40),
                    Text("UserName", style : TextStyle(color : Colors.white)),
                    SizedBox(width :90),
                    Text("ID", style : TextStyle(color : Colors.white)),
                    SizedBox(width : 10),
                  ]
                )
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height - 60,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future:op()? FirebaseFirestore.instance
                      .collection("League").doc(widget.user.id).collection("Register")
                      .get():FirebaseFirestore.instance
                      .collection(widget.gname)
                      .doc('GAME')
                      .collection(widget.glevel).doc(widget.user.id).collection("Register")
                      .get(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        list = data
                            ?.map((e) => PlayerModel.fromJson(e.data()))
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
                              return ChatU(
                                user: list[index],
                              );
                            },
                          );
                        }
                    }
                  }),
            ),
          ]
        )
      ),
    );
  }
}

class ChatU extends StatefulWidget {
  PlayerModel user;
  ChatU({super.key,required this.user});

  @override
  State<ChatU> createState() => _ChatUState();
}

class _ChatUState extends State<ChatU> {

  void initState(){
    super.initState();
    i = i +1;
  }
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.only(left:15.0,right:15,bottom:10),
      child: Container(
          height : 40, width : MediaQuery.of(context).size.width - 20,
          child : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children : [
                SizedBox(width : 18),
                Text(i.toString(), style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                SizedBox(width : 50),
                Text(widget.user.username, style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                SizedBox(width :90),
                Text(widget.user.id, style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                Spacer(),
                _user!.Chess_Level=="Admin"?IconButton(onPressed: (){
                  Clipboard.setData(
                      new ClipboardData(text: widget.user!.uid));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copied to ClipBoard'),
                    ),
                  );
                }, icon:  Icon(Icons.copy)):SizedBox(),
                SizedBox(width : 10),
              ]
          )
      ),
    );
  }
}
