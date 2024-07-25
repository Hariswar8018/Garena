import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/login/forgot.dart';
import 'package:garena/login/signup_screen.dart';
import 'package:garena/navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return WillPopScope(
      onWillPop: () async {
        // Show the alert dialog and wait for a result
        bool exit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit?'),
              actions: [
                ElevatedButton(
                  child: Text('No'),
                  onPressed: () {
                    // Return false to prevent the app from exiting
                    Navigator.pop(context);
                    Navigator.of(context).pop(false);
                  },
                ),
                ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () {
                    ff();
                    // Return true to allow the app to exit
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );

        // Return the result to handle the back button press
        return exit ?? false;
      },
      child:
          Container(
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
                      SizedBox(height: 100,),
                      Text("Welcome to,", style: TextStyle( fontFamily: "font1", fontSize: 30, color : Color(0xff5E01F2), fontWeight: FontWeight.w800)),
                      Text("Game Terminal", style: TextStyle( fontFamily: "font1", fontSize: 31, color : Color(0xff5E01F2), fontWeight: FontWeight.w800)),
                      SizedBox(height: 25,),
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
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: '  Password', isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0), // Adjust the value as needed
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please type your Password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            s = value;
                          });
                        },
                      ),
                      Row(
                        children :[
                          Spacer(),
                          TextButton(onPressed: () {
                            Navigator.push(
                                context, PageTransition(
                                child: Forgot(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                            ));
                          }, child: Text("Forgot Password?"),),
                        ]
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(height: 10,),

                      SocialLoginButton(
                        backgroundColor:  Color(0xff6001FF),
                        height: 40,
                        text: 'Login Now',
                        borderRadius: 20,
                        fontSize: 21,
                        buttonType: SocialLoginButtonType.generalLogin,
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: d,
                              password: s,
                            );
                            Navigator.push(
                                context, PageTransition(
                                child: Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                            ));

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No User found for this Email'),
                                ),
                              );
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Wrong password provided for that user.'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${e}'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: 15,),
                      Center(child: Text("Or")),
                      SizedBox(height: 15,),
                      SocialLoginButton(
                        backgroundColor: Colors.white,
                        height: 40,
                        text: 'Login with Google',
                        borderRadius: 20,
                        fontSize: 21,
                        buttonType: SocialLoginButtonType.google,
                        imageWidth: 20,
                        onPressed: () {
                          googlesignin();
                        },
                      ),
                      SizedBox(height: 15,),

                          Center(
                            child: TextButton(onPressed: () {
                              Navigator.push(
                                  context, PageTransition(
                                  child: SignUp(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                              ));
                            }, child: Text("Don't have Account? Sign Up"),),
                          ),


                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
          )
    );
  }
}
