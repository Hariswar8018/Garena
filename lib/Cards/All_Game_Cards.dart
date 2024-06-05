import 'dart:typed_data';

import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/Games_Cards.dart';
import 'package:garena/models/game_models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../models/upload.dart';

class AllG extends StatefulWidget {
  String gname ;
  String glevel ;
  AllG({required this.gname, required this.glevel});

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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Add(id: widget.gname),
                ),
              );
            },
            child: Icon(Icons.add)),
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
            stream: FirebaseFirestore.instance.collection(widget.gname).snapshots(),
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


class ChatUser extends StatelessWidget {
  String st ;
  SessionModel user;

  ChatUser({required this.user, required this.st});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Gamy(gname: st, glevel: user.Name,)),
          );
        },
        child: Container(
          height : 55,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color : Colors.white,
              image: DecorationImage(
                image : NetworkImage(user.id),
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
                        child: Text(user.Name, style : TextStyle(fontWeight: FontWeight.w500, fontSize: 14))))
              ]
          ),
        ),
      ),
    );
  }
}


class SessionModel {
  SessionModel({
    required this.Name,
    required this.id,
  });

  late final String Name;
  late final String id;

  SessionModel.fromJson(Map<String, dynamic> json) {
    Name = json['Name'] ?? 'samai';
    id = json['id'] ?? 'Xhqo6S2946pNlw8sRSKd';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Name'] = Name;
    data['id'] = id ;
    return data;
  }
}

class Add extends StatelessWidget {
  String id;

  Add({super.key, required this.id});

  final TextEditingController sessionNameController = TextEditingController();
  String s = " ";

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  String photoUrl = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Add A Map"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child : CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                child: IconButton(
                  onPressed : () async {
                    Uint8List? _file = await pickImage(ImageSource.gallery);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Uploading Please wait"),
                      ),
                    );
                     photoUrl =  await StorageMethods().uploadImageToStorage('users', _file!, true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pic uploaded"),
                      ),
                    );
                  },
                  icon : Icon(Icons.camera, size: 55,)
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                controller: sessionNameController,
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
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SocialLoginButton(
                backgroundColor: Color(0xff50008e),
                height: 40,
                text: 'Add Map Now',
                borderRadius: 20,
                fontSize: 21,
                buttonType: SocialLoginButtonType.generalLogin,
                onPressed: () async {
                  try {
                    CollectionReference collection = FirebaseFirestore.instance.collection(id) ;
                    // Replace with your own custom ID
                    await collection.doc(sessionNameController.text).set({
                      'Name': sessionNameController.text,
                      'id' : photoUrl,
                    });
                    Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
