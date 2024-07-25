import 'dart:typed_data';

import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/Games_Cards.dart';
import 'package:garena/models/game_models.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../models/upload.dart';

class AllG extends StatefulWidget {
  String typei;
  String gname ;
  String glevel ;
  AllG({required this.gname, required this.glevel,required this.typei});

  @override
  State<AllG> createState() => _AllGState();
}

class _AllGState extends State<AllG> {
  final Color kDarkBlueColor = const Color(0xFF053149);

  final BoxShadow kDefaultBoxshadow = const BoxShadow(
    color: Color(0xFFDFDFDF),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(2, 2),
  );

  List<SessionModel> list = [];

  late Map<String, dynamic> userMap;
  int currentIndex = 0;
  String user = FirebaseAuth.instance.currentUser!.uid ;

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
        floatingActionButton: _user!.Chess_Level=="Admin"? FloatingActionButton(
            onPressed: () {
              SessionModel ui = SessionModel(Name: "hh", id: "ff", modes: [], pic: "g");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Add(id: widget.gname, b: false, user: ui,),
                ),
              );
            },
            child: Icon(Icons.add)):SizedBox(),
        appBar: AppBar(
          iconTheme: IconThemeData(
              color : Colors.black
          ),
          backgroundColor: Colors.transparent,
          title: Text( "All Maps of " + widget.gname,
              style: TextStyle(color: Colors.black, fontWeight : FontWeight.w600)),
          automaticallyImplyLeading: true,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(widget.gname).where("modes",arrayContains: widget.typei)
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
                      ?.map((e) => SessionModel.fromJson(e.data()))
                      .toList() ??
                      [];
                  if(list.isEmpty){
                    return Center(
                        child : Text("No Events to Show")
                    );
                  }else{
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // You can adjust the number of columns as needed
                      ),
                      itemCount: list.length,
                      padding: EdgeInsets.only(top: 1),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUser(
                          user: list[index],
                          st : widget.gname
                        );
                      },
                    );
                  }
              }
            }
        ),
      ),
    );
  }
}


class ChatUser extends StatefulWidget {
  String st ;
  SessionModel user;

  ChatUser({required this.user, required this.st});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: (){
          if(_user!.Chess_Level=="Admin"){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Add(id: widget.st, b: true, user: widget.user,),
              ),
            );
          }
        },
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Gamy(gname: widget.st, glevel: widget.user.Name,)),
          );
        },
        child: Container(
          height : 55,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color : Colors.white,
              image: DecorationImage(
                image : NetworkImage(widget.user.pic),
                fit: BoxFit.cover,
              )
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                Spacer(),
                Container(
                    width:  MediaQuery.of(context).size.width/3 - 15 ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color : Colors.orange,
                    ),
                    child: Center(
                        child: Text(widget.user.Name, style : TextStyle(fontWeight: FontWeight.w500, fontSize: 14))))
              ],
          ),
        ),
      ),
    );
  }

  void open(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 550,
          child: SizedBox(
            height: 550,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  SizedBox(
                    height: 6,
                  ),
                  ListTile(
                    onTap: (){
                      setState((){

                      });
                    },
                    leading: Icon(Icons.all_inclusive),
                    title: Text("All Shifts",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
                    subtitle: Text("View all Shifts without Filter"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  r("Morning Shift",Icon(Icons.sunny,color:Colors.red)),
                  r("Evening Shift",Icon(Icons.sunny_snowing,color:Colors.orange)),
                  r("Night Shift",Icon(Icons.nightlight,color:Colors.black)),
                  r("Weekend Shift",Icon(Icons.holiday_village,color:Colors.blue)),
                  r("Overtime Shift",Icon(Icons.timelapse_outlined,color:Colors.green)),
                  SizedBox(height:10)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget r(String str,Widget rt){
    return ListTile(
      onTap: (){
        setState((){

        });
      },
      leading: rt,
      title: Text(str,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
      subtitle: Text("View all $str with Filter"),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}


class SessionModel {
  SessionModel({
    required this.Name,
    required this.id,
    required this.modes,
    required this.pic,
  });

  late final String Name;
  late final String id;
  late final String pic;
  late final List modes;

  SessionModel.fromJson(Map<String, dynamic> json) {
    Name = json['Name'] ?? 'samai';
    id = json['id'] ?? 'Xhqo6S2946pNlw8sRSKd';
    pic = json['pic']??"";
    modes = json['modes']??['Mobile'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Name'] = Name;
    data['id'] = id ;
    data['pic']=pic;
    data['modes']=modes;
    return data;
  }
}

class Add extends StatefulWidget {
  String id; bool b ;
  SessionModel user;

  Add({super.key, required this.id,required this.b, required this.user});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController sessionNameController = TextEditingController();
void initState(){
  super.initState();
  if(widget.b){
    photoUrl = widget.user.pic;
    sessionNameController.text =widget.user.Name;
    modes =widget.user.modes;
  }
}
  String s = " ";

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  String photoUrl = "https://firebasestorage.googleapis.com/v0/b/yaarbanao.appspot.com/o/bgmi-512x512-1641551242.webp?alt=media&token=134b0257-1cb7-4db7-b469-256f5da4aa6f";

  List modes = [];
bool up = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.b?"Update ${widget.user.Name}":"Add A Map"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: up?CircularProgressIndicator():InkWell(
                onTap:  () async {
                  setState(() {
                    up = true;
                  });
                  Uint8List? _file = await pickImage(ImageSource.gallery);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Uploading Please wait"),
                    ),
                  );
                  photoUrl =  await StorageMethods().uploadImageToStorage('Users/${sessionNameController}', _file!, true);
                  setState(() {
                    up = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Pic uploaded"),
                    ),
                  );
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(photoUrl),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
            ),
            Center(child: Text(textAlign: TextAlign.center,"Upload Custom Picture by Tapping Above")),
            SizedBox(
              height: 20,
            ),
            Text("  Map Name",style:TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
            Padding(
              padding: const EdgeInsets.only(left:14.0,right:14),
              child: TextFormField(
                controller: sessionNameController,readOnly: widget.b,
                decoration: InputDecoration(
                  labelText: 'Map Name',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please type your Password';
                  }
                  return null;
                },
                onChanged: (value) {
                  /*setState(() {
                    s = value;
                  });*/
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("  Map will host for Which Devices",style:TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                rt("Mobile"),
                rt("PC"),
                rt("Emulator")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SocialLoginButton(
                backgroundColor: Color(0xff50008e),
                height: 40,
                text: widget.b?"Update ${widget.user.Name}":'Add Map Now',
                borderRadius: 20,
                fontSize: 21,
                buttonType: SocialLoginButtonType.generalLogin,
                onPressed: () async {
                  try {
                    if(widget.b){
                      CollectionReference collection = FirebaseFirestore.instance.collection(widget.id) ;
                      SessionModel ui = SessionModel(Name: sessionNameController.text, id:widget.user.id, modes: modes, pic: photoUrl);
                      await collection.doc(sessionNameController.text).update(ui.toJson());
                      Navigator.pop(context);
                    }else{
                    CollectionReference collection = FirebaseFirestore.instance.collection(widget.id) ;
                    // Replace with your own custom ID
                    String idi = DateTime.now().millisecondsSinceEpoch.toString();
                    SessionModel ui = SessionModel(Name: sessionNameController.text, id: idi, modes: modes, pic: photoUrl);
                    await collection.doc(sessionNameController.text).set(ui.toJson());
                    Navigator.pop(context);
                    }
                  } catch (e) {
                    print('${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e}'),
                      ),
                    );
                  }
                  ;
                },
              ),
            ),
            widget.b?Padding(
              padding: const EdgeInsets.all(14.0),
              child: SocialLoginButton(
                backgroundColor: Colors.red,
                height: 40,
                text:"Delete",
                borderRadius: 20,
                fontSize: 21,
                buttonType: SocialLoginButtonType.generalLogin,
                onPressed: () async {
                  try {
                    if(widget.b){
                      CollectionReference collection = FirebaseFirestore.instance.collection(widget.id) ;
                      SessionModel ui = SessionModel(Name: sessionNameController.text, id:widget.user.id, modes: modes, pic: photoUrl);
                      await collection.doc(sessionNameController.text).delete();
                      Navigator.pop(context);
                    }else{
                      CollectionReference collection = FirebaseFirestore.instance.collection(widget.id) ;
                      // Replace with your own custom ID
                      String idi = DateTime.now().millisecondsSinceEpoch.toString();
                      SessionModel ui = SessionModel(Name: sessionNameController.text, id: idi, modes: modes, pic: photoUrl);
                      await collection.doc(sessionNameController.text).set(ui.toJson());
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print('${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e}'),
                      ),
                    );
                  }
                  ;
                },
              ),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget rt(String jh){
    return InkWell(
        onTap : () async {
          if(modes.contains(jh)){
            modes.remove(jh);
          }else{
            modes = modes+[jh];
          }
          print(modes);
          setState(() {

          });
        }, child : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: BoxDecoration(
            color: modes.contains(jh) ? Colors.blue : Colors.grey.shade100, // Background color of the container
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
          child : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(jh, style : TextStyle(fontSize: 16, color :   modes.contains(jh) ? Colors.white : Colors.black )),
          )
      ),
    )
    );
  }
}
