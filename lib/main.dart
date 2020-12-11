import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gst_sys/screens/regeister_form.dart';
import 'package:gst_sys/screens/start_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/login_page.dart';

void main() {
 
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: SizedBox(
          height: 1000.0,
          width: 1000.0,
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/irs.png',
            ),
          ),
        ),
        nextScreen: Start(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
       onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/zero':
            return PageTransition(
              child: Start(),
              type: PageTransitionType.fade,
              settings: settings,
            );
            break;
          case '/first':
            return PageTransition(
              child: LoginPage(),
              type: PageTransitionType.rightToLeft,
              settings: settings,
            );
            break;
          case '/second':
            return PageTransition(
              child: RegisterPage(),
              type: PageTransitionType.rightToLeft,
              settings: settings,
            );
            break;
          default:
            return null;
        }
       }
    );
  }
}
