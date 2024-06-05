import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/models/game_models.dart';

class My extends StatefulWidget {
  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
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
   String user = FirebaseAuth.instance.currentUser!.uid ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueColor,
        title: Center(child: Text("My Events", style : TextStyle(color : Colors.white))),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
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
                'Upcoming',
                'Ongoing',
                'Completed',
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
                color: kDarkBlueColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              activeStyle: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              inactiveStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              'Current Index: $currentIndex',
              style: TextStyle(
                fontSize: 20,
                color: kDarkBlueColor,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 460,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(user).collection("Events").snapshots(),
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
                        if(list.isEmpty){
                          return Center(
                              child : Text("No Events Registered")
                          );
                        }else{
                          return ListView.builder(
                            itemCount: list.length,
                            padding: EdgeInsets.only(top: 1),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ChatUser(
                                user: list[index],
                              );
                            },
                          );
                        }
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ChatUser extends StatelessWidget {
  GameModel user;

  ChatUser({required this.user});

  @override
  Widget build(BuildContextcontext) {
    return ListTile(
      title: Text(" ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      subtitle: Text("Id : " , style: TextStyle(fontWeight: FontWeight.w400, fontSize: 9)),
      leading: Text("₹" , style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
      trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("h"),
          )),
    );
  }
}
