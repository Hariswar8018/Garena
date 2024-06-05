import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/material.dart';
import 'package:garena/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garena/firebase_options.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/navigation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

String user = FirebaseAuth.instance.currentUser!.uid ;

class MyApp extends StatelessWidget {
  MyApp({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Game Terminal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed( seedColor: Color( 0xFF053149 )),
          useMaterial3: true,
          textTheme: TextTheme(
            displayLarge: TextStyle(color: Colors.white),
            displaySmall: TextStyle(color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
            // Define your app bar background color
            color: Color(0xFF053149),
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            toolbarTextStyle: TextTheme(
              headline6: TextStyle(color: Colors.white),
            ).bodyText2,
            titleTextStyle: TextTheme(
              headlineMedium: TextStyle(color: Colors.white),
              headlineSmall: TextStyle(color: Colors.white),
              headlineLarge: TextStyle(color: Colors.white),
            ).headline6 ,
          ),
        ),
        debugShowCheckedModeBanner : false,
        home: user == null ? LoginScreen() : Navigation(),
      ),
    );
  }
}
