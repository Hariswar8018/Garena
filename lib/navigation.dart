
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garena/main_page/home.dart';
import 'package:garena/main_page/profile.dart';
import 'package:garena/main_page/wallet.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/other/league.dart';
import 'package:provider/provider.dart';
import 'package:garena/main_page/my_battle.dart';

class Navigation extends StatefulWidget{
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>{
  initState() {
    super.initState();
    vq();
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }

  final user = FirebaseAuth.instance.currentUser;

  int currentTab=0;
  final Set screens ={
    Home(),
    Gamyy(),
    Wallet(),
    Profile(),
  };

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();
  @override
  Widget build(BuildContext context){
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
        child: Container(
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
            body: PageStorage(
              child: currentScreen,
              bucket: bucket,
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                color: Colors.transparent,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                        minWidth: 40, onPressed: (){
                      setState(() {
                        currentScreen = Home();
                        currentTab = 0;
                      });
                    },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: currentTab == 0? Colors.blue:Colors.black,
                            ),
                            Text("Home", style: TextStyle(color: currentTab == 0? Colors.blue:Colors.black,))
                          ],
                        )
                    ),
                    MaterialButton(
                      minWidth: 40, onPressed: (){
                      setState(() {
                        currentScreen = Gamyy();
                        currentTab = 1;
                      });
                    },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.gamepad,
                            color: currentTab == 1? Colors.blue:Colors.black,
                          ),
                          Text("League", style: TextStyle(color: currentTab == 1? Colors.blue:Colors.black,))
                        ],
                      ),
                    ),
                    MaterialButton(
                        minWidth: 40, onPressed: (){
                      setState(() {
                        currentScreen = Wallet();
                        currentTab = 2;
                      });
                    },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_wallet_rounded,
                              color: currentTab == 2? Colors.blue:Colors.black,
                            ),
                            Text("Wallet", style: TextStyle(color: currentTab == 2? Colors.blue:Colors.black,))
                          ],
                        ),
                    ),
                    MaterialButton(
                        minWidth: 40, onPressed: (){
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 3;
                      });
                    },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.supervised_user_circle_rounded,
                              color: currentTab == 3? Colors.blue:Colors.black,
                            ),
                            Text("Profile", style: TextStyle(color: currentTab == 3? Colors.blue:Colors.black,))
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
