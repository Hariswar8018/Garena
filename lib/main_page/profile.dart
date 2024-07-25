import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/Cards/transactions.dart';
import 'package:garena/login/login_screen.dart';
import 'package:garena/main_page/history.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/other/before.dart';
import 'package:garena/page/admin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:garena/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  initState() {
    super.initState();
    vq();
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser() ;
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _user!.Pic_link,
                  ),
                  minRadius: 50,
                  maxRadius: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hi , " + _user.Name,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ListTile(
                leading: Icon(Icons.account_circle_sharp, color: Colors.black, size: 30,),
                title: Text("My Account"),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Before_Update(user:_user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                  ));
                },
                subtitle: Text("See your Account, Edit or Delete It"),
                splashColor: Colors.orange.shade200, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.redAccent, size: 30),
                title: Text("Learn More"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://chessmons.com/');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                subtitle: Text("Learn More about us & the App"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.my_library_books_sharp, color: Colors.greenAccent, size: 30),
                title: Text("Transactions"),
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          child: History(st:FirebaseAuth.instance.currentUser!.uid),
                          type: PageTransitionType.leftToRight,
                          duration: Duration(milliseconds: 100)));
                },
                onLongPress: () {
                  String? emsil = FirebaseAuth.instance.currentUser!.email;
                  if(emsil=="hariswarsamasi@gmail.com"||emsil=="kushankkm9535@gmail.com"||_user.Gender=="Transaction Admin"){
                    Navigator.push(
                        context, PageTransition(
                        child: Admin(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 500)
                    ));
                  }
                },
                subtitle: Text("Check your Transactions"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.purpleAccent, size: 30),
                title: Text("Privacy"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://chessmons.com/privacy/');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                subtitle: Text("Check how Privacy is Managed"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.newspaper_outlined, color: Colors.orange, size: 30),
                title: Text("Terms & Condition"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://chessmons.com/privacy/');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                subtitle: Text("Check Terms & Condition of Our App"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.orange, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.support, color: Colors.green, size: 30),
                title: Text("Support"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://wa.me/919880281657');
                  if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                  }
                 /* Navigator.push(
                      context, PageTransition(
                      child: Support(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));*/
                },
                subtitle: Text("Contact Help and Support"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.green, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent, size: 30),
                title: Text("Log Out"),
                onTap: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((res) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  });
                },
                subtitle: Text("Log Out from this App"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              SizedBox(height: 20,),
              Text("PLAYBEES", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic)),
              Text("Made with ❤️ with Online Games", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Image.asset("assets/logo-Photoroom.png", height: 80,),
              Text("PLAYBEES version : 1.2", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200)),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
