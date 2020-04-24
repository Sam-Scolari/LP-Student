import 'package:lpstudent/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
class Handbook extends StatefulWidget {
  final String user;
  Handbook({Key key, this.user}) : super(key: key); // user must be passed between pages to retain state
  @override
  State<StatefulWidget> createState() {
    return _HandbookState();
  }
}

class _HandbookState extends State<Handbook> {

  String path = "assets/handbook.pdf";

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
    return Container();
  }
}
