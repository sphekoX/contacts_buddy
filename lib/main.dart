import 'package:flutter/material.dart';
import 'package:contacts_buddy/demo.dart';
import 'package:contacts_buddy/splash.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  //to avoid any crash
  //add ensureInitialized() before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
            duration: 9000,
            splash: const Splash(),
            nextScreen: const Demo(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromARGB(255, 49, 44, 255),)                
     // routes: {
     //   '/': (context) => Splash(),
     //  '/demo': (context) => Demo(),
     //  }
      //create a new class for this
      //home: Splash(),
    );
    
  }
}
