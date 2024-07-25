
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/login/login_screen.dart';
import 'package:garena/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:garena/navigation.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

bool _isLoggedIn = false;
String name = "Nijino Yume";
String d = "demo@gmail.com";

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _name1Controller = TextEditingController();
  final username = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  static String s = "Demo";

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  // Check if user is already logged in

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void googlesignin() async {
    final googleSignIn = GoogleSignIn();
    final signinAccount = await googleSignIn.signIn();

    final googleAcc = await signinAccount!.authentication;
    final creditential = GoogleAuthProvider.credential(
        accessToken: googleAcc.accessToken, idToken: googleAcc.idToken);

    await FirebaseAuth.instance.signInWithCredential(creditential);

    if (FirebaseAuth.instance.currentUser != 0.0) {
      print("Successfull");
      print('${FirebaseAuth.instance.currentUser!.displayName} signedin.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Success, Welcome ${FirebaseAuth.instance.currentUser!.displayName}'),
      ));
    } else {
      print("Unable to Sign In");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      child:  Container(
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
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50,),
                      Text("Welcome to,", style: TextStyle( fontFamily: "font1", fontSize: 30, color : Color(0xff5E01F2), fontWeight: FontWeight.w800)),
                      Text("Game Terminal", style: TextStyle( fontFamily: "font1", fontSize: 31, color : Color(0xff5E01F2), fontWeight: FontWeight.w900)),
                      SizedBox(height: 25,),
                      O(_nameController, "First Name"),
                      O(_name1Controller, "Last Name"),
                      O(username, "Username"),
                      O(_emailController, "Email"),
                      O(_confirmPasswordController, "Password"),
                      SizedBox(height: 30.0),
                      Center(child: Text("By Registering I agree to Terms & Condition")),
                      Center(child: Text("and Privacy Policy of App")),
                      SizedBox(height: 10.0),
                      SocialLoginButton(
                        backgroundColor: Color(0xff6001FF),
                        height: 40,
                        text: 'Sign Up Now',
                        borderRadius: 20,
                        fontSize: 21,
                        buttonType: SocialLoginButtonType.generalLogin,
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _confirmPasswordController.text,
                            );
                            print(credential);
                            String sn = credential.user!.uid ;
                            UserModel u = UserModel(Chess_Level: "", Email: _emailController.text, Name: username.text,
                                Pic_link: "", Bio: "", Draw: 0, Gender: "Male",
                                Language: _nameController.text + _name1Controller.text , Location: "", Lose: 0,
                                Talk: "NA", Won: 0.2, uid: sn, Lat: 8.8, Lon: 9.3,
                                lastlogin: "n", code: "", age: "21", lastloginn: "n", bonus: 0.0, deposit: 0.0,  utilize: 0.0, win: 0.0) ;
                            await _firestore.collection('users').doc(sn).set(u.toJson());
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: Navigation(),
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 100)));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Welcome to Game Terminal ' + _nameController.text + _name1Controller.text ),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'The password provided is too weak.'),
                                ),
                              );
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'The account already exists for that email.'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${e}'),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${e}'),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),

                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: LoginScreen(),
                                        type: PageTransitionType.leftToRight,
                                        duration: Duration(milliseconds: 100)));
                              },
                              child: Text("ALready have Account? Log in"),
                            ),
                          ),
                      SizedBox(height: 5,),
                      Center(child: Text("Or")),
                      SizedBox(height: 10,),
                      SocialLoginButton(
                        backgroundColor: Colors.white,
                        height: 40,
                        text: 'Sign Up with Google',
                        borderRadius: 20,
                        fontSize: 21,
                        buttonType: SocialLoginButtonType.google,
                        imageWidth: 20,
                        onPressed: () {
                          googlesignin();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
  Widget O(TextEditingController c, String st){
    return Padding(
      padding: const EdgeInsets.only( top : 8.0, bottom : 5),
      child: TextFormField(
          controller: c,
          decoration: InputDecoration(
            labelText: '  $st',
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0), // Adjust the value as needed
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              name = value;
            });
          }),
    );
  }
}
