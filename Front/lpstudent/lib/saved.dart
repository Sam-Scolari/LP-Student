import 'package:lpstudent/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
class Saved extends StatefulWidget {
  final String user;
  Saved({Key key, this.user}) : super(key: key); // user must be passed between pages to retain state
  @override
  State<StatefulWidget> createState() {
    return _SavedState();
  }
}

class _SavedState extends State<Saved> {
  List data;
  _getAnnouncementsList() {
    //data
    Firestore.instance
        .collection('users')
        .document(email.substring(0, 6))
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
      setState(() {
        data = ds.data['savedAnnouncements'];
      });
    });
  }

  _removeSaved(String announcement) {
    final Firestore _db = Firestore.instance;
    print("adding announcement");

    List temp = new List();
    temp.add(announcement);

    
      DocumentReference ref =
        _db.collection('users').document(email.substring(0, 6));
      ref.updateData({'savedAnnouncements': FieldValue.arrayRemove(temp)});
    }
  

    bool _isVis = false;
    bool isPressed = false;
    Color iconColor = Colors.grey;

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
    _getAnnouncementsList();
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
                    Icons.highlight_off,
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
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(email.substring(0, 6))
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.greenAccent));
                  return Stack(children: [
                    SingleChildScrollView(
                        child: Column(children: [
                     
                      Container(child: data == null || data.length == 0
        ? Center(child: Text("No saved announcements."))
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(children: [
                ListTile(
                  onTap: () => setState(() {
                    _isVis = !_isVis;
                    iconColor = Colors.red;
                  }),
                  title: Text(
                    data[index],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  leading: IconButton(
                      onPressed: () {
                            _removeSaved(data[index]);
                          },
                      icon: (isPressed)
                          ? Icon(Icons.delete_outline,color: Colors.red)
                          : Icon(Icons.delete_outline, color: Colors.grey)),
                ),
                Divider()
              ]);
            },
          ))
                    ]))
                  ]);
                })));
  }
}
