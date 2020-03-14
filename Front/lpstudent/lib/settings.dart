import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Settings extends StatefulWidget {
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
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                'assets/images/logo2.png',
                width: 40,
                height: 40,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
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
                    //nothing yet
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
              backgroundColor: Colors.white,
            ),
            body: Center(
                child: Stack(children: [
              Column(children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Column(children: [
                        Text("Notifications", style: TextStyle(fontSize: 22)),
                        Row(children: [
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
                        Row(children: [
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
                        Row(children: [
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
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Column(children: [
                        Text("Personal Information",
                            style: TextStyle(fontSize: 22)),
                        Row(children: [
                          Text(
                            "First Name",
                            style: TextStyle(fontSize: 17),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            "Last Name",
                            style: TextStyle(fontSize: 17),
                          ),
                          // TextField(
                          //   obscureText: true,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     labelText: 'Password',
                          //   ),
                          // )
                        ]),
                        Row(children: [
                          Text(
                            "Profile Picture",
                            style: TextStyle(fontSize: 17),
                          ),
                        ]),
                      ])),
                ),
              ]),
              Visibility(
                  visible: _visible,
                  child: FractionallySizedBox(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Container(
                          color: Color.fromARGB(200, 0, 0, 0),
                          child: Center(
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: FractionallySizedBox(
                                    widthFactor: .8,
                                    heightFactor: .66,
                                    child: Column(children: [
                                      Image.asset(
                                        "assets/images/logo2.png",
                                        scale: 2.5,
                                      ),
                                      Text("Samuel"),
                                      Text("Scolari"),
                                      Image.asset("assets/images/barcode.png",
                                          scale: 2.25),
                                      Text("200276"),
                                      Center(
                                          child: Row(
                                        children: [
                                          Text("Senior"),
                                          Text("2019-2020")
                                        ],
                                      ))
                                    ]),
                                  ))))))
            ]))));
  }
}
