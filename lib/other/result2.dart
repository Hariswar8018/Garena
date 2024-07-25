import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:garena/other/result.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/game_models.dart';

class Result extends StatefulWidget {
  GameModel user;
  String gname ;
  String glevel ;int i;
  Result({super.key,required this.user, required this.gname, required this.glevel, required this.i});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {

  List<PlayerModel> list = [];
  bool op(){
    if(widget.gname.isEmpty||widget.glevel.isEmpty||widget.glevel==""||widget.gname==""){
      return true;
    }else{
      return false;
    }
  }
  late Map<String, dynamic> userMap;

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
            title: Text("Result Available for ${widget.user.Name}",
                style: TextStyle(color: Colors.white)),
            automaticallyImplyLeading: true,
            actions: [
              _user!.Chess_Level=="Admin"||_user.Gender=="Transaction Admin"?TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mumm(user : widget.user, gname: widget.gname, i: i, glevel: widget.glevel,)),
                );
              }, child: Text("See Entrues",style:TextStyle(color:Colors.white))):SizedBox(),
            ],
          ),
          floatingActionButton: _user!.Chess_Level=="Admin"?FloatingActionButton(
            onPressed: (){
              Navigator.push(
                  context, PageTransition(
                  child: PlayerForm(user: widget.user, gname: widget.gname, glevel: widget.glevel, i: widget.i,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
              ));
            },
            child: Icon(Icons.add),
          ):SizedBox(),
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
                            Text("GAMER NAME", style : TextStyle(color : Colors.white)),
                            SizedBox(width : 40),
                            Spacer(),
                            Text("RANK", style : TextStyle(color : Colors.white)),
                            SizedBox(width :20),
                            Text("KILLS", style : TextStyle(color : Colors.white)),
                            SizedBox(width :20),
                            Text("WON", style : TextStyle(color : Colors.white)),
                            SizedBox(width : 10),
                          ]
                      )
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: MediaQuery.of(context).size.height - 120,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: op()?FirebaseFirestore.instance
                          .collection("League").doc(widget.user.id).collection("Result")
                          .snapshots():FirebaseFirestore.instance
                          .collection(widget.gname)
                          .doc('GAME')
                          .collection(widget.glevel).doc(widget.user.id).collection("Result")
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
                                    user: list[index],op:op(), gname: widget.gname, glevel: widget.glevel, id: widget.user.id,
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
  PlayerModel user; bool op; String gname ;
  String glevel , id;
  ChatU({super.key,required this.user,required this.op,required this.gname, required this.glevel, required this.id});

  @override
  State<ChatU> createState() => _ChatUState();
}

class _ChatUState extends State<ChatU> {
  int i = 0;
  void initState(){
    super.initState();
    i = i +1;
  }
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return _user!.Gender=="Transaction Admin"?Padding(
      padding: const EdgeInsets.only(left:15.0,right:15,bottom:5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height : 40, width : MediaQuery.of(context).size.width - 20,
              child : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children : [
                    SizedBox(width : 18),
                    Text(widget.user.username, style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                    SizedBox(width : 40),
                    Spacer(),
                    Text(widget.user.rank.toString(), style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                    SizedBox(width :40),
                    Text(widget.user.kills.toString(), style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                    SizedBox(width :40),
                    Text(widget.user.won.toString(), style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                    SizedBox(width : 10),
                  ]
              )
          ),
          widget.user.given? Container(
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child:Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(child: Text("Given",style: TextStyle(fontWeight: FontWeight.w700),)),
              ),
          ):InkWell(
            onTap: () async {
              try{
                CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                // Query the collection based on uid
                QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: widget.user.uid).get();
                // Check if a document with the given uid exists
                if (querySnapshot.docs.isNotEmpty) {
                  // Convert the document snapshot to a UserModel
                  UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
                  await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
                    "Won":FieldValue.increment(widget.user.won),
                    "win":FieldValue.increment(widget.user.won),
                  });
                  if(widget.op){
                    CollectionReference c= FirebaseFirestore.instance
                        .collection("League").doc(widget.id).collection("Result");
                    await c.doc(widget.user.id).update({
                      "given":true,
                    });
                  }else{
                    CollectionReference c = FirebaseFirestore.instance.collection(widget.gname)
                        .doc('GAME')
                        .collection(widget.glevel).doc(widget.id).collection("Result");
                    await c.doc(widget.user.id).update({
                      "given":true,
                    });
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('SUCCESS !'),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No User found for this UID'),
                    ),
                  );
                }
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${e}"),
                  ),
                );
              }
            },
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child:Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(child: Text("Give   ₹${widget.user.won.toString()}",style: TextStyle(fontWeight: FontWeight.w700),)),
              )
            ),
          )
        ],
      ),
    ):Padding(
      padding: const EdgeInsets.only(left:15.0,right:15,bottom:5),
      child: Container(
          height : 40, width : MediaQuery.of(context).size.width - 20,
          child : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children : [
                SizedBox(width : 18),
                Text(widget.user.username, style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                SizedBox(width : 40),
                Spacer(),
                Text(widget.user.rank.toString(), style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                SizedBox(width :40),
                Text(widget.user.kills.toString(), style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                SizedBox(width :40),
                Text(widget.user.won.toString(), style : TextStyle(color : Colors.black,fontWeight: FontWeight.w800)),
                SizedBox(width : 10),
              ]
          )
      ),
    );
  }
}


class PlayerForm extends StatelessWidget {
  GameModel user;
  String gname ;
  String glevel ;int i;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  final TextEditingController _killsController = TextEditingController();
  final TextEditingController _wonController = TextEditingController();

  PlayerForm({Key? key,required this.user, required this.gname, required this.glevel, required this.i}) : super(key: key);
  bool op(){
    if(gname.isEmpty||glevel.isEmpty||glevel==""||gname==""){
      return true;
    }else{
      return false;
    }
  }
  Future<void> _submit(BuildContext context) async {
    final String username = _usernameController.text;
    final String uid = _uidController.text;
    final String id = _idController.text;
    final String rank = _rankController.text;
    final int kills = int.tryParse(_killsController.text) ?? 0;
    final int won = int.tryParse(_wonController.text) ?? 0;

   String iii= DateTime.now().millisecondsSinceEpoch.toString();
    if (username.isNotEmpty && uid.isNotEmpty) {
      PlayerModel player = PlayerModel(
        username: username,
        uid: uid,
        id: iii,
        rank: rank,
        kills: kills,
        won: won, given: false,
      );
      if(op()){
       CollectionReference c= FirebaseFirestore.instance
            .collection("League").doc(user.id).collection("Result");
       await c.doc(iii).set(player.toJson());
      }else{
        CollectionReference c = FirebaseFirestore.instance.collection(gname)
            .doc('GAME')
            .collection(glevel).doc(user.id).collection("Result");
        await c.doc(iii).set(player.toJson());
      }
      // Here you can use the player object as needed, for example, saving it to Firestore
      print(player.toJson());
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Player created: ${player.username}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player Form',style:TextStyle(color:Colors.white))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Type Name'),
            ),
            TextField(
              controller: _uidController,
              decoration: InputDecoration(labelText: 'Type UID of User ( Important for Sending Coins )'),
            ),
            TextField(
              controller: _rankController,
              decoration: InputDecoration(labelText: 'Type Rank'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _killsController,
              decoration: InputDecoration(labelText: 'Type No. of Kills'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _wonController,
              decoration: InputDecoration(labelText: 'Type Won'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerModel {
  PlayerModel({
    required this.username,
    required this.uid,
    required this.id,
    required this.rank,
    required this.kills,
    required this.won,
    required this.given,
  });

  late final String username;
  late final String uid;
  late final String id;
  late final String rank;
  late final int kills;
  late final int won;
  late final bool given;

  PlayerModel.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    given=json['given']??"";
    uid = json['uid'] ?? '';
    id = json['id'] ?? '';
    rank = json['rank'] ?? '';
    kills = json['kills'] ?? 0;
    won = json['won'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['uid'] = uid;
    data['given']=given;
    data['id'] = id;
    data['rank'] = rank;
    data['kills'] = kills;
    data['won'] = won;
    return data;
  }
}