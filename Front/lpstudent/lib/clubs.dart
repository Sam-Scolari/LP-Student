import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class Clubs extends StatefulWidget {
  final String user;
  Clubs({Key key, this.user})
      : super(key: key); // user must be passed between pages to retain state
  @override
  _ClubsState createState() => new _ClubsState();
}

class _ClubsState extends State<Clubs> {
  TextEditingController controller = TextEditingController();
  String query;

  Future<void> toggleClub(String club) async {
    return YYDialog().build(context)
      ..width = 300
      ..height = 500
      ..borderRadius = 15
      ..widget(Padding(
        padding: EdgeInsets.all(0.0),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('clubs')
                .document(club)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center();
              print(snapshot.data['sponsors'].keys.toList()[0]);
              return Center(
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        snapshot.data['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                  snapshot.data['sponsors'].keys.toList().length == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Card(
                              elevation: 5,
                              color: Colors.red,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " " +
                                            snapshot.data['sponsors'].keys
                                                .toList()[0],
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        )
                      : snapshot.data['sponsors'].keys.toList().length == 2
                          ? Row(
                              children: <Widget>[
                                Card(
                                    elevation: 5,
                                    color: Colors.red,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Padding(padding: EdgeInsets.all(8), child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " " +
                                                  snapshot.data['sponsors'].keys
                                                      .toList()[0],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )))),
                                Card(
                                    elevation: 5,
                                    color: Colors.green,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " " +
                                                  snapshot.data['sponsors'].keys
                                                      .toList()[1],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Card(
                                    elevation: 5,
                                    color: Colors.red,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " " +
                                                  snapshot.data['sponsors'].keys
                                                      .toList()[0],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))),
                                Card(
                                    elevation: 5,
                                    color: Colors.green,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " " +
                                                  snapshot.data['sponsors'].keys
                                                      .toList()[1],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))),
                                Card(
                                    elevation: 5,
                                    color: Colors.red,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " " +
                                                  snapshot.data['sponsors'].keys
                                                      .toList()[2],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))),
                              ],
                            )
                ]),
              );
            }),
      ))
      ..show();
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        query = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
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
              Icons.more_vert,
              color: Colors.grey,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Search Clubs and Activities",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      focusColor: Colors.green,
                      hoverColor: Colors.green,
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance.collection('clubs').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.greenAccent));

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return (query == null || query == "")
                            ? Column(children: [
                                ListTile(
                                  onTap: () {
                                    toggleClub(snapshot
                                        .data.documents[index].documentID);
                                  },
                                  title: Text(
                                      snapshot.data.documents[index]['name']),
                                ),
                                Divider()
                              ])
                            : (snapshot.data.documents[index]['name']
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                ? Column(children: [
                                    ListTile(
                                      onTap: () {
                                        toggleClub(snapshot
                                            .data.documents[index].documentID);
                                      },
                                      title: Text(snapshot.data.documents[index]
                                          ['name']),
                                    ),
                                    Divider()
                                  ])
                                : Container();
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
