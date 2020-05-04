import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'home.dart';
import 'settings.dart';
import 'auth.dart';
import 'picture.dart';

class Announcements extends StatefulWidget {
  final String value;
  final String picture;
  final String user;
  
  Announcements({Key key, this.value, this.picture, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnnouncementsState();
  }
}

class _AnnouncementsState extends State<Announcements> {
  List data;
  _getAnnouncementsList() {
    Firestore.instance
        .collection('generalData')
        .document(widget.value)
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
      setState(() {
        data = ds.data['announcements'];
      });
    });
    //print(data);
  }

  List savedData = new List();
  _getSavedDataList() {
    Firestore.instance
        .collection('users')
        .document(widget.user.substring(0, 6))
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
      setState(() {
        savedData = ds.data['savedAnnouncements'];
      });
    });
  }

  int range = 0;
  bool forward = true;
  int dayIWant = 0;
  int dayItIs = DateTime.now().weekday;
  _getDate() {
    if (widget.value == "monday") {
      dayIWant = 1;
    }
    if (widget.value == "tuesday") {
      dayIWant = 2;
    }
    if (widget.value == "wednesday") {
      dayIWant = 3;
    }
    if (widget.value == "thursday") {
      dayIWant = 4;
    }
    if (widget.value == "friday") {
      dayIWant = 5;
    }

    if (dayItIs >= dayIWant) {
      range = dayItIs - dayIWant;
    } else {
      range = dayIWant - dayItIs;
    }
  }


  Color iconColor = Colors.grey;

  bool _iconColorCheck(String announcement) {
    if (announcement != null && savedData.contains(announcement)) {
      return true;
      // setState(() {
      //   iconColor = Colors.yellow;
      // });
    } else {
      return false;
      // setState(() {
      //   iconColor = Colors.grey;
      // });
    }
  }

  _showAnnouncement(String announcement) {}

  _addAnnouncement(String announcement) {
    final Firestore _db = Firestore.instance;
    print("adding announcement");

    List temp = new List();
    temp.add(announcement);

    if (_iconColorCheck(announcement)) {
      DocumentReference ref =
          _db.collection('users').document(widget.user.substring(0, 6));
      ref.updateData({'savedAnnouncements': FieldValue.arrayRemove(temp)});
    } else {
      DocumentReference ref =
          _db.collection('users').document(widget.user.substring(0, 6));
      ref.updateData({'savedAnnouncements': FieldValue.arrayUnion(temp)});
    }
  }

  @override
  Widget build(BuildContext context) {
    _getAnnouncementsList();
    _getSavedDataList();
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
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
              actions: [
                
              ],
              backgroundColor: Colors.white,
            ),
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection('generalData')
                    .document(widget.value)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.greenAccent));
                  return Stack(children: [
                    SingleChildScrollView(
                        child: Column(children: [
                      Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 5,
                                offset: Offset(0, 0))
                          ]),
                          child: Image.asset(Picture.pickAll())),
                      Container(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, right: 5, left: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //add python short date Wednesday, Nov. 20th
                                // Text(DateFormat('EEEE, MMMM dd').format(DateTime.now()), //heehehehehhrhreheheehrh widget.value
                                Container(
                                  constraints: BoxConstraints(maxWidth: 250),
                                  child: Text(snapshot.data["date"],
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                ),
                                Card(
                                    color: Colors.greenAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Container(
                                        padding: EdgeInsets.all(3),
                                        child: Row(children: [
                                          Icon(
                                            Icons.schedule,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            snapshot.data['time'],
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ])))
                              ])),
                      Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                snapshot.data['birthdays'],
                                textAlign: TextAlign.justify,
                              ))),
                      Divider(),
                      data == null || data.length == 0
                          ? Container(
                              child: Text("No announcements for today."))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  ListTile(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(data[index]),
                                              actions: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    IconButton(
                                                        onPressed: () =>
                                                            setState(() {
                                                              _addAnnouncement(
                                                                  data[index]);
                                                            }),
                                                        icon: Icon(
                                                            _iconColorCheck(
                                                                    data[index])
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            color: _iconColorCheck(
                                                                    data[index])
                                                                ? Colors.yellow
                                                                : Colors.grey)),
                                                    Text(_iconColorCheck(
                                                            data[index])
                                                        ? "Saved"
                                                        : "Not Saved"),
                                                  ],
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Close",
                                                      style: TextStyle(
                                                          color: Colors.green)),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    title: Text(
                                      data[index],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    leading: IconButton(
                                        onPressed: () => setState(() {
                                              _addAnnouncement(data[index]);
                                            }),
                                        icon: Icon(
                                            _iconColorCheck(data[index])
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: _iconColorCheck(data[index])
                                                ? Colors.yellow
                                                : Colors.grey)),
                                  ),
                                  Divider()
                                ]);
                              },
                            )
                    ]))
                  ]);
                })));
  }
}
