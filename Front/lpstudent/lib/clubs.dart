import 'package:lpstudent/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
class Clubs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClubsState();
  }
}

class _ClubsState extends State<Clubs> {
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
      MaterialPageRoute(builder: (context) => Home()),
    );
    return true;
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
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete All?"),
                            content: Text(
                                "This will delete all of your saved announcements."),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.green),
                                  )),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                              )
                            ],
                          );
                        });
                  },
                ),
              ],
              backgroundColor: Colors.white,
            ),
            body: Container(child: Text("Hi"))));
  }
}
