import 'package:flutter/material.dart';
import 'package:gst_sys/services/blockchain.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends StatefulWidget {
  final String uid;
  Dashboard({@required this.uid});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var name = "waiting";
  var taxpaid;
  var balence;
  var bill;
  var accno;
  var phn;
  void getname() async {
    var result = await Blockchain().getBusiness(widget.uid);
    setState(() {
      accno = result[0];
      phn = result[4];
      name = result[2];
      taxpaid = result[7];
      balence = result[6];
      bill = result[8];
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
      backgroundColor: Colors.blue,
      body: name == "waiting"
          ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))
          : SafeArea(
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              name.text.xl4.white.maxLines(3).make().px8(),
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.transparent,
                                child: Image.asset("assets/irs.png"),
                              ).px12().shimmer()
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.vpn_key, color: Color(0xFFEDF2F7)),
                                SizedBox(width: 5),
                                widget.uid.text.xl.gray400.make(),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Color(0xFFEDF2F7)),
                                SizedBox(width: 5),
                                "$phn".text.xl.gray400.make(),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.attach_money,
                                    color: Color(0xFFEDF2F7)),
                                SizedBox(width: 5),
                                "$accno".text.xl.gray400.make(),
                              ],
                            ),
                          ],
                        ).box.make().px16(),
                        SizedBox(
                          height: 100,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                          ),
                        ).box.color(Colors.grey[300]).make()),
                        "Made With ❤ by codewiz"
                            .text
                            .black
                            .makeCentered()
                            .box
                            .width(MediaQuery.of(context).size.width)
                            .color(Colors.grey[300])
                            .py8
                            .make(),
                      ],
                    ),
                  ).box.color(Colors.blue).make(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(height:150),
                            valCard(
                                context,
                                "Balance",
                                "₹ " + balence.toString(),
                                Colors.red,
                                Colors.red[200],
                                "https://images.vexels.com/media/users/3/143188/isolated/preview/5f44f3160a09b51b4fa4634ecdff62dd-money-icon-by-vexels.png"),
                            valCard(
                                context,
                                "GST Paid",
                                "₹ " + taxpaid.toString(),
                                Colors.blue,
                                Colors.blue[200],
                                "https://images-na.ssl-images-amazon.com/images/I/61vySILjoaL.png"),
                            valCard(
                                context,
                                "Bill generated",
                                bill.toString(),
                                Colors.green,
                                Colors.green[200],
                                "https://image.flaticon.com/icons/png/512/1466/1466668.png"),
                          ],
                        )).box.make(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget valCard(BuildContext context, String title, String value, Color color1,
      Color color2, String imgurl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title".text.xl2.gray300.make(),
            SizedBox(
              height: 10,
            ),
            "$value".text.xl4.make(),
          ],
        ),
        Image.network(
          imgurl,
          height: 150,
          width: 150,
        ),
      ],
    )
        .box
        .margin(EdgeInsets.all(8.0))
        .shadow
        .px12
        .withDecoration(BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color1,
                color2,
                color1,
              ]),
        ))
        .height(MediaQuery.of(context).size.height * 0.22)
        .width(MediaQuery.of(context).size.width * 0.95)
        .make();
  }
}
