import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garena/models/user_model.dart';

class Myuser extends StatelessWidget {
  Myuser({super.key});
  List<UserModel> list = [];

  late Map<String, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users for Admin View",style: TextStyle(color:Colors.white),),
      ),
      body:StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
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
                    ?.map((e) => UserModel.fromJson(e.data()))
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
                      return ChatO(
                        user: list[index],
                      );
                    },
                  );
                }
            }
          }),
    );
  }
}
class ChatO extends StatefulWidget {
  UserModel user;
  ChatO({super.key,required this.user});

  @override
  State<ChatO> createState() => _ChatOState();
}

class _ChatOState extends State<ChatO> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: SizedBox(
                height: 400,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  <Widget>[
                      SizedBox(
                        height: 26,
                      ),
                      r(true,"Admin",Icon(Icons.sunny,color:Colors.red)),
                      r(true,"Not Admin",Icon(Icons.sunny,color:Colors.red)),
                      r(false,"Transaction Admin",Icon(Icons.sunny_snowing,color:Colors.orange)),
                      r(false,"Not Transaction Admin",Icon(Icons.nightlight,color:Colors.black)),
                      SizedBox(height:10)
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.Pic_link),
              ),
              title: Text(widget.user.Name,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18),),
              subtitle: Text(widget.user.Email),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.red,
                        width: 2
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("User Status : "+widget.user.Chess_Level),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.red,
                            width: 2
                        ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("Super Access : "+widget.user.Gender),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  Widget r(bool b,String str,Widget rt){
    return ListTile(
      onTap: () async {
        if(b){
          await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
            "Chess_Level":str,
          });
        }else{
          await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
            "Gender":str,
          });
        }

        Navigator.pop(context);
      },
      leading: rt,
      title: Text(str,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
      subtitle: Text("Make ${widget.user.Name} $str"),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
