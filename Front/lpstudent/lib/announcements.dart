import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

import 'home.dart';
import 'settings.dart';

class Announcements extends StatefulWidget {
  final String value;

  Announcements({Key key, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnnouncementsState();
  }
}

class _AnnouncementsState extends State<Announcements> {
  bool _visible = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  List data;
  _getAnnouncementsList() {
    //data
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
  }

  @override
  Widget build(BuildContext context) {
    _getAnnouncementsList();
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
                    Icons.credit_card,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _toggle();
                  },
                ),
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
                  },
                )
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
                          child: Image.asset(
                              "./assets/images/generalDay/gen.jpeg")),
                      Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //add python short date Wednesday, Nov. 20th
                                Text(snapshot.data['date'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
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
                      Container(child: _myListView(context, data)),
                    ]))
                  ]);
                })));
  }

  Widget _myListView(BuildContext context, List data) {
    List announceData = data;

    bool _isVis = false;
    bool isPressed = false;

    _updateStar() {
      isPressed = !isPressed;
    }

    return data == null
        ? Container(child: Text("No announcements for today."))
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: announceData.length,
            itemBuilder: (context, index) {
              return Column(children: [
                ListTile(
                  onTap: () => setState(() {
                    _isVis = !_isVis;
                  }),
                  title: Text(
                    announceData[index],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  leading: IconButton(
                      onPressed: () => setState(() {
                            _updateStar();
                          }),
                      icon: (isPressed)
                          ? Icon(Icons.star, color: Colors.yellow)
                          : Icon(Icons.star_border, color: Colors.grey)),
                ),
                Divider()
              ]);
            },
          );
  }
}
