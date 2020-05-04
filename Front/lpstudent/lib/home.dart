import 'dart:convert';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'settings.dart';
import 'announcements.dart';
import 'storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'saved.dart';
import 'package:url_launcher/url_launcher.dart';
import 'calendar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'time.dart';
import 'picture.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'schedule.dart';
import 'clubs.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'dart:core';

class Home extends StatefulWidget {
  final String user;
  Home({Key key, this.user})
      : super(key: key); // user must be passed between pages to retain state

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var f = new NumberFormat("###,###", "en_US");
  bool _visible = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<void> toggleID() async {
    return YYDialog().build(context)
      ..width = 300
      ..height = 520
      ..borderRadius = 15
      ..widget(Padding(
        padding: EdgeInsets.all(0.0),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(widget.user.substring(0, 6))
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(
                    // child: CircularProgressIndicator(
                    //     backgroundColor: Colors.greenAccent)
                    );
              return Center(
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,children: [IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  },icon: Icon(Icons.clear))],),
                  Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: ClipOval(
                              child:
                                  Image.network(snapshot.data['photoURL'])))),
                  Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Text(
                        snapshot.data['firstName'] +
                            " " +
                            snapshot.data['lastName'],
                        style: TextStyle(fontSize: 35),
                      )),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: QrImage(
                            data: widget.user.substring(0, 6),
                            version: QrVersions.auto,
                            size: 220)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        widget.user.substring(0, 6),
                        style: TextStyle(fontSize: 17),
                      ))
                ]),
              );
            }),
      ))
      ..show();
  }

  void pushUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // double percent = 1 - (((((DateTime.now().hour*60) + DateTime.now().minute) * 60) + DateTime.now().second) / int.parse(Time.nextHourTime()));
  double percent =
      (((((DateTime.now().hour * 60) + DateTime.now().minute) * 60) +
                  DateTime.now().second) -
              Time.previousHourTime()) /
          (Time.nextHourTime() - Time.previousHourTime());
  void bar() {
    if (Time.hourTimeCheck()){
      setState(() {
        percent = ((((
          (DateTime.now().hour * 60) + DateTime.now().minute) * 60) + DateTime.now().second) // This gets the ammount of seconds it currently is from midnight
          -
          Time.currentHourTime()) // This gets the ammount of seconds the start of a given hour was since midnight
          /
          (Time.nextHourTime() - Time.currentHourTime()); // This gets the range of seconds that class is
      });
    }
    else {
      percent = 0;
    }
  }

  @override
  void initState() {
    Timer timer = new Timer.periodic(Duration(seconds: 1), (Timer t) {
      // print(Time.getCurrentIndex());
      bar();
      // print(percent);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(Time.hourTimeCheck());
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset('assets/images/LP_Student/LP_Student.png',
                      width: 40, height: 40),
                  leading: Builder(
                    builder: (context) => IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.grey,
                        )),
                  ),
                  actions: [
                    IconButton(
                        icon: Icon(
                          Icons.credit_card,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          toggleID();
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings(
                                      user: widget.user,
                                    )),
                          );
                        })
                  ],
                  backgroundColor: Colors.white,
                ),
                bottomSheet: SizedBox(
                  height: 78,
                  child: Stack(children: <Widget>[
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      // "1st",
                                      Time.previousHourName(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Text(
                                      // "1",
                                      Time.previousHourStringTime(),
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      // "2nd",
                                      Time.currentHourName(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                      // "2",
                                      "Now",
                                      style: TextStyle(color: Colors.black))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      // "3rd",
                                      Time.nextHourName(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Text(
                                      // "3",
                                      Time.nextHourStringTime(),
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ],
                          )),
                      LinearPercentIndicator(
                        width:
                            MediaQuery.of(context).size.width, // screen width
                        lineHeight: 10,
                        percent: percent,
                        isRTL: false,
                        backgroundColor: Colors.grey[300],
                        progressColor: Colors.green,
                        // linearStrokeCap: LinearStrokeCap.butt, flat end
                        // animationDuration: 5000,
                      )
                    ]),
                    Container(
                        color: Color.fromARGB(_visible ? 200 : 0, 0, 0, 0)),
                  ]),
                ),
                drawer: Drawer(
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('users')
                            .document(widget.user.substring(0, 6))
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.greenAccent));
                          return Padding(
                              padding: EdgeInsets.only(top: 45),
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Card(
                                          elevation: 15,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: ClipOval(
                                              child: Image.network(
                                                  snapshot.data['photoURL']))),
                                      Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    snapshot.data['firstName'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 29,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  )),
                                              Text(
                                                snapshot.data['lastName'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 29,
                                                ),
                                                textAlign: TextAlign.left,
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: ListView(
                                  children: ListTile.divideTiles(
                                    context: context,
                                    tiles: [
                                      ListTile(
                                        title: Row(children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 1, right: 15),
                                              child: Card(
                                                  elevation: 2,
                                                  color: Colors.yellow,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500)),
                                                  child: ClipOval(
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                      size: 36,
                                                    ),
                                                  ))),
                                          Text('Saved Announcements')
                                        ]),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Saved(
                                                      user: widget.user,
                                                    )),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: Row(children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 13),
                                              child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500)),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      "assets/images/Services/Classroom.png",
                                                      scale: 7,
                                                    ),
                                                  ))),
                                          Text("Google Classroom")
                                        ]),
                                        onTap: () => pushUrl(
                                            "https://classroom.google.com/u/0/h"),
                                      ),
                                      ListTile(
                                        title: Row(children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 13),
                                              child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500)),
                                                  child: ClipOval(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 7,
                                                                left: 7.75,
                                                                right: 7.75,
                                                                bottom: 7),
                                                        child: Image.asset(
                                                          "assets/images/Services/Outlook.png",
                                                          scale: 14,
                                                        )),
                                                  ))),
                                          Text("Outlook")
                                        ]),
                                        onTap: () => pushUrl(
                                            "https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=13&ct=1587651192&rver=7.0.6737.0&wp=MBI_SSL&wreply=https%3a%2f%2foutlook.live.com%2fowa%2f%3fnlp%3d1%26RpsCsrfState%3d04a7ea7b-3427-112f-6853-dc5ae99feaba&id=292841&aadredir=1&CBCXT=out&lw=1&fl=dob%2cflname%2cwld&cobrandid=90015"),
                                      ),
                                      ListTile(
                                        title: Row(children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 13),
                                              child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500)),
                                                  child: ClipOval(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                left: 6.75,
                                                                right: 6.75,
                                                                bottom: 5),
                                                        child: Image.asset(
                                                          "assets/images/LP/LP_Original.png",
                                                          scale: 12,
                                                        )),
                                                  ))),
                                          Text("LP's Website")
                                        ]),
                                        onTap: () =>
                                            pushUrl("https://www.lphs.net/"),
                                      ),
                                      ListTile(
                                        title: Row(children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2, right: 13),
                                              child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500)),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      "assets/images/Services/PowerSchool.jpg",
                                                      scale: 11,
                                                    ),
                                                  ))),
                                          Text('PowerSchool')
                                        ]),
                                        onTap: () => pushUrl(
                                            "https://ps.lphs.net/public/home.html"),
                                      ),
                                      ListTile(
                                        title: Row(children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 14),
                                              child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500)),
                                                  child: ClipOval(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 9,
                                                                left: 4,
                                                                right: 4,
                                                                bottom: 9),
                                                        child: Image.asset(
                                                          "assets/images/Services/Efunds.jpg",
                                                          scale: 10,
                                                        )),
                                                  ))),
                                          Text('Efunds')
                                        ]),
                                        onTap: () => pushUrl(
                                            "https://payments.efundsforschools.com/v3/districts/56042"),
                                      ),
                                      ListTile(
                                          title: Row(children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1, right: 14),
                                                child: Card(
                                                    elevation: 2,
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        500)),
                                                    child: ClipOval(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Icon(
                                                        Icons.book,
                                                        color: Colors.brown,
                                                        size: 28,
                                                      ),
                                                    )))),
                                            Text('Handbook')
                                          ]),
                                          onTap: () {
                                            pushUrl("https://docs.google.com/viewerng/viewer?url=https://www.lphs.net//cms/lib/IL01904775/Centricity/Domain/31/Documents/2019-20+Student+Handbook+Final.pdf");
                                          }),
                                    ],
                                  ).toList(),
                                )),
                                Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      children: <Widget>[
                                        SignInButton(
                                          Buttons.Facebook,
                                          mini: true,
                                          onPressed: () => pushUrl(
                                              "https://www.facebook.com/lphs120/"),
                                        ),
                                        SignInButton(
                                          Buttons.Twitter,
                                          mini: true,
                                          onPressed: () => pushUrl(
                                              "https://twitter.com/LPCavaliers?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor"),
                                        ),
                                        SignInButton(
                                          Buttons.Youtube,
                                          mini: true,
                                          onPressed: () => pushUrl(
                                              "https://www.youtube.com/user/LPCavaliers"),
                                        ),
                                      ],
                                    ))
                              ]));
                        })),
                body: StreamBuilder(
                    stream: Firestore.instance
                        .collection('generalData')
                        .document(Time.getWeekdayName(Time.activeIntDay)
                            .toLowerCase())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      return Padding(
                          padding: EdgeInsets.only(bottom: 85),
                          child: Container(
                              child: Stack(children: [
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //MAJOR AXIS COLUMN
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Announcements(
                                                      value: Time.getWeekdayName(
                                                              Time.activeIntDay)
                                                          .toLowerCase(),
                                                      picture:
                                                          Picture.pickAll(),
                                                      user: widget.user,
                                                    )),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, left: 7, right: 7),
                                          child: SizedBox(
                                              height: 225,
                                              child: Card(
                                                elevation: 4.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    child: Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          Image.asset(
                                                            Picture.pickAll(),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          Container(
                                                              color:
                                                                  Color.fromARGB(
                                                                      30,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(12),
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child:
                                                                  StreamBuilder(
                                                                      stream: Firestore
                                                                          .instance
                                                                          .collection(
                                                                              'generalData')
                                                                          .document(Time.getWeekdayName(Time.activeIntDay)
                                                                              .toLowerCase())
                                                                          .snapshots(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (!snapshot
                                                                            .hasData)
                                                                          return const Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              backgroundColor: Colors.green,
                                                                            ),
                                                                          );
                                                                        return Text(
                                                                          snapshot
                                                                              .data['date'],
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 35,
                                                                              color: Colors.white),
                                                                        );
                                                                      }))
                                                        ])),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 7, left: 7, right: 7),
                                        child: Container(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                      child: Container(
                                                          child: FlatButton(
                                                              onPressed: () {
                                                                if (Time
                                                                    .getState(
                                                                        1)) {
                                                                  setState(() {
                                                                    Time.updateActiveDay(
                                                                        1);
                                                                  });
                                                                } else {
                                                                  null;
                                                                }
                                                              },
                                                              child: Text('M',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Time.activeIntDay == 1 || Time.activeIntDay > 5 // Monday should appear green even if it is the weekend.
                                                                          ? Colors.green
                                                                          : Time.getState(1) ? Colors.black : Colors.grey,
                                                                      fontSize: 18))))),
                                                  Flexible(
                                                      child: Container(
                                                          child: FlatButton(
                                                              onPressed: () {
                                                                if (Time
                                                                    .getState(
                                                                        2)) {
                                                                  setState(() {
                                                                    Time.updateActiveDay(
                                                                        2);
                                                                  });
                                                                } else {
                                                                  null;
                                                                }
                                                              },
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child: Text('T',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Time.activeIntDay == 2
                                                                          ? Colors
                                                                              .green
                                                                          : Time.getState(2)
                                                                              ? Colors
                                                                                  .black
                                                                              : Colors
                                                                                  .grey,
                                                                      fontSize:
                                                                          18))))),
                                                  Flexible(
                                                      child: Container(
                                                          child: FlatButton(
                                                              onPressed: () {
                                                                if (Time
                                                                    .getState(
                                                                        3)) {
                                                                  setState(() {
                                                                    Time.updateActiveDay(
                                                                        3);
                                                                  });
                                                                } else {
                                                                  null;
                                                                }
                                                              },
                                                              child: Text('W',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Time.activeIntDay == 3
                                                                          ? Colors
                                                                              .green
                                                                          : Time.getState(3)
                                                                              ? Colors
                                                                                  .black
                                                                              : Colors
                                                                                  .grey,
                                                                      fontSize:
                                                                          18))))),
                                                  Flexible(
                                                      child: Container(
                                                          child: FlatButton(
                                                              onPressed: () {
                                                                if (Time
                                                                    .getState(
                                                                        4)) {
                                                                  setState(() {
                                                                    Time.updateActiveDay(
                                                                        4);
                                                                  });
                                                                } else {
                                                                  null;
                                                                }
                                                              },
                                                              child: Text('T',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Time.activeIntDay == 4
                                                                          ? Colors
                                                                              .green
                                                                          : Time.getState(4)
                                                                              ? Colors
                                                                                  .black
                                                                              : Colors
                                                                                  .grey,
                                                                      fontSize:
                                                                          18))))),
                                                  Flexible(
                                                      child: Container(
                                                          child: FlatButton(
                                                              onPressed: () {
                                                                if (Time
                                                                    .getState(
                                                                        5)) {
                                                                  setState(() {
                                                                    Time.updateActiveDay(
                                                                        5);
                                                                  });
                                                                } else {
                                                                  null;
                                                                }
                                                              },
                                                              child: Text('F',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Time.activeIntDay == 5
                                                                          ? Colors
                                                                              .green
                                                                          : Time.getState(5)
                                                                              ? Colors
                                                                                  .black
                                                                              : Colors
                                                                                  .grey,
                                                                      fontSize:
                                                                          18))))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 7, right: 7),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Cafeteria Menu",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Breakfast",
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  SizedBox(
                                                      width: 50,
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              // return object of type Dialog
                                                              return AlertDialog(
                                                                title: new Text(
                                                                    "Breakfast"),
                                                                content: new Text(
                                                                    snapshot.data[
                                                                        'breakfast']),
                                                                actions: <
                                                                    Widget>[
                                                                  // usually buttons at the bottom of the dialog
                                                                  new FlatButton(
                                                                    child:
                                                                        new Text(
                                                                      "Close",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Text("+",
                                                            style: TextStyle(
                                                                fontSize: 29)),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Lunch",
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  SizedBox(
                                                      width: 50,
                                                      child: FlatButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  title: new Text(
                                                                      "Lunch"),
                                                                  content: new Text(
                                                                      snapshot.data[
                                                                          'lunch']),
                                                                  actions: <
                                                                      Widget>[
                                                                    // usually buttons at the bottom of the dialog
                                                                    new FlatButton(
                                                                      child:
                                                                          new Text(
                                                                        "Close",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Text(
                                                            "+",
                                                            style: TextStyle(
                                                                fontSize: 29),
                                                          )))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 7, right: 7),
                                    child: Column(children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Calendar(
                                                            user: widget.user,
                                                          )));
                                            },
                                            child: Card(
                                              color: Colors.red,
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 8,
                                                    right: 8),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          "Calendar ",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Icon(
                                                          Icons.event,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Schedule(
                                                            user: widget.user,
                                                          )));
                                            },
                                            child: Card(
                                              color: Colors.green,
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 8,
                                                    right: 8),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "Schedule ",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.dashboard,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Clubs(
                                                            user: widget.user,
                                                          )));
                                            },
                                            child: Card(
                                              color: Colors.red,
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 8,
                                                    right: 8),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "Clubs ",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.assignment,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                  StreamBuilder(
                                      stream: Firestore.instance
                                          .collection('users')
                                          .document(widget.user.substring(0, 6))
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot == null ||
                                            snapshot.hasError ||
                                            widget.user == null)
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );

                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 7, right: 7),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(f.format(
                                                        snapshot
                                                            .data['points'])),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Text(
                                                      "LP Points",
                                                      style: TextStyle(
                                                          fontSize: 26),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 15),
                                                      child: Text("10,000")),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: null,
                                                child: Card(
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            LinearPercentIndicator(
                                                              animation: true,
                                                              animationDuration:
                                                                  2000,
                                                              lineHeight: 10,
                                                              percent: snapshot
                                                                          .data[
                                                                      'points'] /
                                                                  10000.0,
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      200],
                                                              progressColor:
                                                                  Colors.red,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                ]),
                          ])));
                    }))));
  }
}
