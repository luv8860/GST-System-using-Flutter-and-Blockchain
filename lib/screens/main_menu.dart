import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gst_sys/screens/dashboard.dart';
import 'package:gst_sys/services/blockchain.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String Subscribe = 'Profile';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[Subscribe, SignOut];
}

class MainMenu extends StatefulWidget {
  final String uid;
  MainMenu({Key key, @required this.uid}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState(uid);
}

class _MainMenuState extends State<MainMenu> {
  final String uid;
  _MainMenuState(this.uid);
  void choiceAction(String choice) async{
    if (choice == Constants.Subscribe) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Dashboard(uid: uid)));
    } else if (choice == Constants.SignOut) {
      SharedPreferences _obj = await SharedPreferences.getInstance();
      _obj.remove('uid');
      Navigator.of(context).popUntil((route) => route.isFirst);
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => Start()));
    }
  }

  var name;
  void getname() async {
    var result = await Blockchain().getBusiness(uid);
    setState(() {
      name = result[2];
    });
  }

  @override
  void initState() {
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xEEEFFFFF),
        body: name == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  SizedBox(height: 40),
                  Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 10,top:50,right:15),
                            child: Text('Hello $name!',
                                style: TextStyle(
                                  fontFamily: 'Varela',
                                  fontSize: 48.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                )),
                          ),
                        ]),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                  child: Text(
                                'Please select the suitable options below for your Taxing purpose',
                                style: TextStyle(
                                    fontFamily: 'nunito',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54),
                              ))),
                  ]),
                  SizedBox(height: 33.0),
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.transparent,
                        ),
                        child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(height:200),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: FlatButton(
                                  child: Card(
                                      imglink: 'assets/bill1.png',
                                      name: 'Generate New Bill',
                                      text:
                                          "Click Here to \nGENERATE new bill"),
                                  onPressed: () {
                                    buildShowModalBottomSheet(context);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: FlatButton(
                                  child: Card(
                                      imglink: 'assets/bill2.png',
                                      name: 'Search for Bill',
                                      text: "Click Here to \nSEARCH for bill"),
                                  onPressed: () {
                                    buildShowModalBottomSheet2(context);
                                  },
                                ),
                              ),
                               
                            ])),
                  ),
                  Positioned( top:50,right: 3,
                                      child: PopupMenuButton<String>(
                              color: Colors.white,
                              onSelected: choiceAction,
                              itemBuilder: (BuildContext context) {
                                return Constants.choices.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ),
                  ),
                ]),
              ));
  }

  Future buildShowModalBottomSheet2(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    int billNo;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.64,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            color: Colors.white,
            child: ListView(controller: scrollController, children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText('SEARCH NEW BILL',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Alfa Slab One')),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.blue[500]),
                                top: BorderSide(color: Colors.blue[500]),
                                left: BorderSide(color: Colors.blue[500]),
                                right: BorderSide(color: Colors.blue[500]))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.format_indent_increase),
                              hintText: "BILL NUMBER",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            billNo = int.parse(val);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: MaterialButton(
                        color: Colors.blue[500],
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        child: Text("Find the Bill",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          var lst = await Blockchain()
                              .getBill(BigInt.from(billNo), uid);

                          if (lst[0] == '') {
                            print(lst);
                            Fluttertoast.showToast(
                                msg: "Bill Not found",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            print(lst);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => DraggableScrollableSheet(
                                initialChildSize: 0.64,
                                minChildSize: 0.2,
                                maxChildSize: 1,
                                builder: (context, scrollController) {
                                  return Container(
                                    color: Colors.white,
                                    child: ListView(
                                        controller: scrollController,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(height: 50),
                                              AutoSizeText('BILL DETAILS',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontFamily:
                                                          'Alfa Slab One')),
                                              SizedBox(height: 20),
                                              titleText("Bill Number"),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          top: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          left: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          right: BorderSide(
                                                              color:
                                                                  Colors.blue[
                                                                      500]))),
                                                  child: TextField(
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                        prefixIcon: Icon(Icons
                                                            .format_indent_increase),
                                                        hintText: "$billNo",
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ),
                                              titleText("Aadhar Number"),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          top: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          left: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          right: BorderSide(
                                                              color:
                                                                  Colors.blue[
                                                                      500]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        prefixIcon: Icon(Icons
                                                            .perm_identity),
                                                        hintText: lst[1],
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ),
                                              titleText("Phone Number"),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          top: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          left: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          right: BorderSide(
                                                              color:
                                                                  Colors.blue[
                                                                      500]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        prefixIcon:
                                                            Icon(Icons.phone),
                                                        hintText:
                                                            " +91 " + lst[2],
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ),
                                              titleText("Bill Amount"),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          top: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          left: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          right: BorderSide(
                                                              color:
                                                                  Colors.blue[
                                                                      500]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        prefixIcon: Icon(Icons
                                                            .account_balance_wallet),
                                                        hintText:
                                                            lst[3].toString(),
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ),
                                              titleText("GST Paid"),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          top: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          left: BorderSide(
                                                              color: Colors
                                                                  .blue[500]),
                                                          right: BorderSide(
                                                              color:
                                                                  Colors.blue[
                                                                      500]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        prefixIcon: Icon(Icons
                                                            .account_balance_wallet),
                                                        hintText:
                                                            lst[4].toString(),
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 30)
                                            ],
                                          ),
                                        ]),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  Future buildShowModalBottomSheet(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String billno, adhano, cusphono, amt, tgst;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.64,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            color: Colors.white,
            child: ListView(controller: scrollController, children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    AutoSizeText(
                      'GENERATE NEW BILL',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Alfa Slab One'),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.blue[500]),
                                top: BorderSide(color: Colors.blue[500]),
                                left: BorderSide(color: Colors.blue[500]),
                                right: BorderSide(color: Colors.blue[500]))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.format_indent_increase),
                              hintText: "BILL NUMBER",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            billno = val;
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
                                bottom: BorderSide(color: Colors.blue[500]),
                                top: BorderSide(color: Colors.blue[500]),
                                left: BorderSide(color: Colors.blue[500]),
                                right: BorderSide(color: Colors.blue[500]))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity),
                              hintText: "CUSTOMER AADHAR NUMBER",
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
                                bottom: BorderSide(color: Colors.blue[500]),
                                top: BorderSide(color: Colors.blue[500]),
                                left: BorderSide(color: Colors.blue[500]),
                                right: BorderSide(color: Colors.blue[500]))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: " CUSTOMER PHONE NUMBER",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            cusphono = val;
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
                                bottom: BorderSide(color: Colors.blue[500]),
                                top: BorderSide(color: Colors.blue[500]),
                                left: BorderSide(color: Colors.blue[500]),
                                right: BorderSide(color: Colors.blue[500]))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_balance_wallet),
                              hintText: "AMOUNT PAID",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            amt = val;
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
                                bottom: BorderSide(color: Colors.blue[500]),
                                top: BorderSide(color: Colors.blue[500]),
                                left: BorderSide(color: Colors.blue[500]),
                                right: BorderSide(color: Colors.blue[500]))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_balance_wallet),
                              hintText: "TOTAL GST PAID",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            tgst = val;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: MaterialButton(
                        color: Colors.blue[500],
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        child: Text("Generate the Bill",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          var string = await Blockchain().genBill(
                              int.parse(billno),
                              adhano,
                              cusphono,
                              int.parse(amt),
                              int.parse(tgst),
                              uid);
                          if (string != null) {
                            print("Bill Generated");
                            Fluttertoast.showToast(
                                msg: "Bill Generated!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.greenAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String imglink;
  final String name;
  final String text;
  Card(
      {Key key,
      @required this.imglink,
      @required this.name,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.blue[600],
                  Colors.blue,
                ]
              ),
              boxShadow: [
                //background color of box
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 30.0, // soften the shadow //extend the shadow
                )
              ],
              borderRadius: BorderRadius.circular(15.0),
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [
              //       Colors.blue[700],
              //       Colors.blue[500],
              //       Colors.blue[700],
              //     ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
                Image.asset(imglink, height: 70)
              ],
            )));
  }
}

Widget titleText(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 12, top: 20),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue[200],
          fontFamily: 'Alfa Slab One',
          fontSize: 16,
        ),
      ),
    ),
  );
}
