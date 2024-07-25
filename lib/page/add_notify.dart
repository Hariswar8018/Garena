import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/noticecard.dart';
import 'package:garena/models/notices.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Not extends StatelessWidget {
  String id ; bool b ; String str ;
  bool viewonly ;
  Not({super.key, required this.id, required this.b, required this.str, required this.viewonly});

  String as (){
    if (b){
      return "Notices";
    }else{
      return "Documents";
    }
  }

  List<Notice> _list = [];

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
          appBar : AppBar(
            iconTheme: IconThemeData(
                color : Colors.black
            ),
            backgroundColor: Colors.transparent,
            title : Text(as(), style : TextStyle(color : Colors.black)),
          ),
          floatingActionButton: !viewonly? InkWell(
            onTap: () async {
                Navigator.push(
                    context, PageTransition(
                    child: Add( b : b, id : id), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
              ));
            },
            child: Container(
                decoration: BoxDecoration(color: Colors.blue,
                    borderRadius: BorderRadius.circular(25)
                ),
                height: 55, width : 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle_notifications, color: Colors.white),
                    SizedBox(width: 9),
                    Text("Create " + as(), style: TextStyle(color: Colors.white))
                  ],
                )
            ),
          ):SizedBox(),
          body:  StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Notices').snapshots() ,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("https://cdn-icons-png.freepik.com/512/7486/7486744.png", width : MediaQuery.of(context).size.width - 200),
                      Text(
                        "No " + as() + " found",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Looks like the Admin haven't shared any yet", textAlign : TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              }
              final data = snapshot.data?.docs;
              _list.clear();
              _list.addAll(data?.map((e) => Notice.fromJson(e.data())).toList() ?? []);
              return ListView.builder(
                itemCount: _list.length,
                padding: EdgeInsets.only(top: 10),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Noticec(user: _list[index],id:
                  id, admin: !viewonly,);
                },
              );
            },
          )
      ),
    );
  }
}

class Add extends StatefulWidget {
  bool  b; String id ;
  Add({super.key, required this.b , required this.id,  });

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController name =  TextEditingController();
  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }
  TextEditingController onh = TextEditingController();
  void initState(){
    vq();
    super.initState();
    vq();
  }

  TextEditingController desc =  TextEditingController();

  TextEditingController link =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        iconTheme: IconThemeData(
            color : Colors.white
        ),
        backgroundColor:  Color(0xFF303C52),
        title : Text("Add New " + as(), style : TextStyle(color : Colors.white)),
      ),
      body : Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              t1("Name"),
              sd(name, context, 1),
              SizedBox(height: 10),
              t1("Description",),
              sd(desc, context, 4),
              SizedBox(height: 10),
              widget.b ? t1("Link ( if any ) ",) : t1("Link of document"),
              sds(link, context, 4),
              SizedBox(height: 25),
              !widget.b ? t1("Link type ?",) : SizedBox(),
              SizedBox(height: 10),
              !widget.b ? r(context) : SizedBox(),
            ]
        ),
      ),
      persistentFooterButtons: [
        SocialLoginButton(
            backgroundColor: Colors.blue,
            height: 40,
            text: 'Add ' + as() + " Now",
            borderRadius: 20,
            fontSize: 21,
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () async {
              final iddd = DateTime.now().millisecondsSinceEpoch.toString();
              try {
                  Notice cf = Notice(id: iddd,
                    date: iddd,
                    name: name.text,
                    description: desc.text,
                    link: link.text,
                    pic: "h",
                    namet:"h",
                    coTeach: false, follo: [],
                  );
                  await FirebaseFirestore.instance.collection("Notices").doc(iddd).
                  set(cf.toJson());
                Navigator.pop(context);
              }catch(e){
                print(e);
              }
            }),
      ],
    );
  }

  Widget t1(String g){
    return Text(g, style : TextStyle(fontSize: 19, fontWeight: FontWeight.w600, ));
  }

  Widget t2(String g){
    return Text(g, style : TextStyle(fontSize: 14, fontWeight: FontWeight.w300));
  }

  Widget sd (TextEditingController cg,  BuildContext context, int yu ){
    return Padding(
      padding: const EdgeInsets.only( top : 10.0),
      child: Container(
        width : MediaQuery.of(context).size.width  , height : 50,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: const EdgeInsets.only( left :10, right : 18.0, top : 5, bottom: 5),
            child: Center(
              child: TextFormField(
                controller: cg, maxLines: 6, minLines: yu,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  isDense: false,
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            )
        ),
      ),
    );
  }
  Widget sds (TextEditingController cg,  BuildContext context, int yu ){
    return Padding(
      padding: const EdgeInsets.only( top : 10.0),
      child: Container(
        width : MediaQuery.of(context).size.width  , height : 50,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: const EdgeInsets.only( left :10, right : 18.0, top : 5, bottom: 5),
            child: Center(
              child: TextFormField(
                controller: cg, maxLines: 6, minLines: yu,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none, // No border
                    counterText: '', prefixIcon: Icon(Icons.link, color: Colors.blue,)
                ),
              ),
            )
        ),
      ),
    );
  }
  String as (){
    if (widget.b){
      return "Notices";
    }else{
      return "Documents";
    }
  }

  bool pic = true , pdf = false ;

  Widget r(BuildContext context, ){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              pic = true ; pdf = false ;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.width / 3 - 30, width: MediaQuery.of(context).size.width / 3 - 30,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: !pdf && pic ? Colors.blue : Colors.white,
                width: 3.0,
              ),
              image: DecorationImage(
                image: NetworkImage(
                    "https://icons.veryicon.com/png/o/miscellaneous/daily-icon-2/gallery-22.png"
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              pic = false ; pdf = false ;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.width / 3 - 30, width: MediaQuery.of(context).size.width / 3 - 30,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: !pdf && !pic ? Colors.blue : Colors.white,
                  // Border color
                  width: 3.0, // Border width
                ),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://png.pngtree.com/png-vector/20190215/ourmid/pngtree-play-video-icon-graphic-design-template-vector-png-image_530837.jpg")
                )
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              pdf = true ;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.width / 3 - 30, width: MediaQuery.of(context).size.width / 3 - 30,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: pdf ? Colors.blue : Colors.white,
                  // Border color
                  width: 3.0, // Border width
                ),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/7670/7670113.png")
                )
            ),
          ),
        ),
      ],
    );
  }

 /* void sendNotifications() async {
    // Fetch tokens from Firestore where 'arrayField' contains '1257'
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('following', arrayContains: widget.user1.id)
        .get();

    List<String> tokens = [];

    // Extract tokens from the fetched documents
    // Extract tokens from the fetched documents
    usersSnapshot.docs.forEach((doc) {
      // Explicitly cast doc.data() to Map<String, dynamic>
      var data = doc.data() as Map<String, dynamic>;

      var user = UserModel.fromJson(data); // Assuming UserModel.fromJson correctly initializes from Map
      print(data);
      if (user.token != null) {
        tokens.add(user.token);
        print(user.token);
      }
    });

    // Send notifications to each token
    await sendNotificationsToTokens(tokens);
  }

  Future<void> sendNotificationsToTokens(List<String> tokens) async {
    var server = FirebaseCloudMessagingServer(
      serviceAccountFileContent,
    );

    for (var token in tokens) {
      var result = await server.send(
        FirebaseSend(
          validateOnly: false,
          message: FirebaseMessage(
            notification: FirebaseNotification(
              title: 'New Notice Posted',
              body: 'New Notice Posted by ${widget.user1.name}',
            ),
            android: FirebaseAndroidConfig(
              ttl: '3s', // Optional TTL for notification

              /// Add Delay in String. If you want to add 1 minute delay then add it like "60s"
              notification: FirebaseAndroidNotification(
                icon: 'ic_notification', // Optional icon
                color: '#009999', // Optional color
              ),
            ),
            token: token, // Send notification to specific user's token
          ),
        ),
      );

      // Print request response
      print(result.toString());
    }
  }


  final serviceAccountFileContent = <String, String>{
    'type': "service_account",
    'project_id': "madrasa-e-mustafa",
    'private_key_id':  "eda9c8c38e10101b9a1463a6c461f3db7d5e71dd",
    'private_key':  "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDB/3e1b5VGISLM\nExogVn/pZovSI+g9NVox1hNT4StkIs4adwNbgFcTP1MuByYlryq9HUpUfHGNLyCS\nhA/KV8XItIRoChp/pgCqsnkWZSLndRgwo1tHm0qUg4TBY8FzrZSRGI8ftE+nRnGB\nZYJPBqeFxVu32j0oFDJwsLI27IsORBN38d142+aan7HR00eEyZ9u5kcOwVSL35q8\nP7yY/6nhTWnHXKvs9lunQca05ToYkBHPpeOOPz7/qkhfES721SvjTFN79c4xX6LI\nzFCsbZG/7JGMCZ64a6mIZQ+H42/JPF4Phw5XoD4meNWLiyC5s3FsGzngQZSNPdB3\nC1q9l9fVAgMBAAECggEANuitg8uk5xga5sMjWnLROok9Wwmxwp1WvZNXnh617t5R\nErmL2Dq/qqF6VCVO3UyynptrPfWJGEp2ADJj28QzJYc+kMoHTQj52Fayoi2XDwcc\nBSw/ekmQdu+wxCINj8XaLqVSYUliYDi2iMbn9qEuClVdi/C37Z+l1TKWBqi2BR+u\ncFqW7beaqpQOyN8prv5wFL3tclcjgB7lcxCayrDASyB3GvwPHruhKMD0jPlkpyTT\n2Z7XP/hNwmbljEcXPWvCOkFVg84rsltRuvvE+6HBlAWRPKJeysak75tzx8mkrD2x\nReeedPx6tWQy4NG8hHVUUmNKduDbG9evEfJw0zLpswKBgQDgzhx4zb90/iLn9AZJ\nzg7JFCdGRS06bXfzcNz6Gf7lvDdzCXku80MY0ibkr100noS1L0yvLWQlvEBXhPbP\n/BEdHBxjFzN3aUnxtu6DWiFSSvjoP2vqgAMkdCiTGAFkr4yDIDIlDuZX4DqSrtan\nysJkmewDdPbca4CociQgn5tF3wKBgQDc6vk1qIQeKx+pcTA0fo0yWU+JlA6ynYF8\n4oMMiK8JlDUIi627cPGNjyA7w1RCYvSqkxqVsrVUTsUTaff8XW9702Z0r+xZU9Uh\nO4ZDaQubwOVt1BBHuPNqixdc+Xxrv+17pSkBbWVk0tkhm8w2U9XUsJIcqEmYPDK2\ntHiryxaQywKBgQDbjpHiLlhqI/blgcBOfvCT1JoTGGb25Ik9eqJnpdH8gBnLwZnY\nj/+dE0qnGNq4FIXaC0si3/sqm7Rfhd4j/bSdMKJM6RD79Boi+B30radTnyOAeMim\nK8Zl6QjjuJNLyeQ7AMvYw7eWZcnvDtFY6T94T5hhO/AKEPiEC45bSma1EwKBgQCh\nQM6pURkm4DlbOCiEmL89uh0pgi38SKXE353inz6M0manlzU39agLuSZBGUG+t3Z5\nr6ifDnP3VwvZMOd3iUgf7V4C3Iq7ZUrT2BwXxmxXw0R0l29OuvzKjz59egpMqCqT\nrymwRgbVwmYFdzBnk2gouL3eNySI/5/Q5wiR9UrCYwKBgQC9BdOrN8jPk+4Bd/bm\n95QyQEGCiTQmlJsi/M/akh6JMklxsvKUIdCnsviZs4x0rZuL/wB+4JpW7O7UA9KS\njJ3ItkvaOYDSbhtAsJNqSOHvZvNMbTHekZJvmUKyd732afLbV0KM0WdN3vCBKyZF\njn6TV7X7ON9l6FJU2wxqD3TtKA==\n-----END PRIVATE KEY-----\n",
    'client_email': "firebase-adminsdk-2frrn@madrasa-e-mustafa.iam.gserviceaccount.com",
    'client_id':"114031349267895974533",
    'auth_uri':  "https://accounts.google.com/o/oauth2/auth",
    'token_uri':  "https://oauth2.googleapis.com/token",
    'auth_provider_x509_cert_url':  "https://www.googleapis.com/oauth2/v1/certs",
    'client_x509_cert_url': "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-2frrn%40madrasa-e-mustafa.iam.gserviceaccount.com",
  };*/
}

