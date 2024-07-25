import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garena/models/game_models.dart';
import 'package:garena/models/player_model.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  GameModel user;
  String gname ;
  String glevel ;int i;

   Register({super.key,required this.user, required this.gname, required this.glevel, required this.i});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController cs = TextEditingController();

  TextEditingController cd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
                "assets/Screenshot_2024-01-20-14-04-58-25_8ee8015dd2b473d44c46c2d8d6942cec.jpg")),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40,),
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
                    label: Text("${widget.gname} Username"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10),
                child: TextFormField(
                  controller: cd,
                  decoration: InputDecoration(
                    label: Text("${widget.gname} ID"),
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
                  child: ElevatedButton(
                    onPressed: () async {
                      if(widget.user.Fee>_user!.Won){
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You Don't have Enough Coins !"),
                          ),
                        );
                      }else{
                        PlayerModel ui = PlayerModel(username: cs.text, uid:_user.uid, id: cd.text);
                        if(widget.gname.isEmpty||widget.glevel.isEmpty||widget.glevel==""||widget.gname==""){
                          CollectionReference collection = FirebaseFirestore
                              .instance
                              .collection("League").doc(widget.user.id).collection("Register");
                          await collection.doc(_user.uid).set(ui.toJson());
                          await  FirebaseFirestore
                              .instance
                              .collection("League").doc(widget.user.id).update({
                            "Participants":FieldValue.arrayUnion([_user.uid]),
                          });
                          await FirebaseFirestore.instance.collection("users").doc(_user.uid).update({
                            "Events":FieldValue.arrayUnion([widget.user.id]),
                            "Won":FieldValue.increment(- widget.user.Fee),
                            "utilize":FieldValue.increment(widget.user.Fee),
                          });
                          Navigator.pop(context);
                        }else{
                          CollectionReference collection = FirebaseFirestore
                              .instance
                              .collection(widget.gname)
                              .doc('GAME')
                              .collection(widget.glevel).doc(widget.user.id).collection("Register");
                          await collection.doc(_user.uid).set(ui.toJson());
                          await  FirebaseFirestore
                              .instance
                              .collection(widget.gname)
                              .doc('GAME')
                              .collection(widget.glevel).doc(widget.user.id).update({
                            "Participants":FieldValue.arrayUnion([_user.uid]),
                          });
                          await FirebaseFirestore.instance.collection("users").doc(_user.uid).update({
                            "Events":FieldValue.arrayUnion([widget.user.id]),
                            "Won":FieldValue.increment(-widget.user.Fee),
                            "utilize":FieldValue.increment(widget.user.Fee),
                          });
                          Navigator.pop(context);
                        }
                        UserProvider _userprovider = Provider.of(context, listen: false);
                        await _userprovider.refreshuser();
                      }
                    },
                    child: Text("REGISTER for  ₹${widget.user.Fee.toString()}",
                        style: TextStyle(
                          color: Colors.black, )),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.purple.shade100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
