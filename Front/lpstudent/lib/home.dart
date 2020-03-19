import 'dart:convert';
import 'package:flutter_calendar_carousel/classes/event.dart';
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
import 'main.dart';
import 'auth.dart';
// void main() {
//   initializeDateFormatting().then((_) => runApp(Home()));
// }

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool _visible = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  var day = '';
  var now = new DateTime.now().weekday;
  var count = 0;

  bool activeMon = false;
  bool activeTue = false;
  bool activeWed = false;
  bool activeThu = false;
  bool activeFri = false;

  bool disabledMon = false;
  bool disabledTue = false;
  bool disabledWed = false;
  bool disabledThu = false;
  bool disabledFri = false;

  void createDay() {
    //makes it run once
    if (count == 0) {
      setState(() {
        count++;
      });

      if (now == 1) {
        //monday is 1
        setState(() {
          day = 'monday';
          activeMon = true;

          disabledMon = false;
          disabledTue = true;
          disabledWed = true;
          disabledThu = true;
          disabledFri = true;
        });
      }
      if (now == 2) {
        setState(() {
          day = 'tuesday';
          activeTue = true;

          disabledMon = false;
          disabledTue = false;
          disabledWed = true;
          disabledThu = true;
          disabledFri = true;
        });
      }
      if (now == 3) {
        setState(() {
          day = 'wednesday';
          activeWed = true;

          disabledMon = false;
          disabledTue = false;
          disabledWed = false;
          disabledThu = true;
          disabledFri = true;
        });
      }
      if (now == 4) {
        setState(() {
          day = 'thursday';
          activeThu = true;

          disabledMon = false;
          disabledTue = false;
          disabledWed = false;
          disabledThu = false;
          disabledFri = true;
        });
      }
      if (now == 5) {
        setState(() {
          day = 'friday';
          activeFri = true;

          disabledMon = false;
          disabledTue = false;
          disabledWed = false;
          disabledThu = false;
          disabledFri = false;
        });
      }
      if (now == 6) {
        setState(() {
          day = 'monday';
          activeMon = true;

          disabledMon = false;
          disabledTue = true;
          disabledWed = true;
          disabledThu = true;
          disabledFri = true;
        });
      }
      if (now == 7) {
        setState(() {
          day = 'monday';
          activeMon = true;

          disabledMon = false;
          disabledTue = true;
          disabledWed = true;
          disabledThu = true;
          disabledFri = true;
        });
      }
    }
  }

  void buttcolor(button) {
    if (button == "Mon") {
      setState(() {
        day = 'monday';
        activeMon = true;
        activeTue = false;
        activeWed = false;
        activeThu = false;
        activeFri = false;
      });
    }

    if (button == "Tue") {
      setState(() {
        day = 'tuesday';
        activeMon = false;
        activeTue = true;
        activeWed = false;
        activeThu = false;
        activeFri = false;
      });
    }

    if (button == "Wed") {
      setState(() {
        day = 'wednesday';
        activeMon = false;
        activeTue = false;
        activeWed = true;
        activeThu = false;
        activeFri = false;
      });
    }

    if (button == "Thu") {
      setState(() {
        day = 'thursday';
        activeMon = false;
        activeTue = false;
        activeWed = false;
        activeThu = true;
        activeFri = false;
      });
    }

    if (button == "Fri") {
      setState(() {
        day = 'friday';
        activeMon = false;
        activeTue = false;
        activeWed = false;
        activeThu = false;
        activeFri = true;
      });
    }
  }

  CalendarController _calendarController;

  String email = "email@email.com";
  String imageUrl =
      "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";
  String firstName = "FirstName";
  String lastName = "LastName";

  var count2 = 0;

  Future getSaveContent() async {
    if (count2 == 0) {
      Storage.readContent().then((contents) {
        setState(() {
          firstName = contents.split("\n")[0];
          lastName = contents.split("\n")[1];
          email = contents.split("\n")[2];
          imageUrl = contents.split("\n")[3];
          count2++;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    createDay();
    getSaveContent();
    return MaterialApp(
        //theme: ThemeData(fontFamily: 'Roboto'),
        home: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset('assets/images/logo2.png',
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
                          _toggle();
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Settings()),
                          );
                        })
                  ],
                  backgroundColor: Colors.white,
                ),
                bottomSheet: Divider(
                  thickness: 1,
                ),
                drawer: Drawer(
                    child: Padding(
                        padding: EdgeInsets.only(top: 45, left: 15),
                        child: Column(children: [
                          Row(
                            children: [
                              Card(
                                  elevation: 15,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child:
                                      ClipOval(child: Image.network(imageUrl))),
                              Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            firstName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 29,
                                            ),
                                            textAlign: TextAlign.left,
                                          )),
                                      Text(
                                        lastName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 29),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ))
                            ],
                          ),

                        ]))),
                body: Container(
                    child: Stack(children: [
                  Column(children: [
                    Container(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Announcements(value: day)),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 7, left: 7, right: 7),
                        child: SizedBox(
                            height: 225,
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Stack(fit: StackFit.expand, children: [
                                    Image.asset(
                                      'assets/images/generalDay/gen.jpeg',
                                      fit: BoxFit.fill,
                                    ),
                                    Container(
                                        color: Color.fromARGB(30, 0, 0, 0),
                                        padding: EdgeInsets.all(12),
                                        alignment: Alignment.bottomLeft,
                                        child: StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('generalData')
                                                .document(day)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData)
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              return Text(
                                                snapshot.data['date'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 35,
                                                    color: Colors.white),
                                              );
                                            }))
                                  ])),
                            )),
                      ),
                    )),
                    Padding(
                        padding: EdgeInsets.only(top: 7, left: 7, right: 7),
                        child: Container(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Container(
                                    child: Row(children: [
                                  Flexible(
                                      child: Container(
                                          child: FlatButton(
                                              onPressed: () {
                                                if (disabledMon) {
                                                  null;
                                                } else {
                                                  print("pressed");
                                                  buttcolor("Mon");
                                                }
                                              },
                                              child: Text('M',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: activeMon
                                                          ? Colors.green
                                                          : disabledMon
                                                              ? Color.fromRGBO(
                                                                  0, 0, 0, 225)
                                                              : Colors.black,
                                                      fontSize: 18))))),
                                  Flexible(
                                      child: Container(
                                          child: FlatButton(
                                              onPressed: () {
                                                if (disabledTue) {
                                                  null;
                                                } else {
                                                  print("pressed");
                                                  buttcolor("Tue");
                                                }
                                              },
                                              padding: EdgeInsets.all(15),
                                              child: Text('T',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: activeTue
                                                          ? Colors.green
                                                          : disabledTue
                                                              ? Color.fromRGBO(
                                                                  0, 0, 0, 225)
                                                              : Colors.black,
                                                      fontSize: 18))))),
                                  Flexible(
                                      child: Container(
                                          child: FlatButton(
                                              onPressed: () {
                                                if (disabledWed) {
                                                  null;
                                                } else {
                                                  print("pressed");
                                                  buttcolor("Wed");
                                                }
                                              },
                                              child: Text('W',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: activeWed
                                                          ? Colors.green
                                                          : disabledWed
                                                              ? Color.fromRGBO(
                                                                  0, 0, 0, 225)
                                                              : Colors.black,
                                                      fontSize: 18))))),
                                  Flexible(
                                      child: Container(
                                          child: FlatButton(
                                              onPressed: () {
                                                if (disabledThu) {
                                                  null;
                                                } else {
                                                  print("pressed");
                                                  buttcolor("Thu");
                                                }
                                              },
                                              child: Text('T',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: activeThu
                                                          ? Colors.green
                                                          : disabledThu
                                                              ? Color.fromRGBO(
                                                                  0, 0, 0, 225)
                                                              : Colors.black,
                                                      fontSize: 18))))),
                                  Flexible(
                                      child: Container(
                                          child: FlatButton(
                                              onPressed: () {
                                                if (disabledFri) {
                                                  null;
                                                } else {
                                                  print("pressed");
                                                  buttcolor("Fri");
                                                }
                                              },
                                              child: Text('F',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: activeFri
                                                          ? Colors.green
                                                          : disabledFri
                                                              ? Color.fromRGBO(
                                                                  0, 0, 0, 225)
                                                              : Colors.black,
                                                      fontSize: 18))))),
                                ]))))),
                    Padding(
                        padding: EdgeInsets.only(top: 7, left: 7, right: 7),
                        child: Column(children: [
                          Text(
                            "Cafeteria Menu",
                            style: TextStyle(fontSize: 25),
                          ),
                          ExpandableNotifier(
                              child: Column(
                            children: [
                              Expandable(
                                collapsed: ExpandableButton(
                                    child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Card(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                              Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    "Breakfast",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )),
                                              Icon(Icons.arrow_drop_down)
                                            ])))),
                                expanded: Column(
                                  children: [
                                    ExpandableButton(
                                        child: FractionallySizedBox(
                                            widthFactor: 1,
                                            child: Card(
                                                child: Column(children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Text(
                                                          "Breakfast",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )),
                                                    Icon(Icons.arrow_drop_up)
                                                  ]),
                                              StreamBuilder(
                                                stream: Firestore.instance
                                                    .collection("generalData")
                                                    .document(day)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData)
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.greenAccent,
                                                      ),
                                                    );
                                                  return Stack(
                                                    children: [
                                                      Container(
                                                        child: Text(snapshot
                                                            .data["breakfast"]),
                                                      )
                                                    ],
                                                  );
                                                },
                                              )
                                            ])))),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          ExpandableNotifier(
                              child: Column(
                            children: [
                              Expandable(
                                collapsed: ExpandableButton(
                                    child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Card(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                              Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    "Lunch",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )),
                                              Icon(Icons.arrow_drop_down)
                                            ])))),
                                expanded: Column(
                                  children: [
                                    ExpandableButton(
                                        child: FractionallySizedBox(
                                            widthFactor: 1,
                                            child: Card(
                                                child: Column(children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Text(
                                                          "Lunch",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )),
                                                    Icon(Icons.arrow_drop_up)
                                                  ]),
                                              StreamBuilder(
                                                stream: Firestore.instance
                                                    .collection("generalData")
                                                    .document(day)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData)
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.greenAccent,
                                                      ),
                                                    );
                                                  return Stack(
                                                    children: [
                                                      Container(
                                                        child: Text(snapshot
                                                            .data["lunch"]),
                                                      )
                                                    ],
                                                  );
                                                },
                                              )
                                            ]))))
                                  ],
                                ),
                              ),
                            ],
                          )),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        height: 200,
                                        width: 165,
                                        child: Card(
                                          color: Colors.greenAccent,
                                          child: Center(
                                              child: Icon(OMIcons.dateRange,
                                                  color: Colors.white,
                                                  size: 50)),
                                        )),
                                    SizedBox(
                                        height: 200,
                                        width: 165,
                                        child: Card(
                                          color: Colors.greenAccent,
                                          child: Center(
                                              child: Icon(
                                            OMIcons.classIcon,
                                            color: Colors.white,
                                            size: 50,
                                          )),
                                        ))
                                  ]))

                          //TableCalendar(calendarController: _calendarController, locale: 'en_US',)
                        ])),
                  ]),
                  Visibility(
                      visible: _visible,
                      child: Container(
                          color: Color.fromARGB(200, 0, 0, 0),
                          child: Center(
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Container(
                                    //Size of the card
                                    height: 525,
                                    width: 325,
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.only(top: 25, bottom: 25),
                                          child: Card(
                                              elevation: 15,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: ClipOval(
                                                  child: Image.network(
                                                      imageUrl)))),
                                      Padding(padding: EdgeInsets.only(bottom: 25),child:Text(
                                        firstName +" "+ lastName,
                                        style: TextStyle(fontSize: 35),
                                      )),
                                      Card(
                                        
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: QrImage(

                                              data: email.substring(0, 6),
                                              version: QrVersions.auto,
                                              size: 220),
                                        ),
                                      ),
                                      Text(
                                        email.substring(0, 6),
                                        style: TextStyle(fontSize: 17),)
                                    ]),
                                  )))))
                ])))));
  }
}
