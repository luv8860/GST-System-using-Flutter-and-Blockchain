import 'package:flutter/material.dart';
import 'package:gst_sys/services/blockchain.dart';
import 'package:page_transition/page_transition.dart';

import 'login_page.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String name, pwd, gst, adhano, bkno, phno, balno;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange[700],
              Colors.orange,
              Colors.white,
              Colors.green,
              Colors.green[700],
            ]),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 55,
          ),
          Text('REGISTER',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Alfa Slab One')),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  // borderRadius: BorderRadius.all(Radius.circular(70)),
                  border: Border.all(
                    width: 1, //                   <--- border width here
                  ),
                ),
                child: ListView(children: [
                  Column(
                    children: [
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.orange[500]),
                                    top: BorderSide(color: Colors.orange[500]),
                                    left: BorderSide(color: Colors.orange[500]),
                                    right:
                                        BorderSide(color: Colors.orange[500]))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "BUSINESS NAME",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.orange[500]),
                                  top: BorderSide(color: Colors.orange[500]),
                                  left: BorderSide(color: Colors.orange[500]),
                                  right:
                                      BorderSide(color: Colors.orange[500]))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "AADHAR NUMBER",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              adhano = val;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.orange[500]),
                                  top: BorderSide(color: Colors.orange[500]),
                                  left: BorderSide(color: Colors.orange[500]),
                                  right:
                                      BorderSide(color: Colors.orange[500]))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.pages),
                                hintText: "GSTIN",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.orange[500]),
                                  top: BorderSide(color: Colors.orange[500]),
                                  left: BorderSide(color: Colors.orange[500]),
                                  right:
                                      BorderSide(color: Colors.orange[500]))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_balance),
                                hintText: "BANK ACCOUNT NUMBER",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              bkno = val;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.orange[500]),
                                  top: BorderSide(color: Colors.orange[500]),
                                  left: BorderSide(color: Colors.orange[500]),
                                  right:
                                      BorderSide(color: Colors.orange[500]))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: "PHONE NUMBER",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              phno = val;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.orange[500]),
                                  top: BorderSide(color: Colors.orange[500]),
                                  left: BorderSide(color: Colors.orange[500]),
                                  right:
                                      BorderSide(color: Colors.orange[500]))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_balance_wallet),
                                hintText: "ENTER BALANCE",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              balno = val;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.orange[500]),
                                  top: BorderSide(color: Colors.orange[500]),
                                  left: BorderSide(color: Colors.orange[500]),
                                  right:
                                      BorderSide(color: Colors.orange[500]))),
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
                      ),
                      SizedBox(height: 50),
                      MaterialButton(
                        color: Colors.orangeAccent[700],
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        height: 60,
                        onPressed: () async {
                         var result = await Blockchain().addBusiness(name, pwd,
                              gst, adhano, bkno, phno, int.parse(balno));
                          if (result != null) {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: LoginPage(),
                                  ctx: context),
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Create new Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
