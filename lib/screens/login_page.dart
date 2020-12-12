import 'package:flutter/material.dart';
import 'package:gst_sys/animations/wave.dart';
import 'package:gst_sys/services/blockchain.dart';
import 'package:gst_sys/screens/main_menu.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'govt_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String gst;
  String pwd;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(children: [
            Container(
              height: size.height - 450,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange[400],
                      Colors.white,
                      Colors.green[700],
                    ]),
              ),
              child: Center(
                child: Text('LOGIN',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Alfa Slab One')),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: keyboardOpen ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size,
                yOffset: size.height / 3.0,
                color: Colors.white,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.orange[500]),
                                top: BorderSide(color: Colors.orange[500]),
                                left: BorderSide(color: Colors.orange[500]),
                                right: BorderSide(color: Colors.orange[500]))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "GST NUMBER",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            gst = val;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.orange[500]),
                                top: BorderSide(color: Colors.orange[500]),
                                left: BorderSide(color: Colors.orange[500]),
                                right: BorderSide(color: Colors.orange[500]))),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "PASSWORD",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            pwd = val;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: Colors.orange[500],
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        height: 60,
                        onPressed: () async {
                          if(gst==null ||pwd==null)
                          {
                            Fluttertoast.showToast(
                                msg: "INVALID LOGIN",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          else if (gst == "admin") {
                            String a = await Blockchain().govtLogin(gst, pwd);
                            if (a == "Login Sucessful") {
                               Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: GovtPage(uid:gst),
                                    ctx: context),
                              );
                              return;
                            }
                          }
                          else
                          {String a = await Blockchain().login(gst, pwd);
                          if (a == "Login Sucessful") {
                            SharedPreferences _obj = await SharedPreferences.getInstance();
                            _obj.setString('uid',gst);
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: MainMenu(uid: gst),
                                  ctx: context),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "INVALID LOGIN",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }},
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
                        height: 10,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Align(alignment: Alignment.bottomCenter,
                                              child: Text(
                          "Made With ❤ by codewiz",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                    ],
                  ),
                ))
          ]),
        ));
  }
}
