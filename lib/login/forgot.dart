import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/login/signup_screen.dart';
import 'package:garena/navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'dart:io';

class Forgot extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String s = "Demo";
  String d = "Demo";
  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void googlesignin() async{
    final googleSignIn = GoogleSignIn();
    final signinAccount = await googleSignIn.signIn();

    final googleAcc = await signinAccount!.authentication ;
    final creditential = GoogleAuthProvider.credential(accessToken: googleAcc.accessToken, idToken: googleAcc.idToken);

    await FirebaseAuth.instance.signInWithCredential(creditential);

    if(FirebaseAuth.instance.currentUser != null){
      print("Successfull");
      print('${FirebaseAuth.instance.currentUser!.displayName} signedin.');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success, Welcome ${FirebaseAuth.instance.currentUser!.displayName}'),
          ));
    }else{
      print("Unable to Sign In");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please use another Method'),
          ));
    }
  }
  void ff (){
    exit(0);
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
        extendBodyBehindAppBar: true,

        body:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70,),
                Text("Forgot Password ?", style: TextStyle( fontFamily: "font1", fontSize: 30, color : Color(0xff5E01F2), fontWeight: FontWeight.w800)),
                Text("Type Email for Password Recovery", style: TextStyle( fontFamily: "font1", fontSize: 23, color : Color(0xff5E01F2), fontWeight: FontWeight.w800)),
                SizedBox(height: 25,),
                Center(child: Image.network("https://cdn-icons-png.flaticon.com/512/6195/6195699.png", height : 200)),
                SizedBox(height: 23,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '  Email',  isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0), // Adjust the value as needed
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      d = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),

                SocialLoginButton(
                  backgroundColor:  Color(0xff6001FF),
                  height: 40,
                  text: 'Send Recovery Email',
                  borderRadius: 20,
                  fontSize: 21,
                  buttonType: SocialLoginButtonType.generalLogin,
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password Reset Email Sent Successful for your Account. Please check your Inbox !'),
                        ),
                      );
                      Navigator.pop(context);
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${e}'),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 15,),


                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
