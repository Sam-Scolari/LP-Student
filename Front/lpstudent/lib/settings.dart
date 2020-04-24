import 'package:lpstudent/auth.dart';
import 'main.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class Settings extends StatefulWidget {
  final String user;
  Settings({Key key, this.user}) : super(key: key); // user must be passed between pages to retain state

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

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(user: widget.user,)),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user);
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
                    MaterialPageRoute(builder: (context) => Home(user: widget.user,)),
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
                  onPressed: () {},
                )
              ],
              backgroundColor: Colors.white,
            ),
            body: Padding(
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
                                      value: true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value = false;
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
                                      value: true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value = false;
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
                                      value: true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value = false;
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
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Full Name",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Expanded(child: TextField(
                                      readOnly: true,
                                      
                                      decoration: InputDecoration(border: InputBorder.none, labelText: 'Samuel Scolari', fillColor: Colors.grey[200]),


                                    ))
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ID Number",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Switch(
                                      value: true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value = false;
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
                                      "Email",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Switch(
                                      value: true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value = false;
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
                                      "Class",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Switch(
                                      value: true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value = false;
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
                                      "Birthday",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Switch(
                                      value: true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value = false;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ]),
                            ])),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: MaterialButton(
                            color: Colors.red,
                            onPressed: () {
                              signOutGoogle();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Login()));
                            },
                            child: Text(
                              "Sign Out",
                              style: TextStyle(color: Colors.white),
                            )))
                  ]),
                ])))));
  }
}
