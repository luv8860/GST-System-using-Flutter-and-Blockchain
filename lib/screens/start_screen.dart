import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'login_page.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange,
                Colors.orange[200],
                Colors.white,
                Colors.white,
                Colors.green[400],
                Colors.green[700],
              ]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Container(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/irs.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Text('GST SYSTEM',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Alfa Slab One')),
            SizedBox(
              height: 50.0,
            ),
            MaterialButton(
              color: Colors.brown[300],
              minWidth: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              onPressed: () {
                 Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: LoginPage(),
                      ctx: context),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              color: Colors.brown[300],
              minWidth: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              onPressed: () { },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                "Register",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
