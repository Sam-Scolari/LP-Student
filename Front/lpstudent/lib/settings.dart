import 'package:lpstudent/auth.dart';
import 'main.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  final String user;
  Settings({Key key, this.user})
      : super(key: key); // user must be passed between pages to retain state

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  bool _visible = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  _updataSettings(String setting, bool state) {
    final Firestore _db = Firestore.instance;
    DocumentReference ref =
      _db.collection('users').document(widget.user.substring(0, 6));
    ref.updateData({setting: state});
   }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                'assets/images/LP_Student/LP_Student.png',
                width: 40,
                height: 40,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              user: widget.user,
                            )),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.restore,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Restore?"),
                            content: Text(
                                "This will reset all settings to their defaults."),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("ACCEPT",
                                    style: TextStyle(color: Colors.red)),
                              )
                            ],
                          );
                        });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Bug / Feature Request?"),
                            content:
                                Text("Email me at: sstryker.mobile@gmail.com"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close",
                                    style: TextStyle(color: Colors.red)),
                              )
                            ],
                          );
                        });
                  },
                )
              ],
              backgroundColor: Colors.white,
            ),
            body: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(widget.user.substring(0, 6))
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator(backgroundColor: Colors.green,);
              return Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Stack(children: [
                  Column(children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Column(children: [
                              Text("Notifications",
                                  style: TextStyle(fontSize: 22)),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Lunch Menu",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Switch(
                                      value: snapshot.data['lunchSettings'],
                                      onChanged: (bool value) {
                                        _updataSettings('lunchSettings', !value);
                                        setState(() {
                                          value = !value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Breakfast Menu",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Switch(
                                      value: snapshot.data['breakfastSettings'],
                                      onChanged: (bool value) {
                                        _updataSettings('breakfastSettings', !value);
                                        setState(() {
                                          value = !value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Announcements",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Switch(
                                      value: snapshot.data['announcementSettings'],
                                      onChanged: (bool value) {
                                        _updataSettings('announcementSettings', !value);
                                        setState(() {
                                          value = !value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ]),
                            ])),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Column(children: [
                              Text("Your Information",
                                  style: TextStyle(fontSize: 22)),
                              Padding(padding: EdgeInsets.only(top: 10),child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Full Name",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Container(color: Colors.grey[200],child: Padding(padding: EdgeInsets.only(top: 5, bottom: 5, left:8, right:8),child: Text(
                                        snapshot.data['firstName']+" "+snapshot.data['lastName'],
                                        style: TextStyle(fontSize: 17),
                                      )),
                                    ))
                                  ])),
                                  Padding(padding: EdgeInsets.only(top: 10),child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ID Number",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Container(color: Colors.grey[200],child: Padding(padding: EdgeInsets.only(top: 5, bottom: 5, left:8, right:8),child: Text(
                                        snapshot.data.documentID,
                                        style: TextStyle(fontSize: 17),
                                      )),
                                    ))
                                  ])),
                                  Padding(padding: EdgeInsets.only(top: 10),child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Container(color: Colors.grey[200],child: Padding(padding: EdgeInsets.only(top: 5, bottom: 5, left:8, right:8),child: Text(
                                        snapshot.data['email'],
                                        style: TextStyle(fontSize: 17),
                                      )),
                                    ))
                                  ])),
                                  // Padding(padding: EdgeInsets.only(top: 10),child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  // children: [
                                  //   Text(
                                  //     "Class",
                                  //     style: TextStyle(fontSize: 17),
                                  //   ),
                                  //   ClipRRect(
                                  //     borderRadius: BorderRadius.circular(15.0),
                                  //     child: Container(color: Colors.grey[200],child: Padding(padding: EdgeInsets.only(top: 5, bottom: 5, left:8, right:8),child: Text(
                                  //       "Senior 2020",
                                  //       style: TextStyle(fontSize: 17),
                                  //     )),
                                  //   ))
                                  // ])),
                            
                            ])),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: MaterialButton(
                            color: Colors.red,
                            onPressed: () {
                              AuthProvider.logOut();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Login()));
                            },
                            child: Text(
                              "Sign Out",
                              style: TextStyle(color: Colors.white),
                            )))
                  ]),
                ])));})));
  }
}
