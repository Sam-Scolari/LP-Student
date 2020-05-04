import 'package:lpstudent/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class Schedule extends StatefulWidget {
  final String user;
  Schedule({Key key, this.user}) : super(key: key); // user must be passed between pages to retain state
  @override
  State<StatefulWidget> createState() {
    return _ScheduleState();
  }
}

class _ScheduleState extends State<Schedule> {
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
            body: Center(child:Container(padding: EdgeInsets.all(8),child: Column(children: [
              Text("Schedule", style: TextStyle(fontSize: 37)),
              Card(child: 
              Table(
                border: TableBorder.all(color: Colors.grey[200]),
                children: [
                  TableRow(children: [
                    Column(children:[
                      Padding(padding: EdgeInsets.all(12),child: Text('Time', style: TextStyle(fontSize: 20)))
                    ]),
                    Column(children:[
                      Padding(padding: EdgeInsets.all(12),child: Text('Name', style: TextStyle(fontSize: 20)))
                    ]),
                    
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("7:30am", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("1st - Bell", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("7:45am", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("1st - Hour", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("8:40am", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("2nd - Hour", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("9:35am", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("3rd - Hour", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("10:30am", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("4th - Hour", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("11:25am", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("5th - A", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("11:55am", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("5th - B", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("12:25pm", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("5th - C", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("12:55pm", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("6th - Hour", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                  TableRow( children: [
                    Padding(padding: EdgeInsets.all(8), child: Text("1:50pm", textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
                    Padding(padding: EdgeInsets.all(8), child: Text("7th - Hour", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                  ]),
                ],
              ),)
            ])))));
  }
}
