import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'home.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() {
  initializeDateFormatting().then((_) {
    runApp(Login());
  });
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  String error = "base";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                    body: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Image.asset(
                              "assets/images/LP_Student/LP_Student.png",
                              scale: 2.25,
                            )),
                        SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            AuthProvider.loginWithGoogle().then((email) {
                              print(email);
                              setState(() {
                                error = email;
                              });
                              if (email.contains("@lphs.net") || email.contains("@students.lphs.net")) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                              user: email,
                                            )));
                              } else {
                                try {
                                  AuthProvider.logOut();
                                } catch (e) {
                                  print(e.message);
                                }
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Sign in error."),
                                        // content: Text(
                                        //     "You may only sign in using an authorized LPHS email. Please retry with a different email."),
                                        content: Text(error),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Retry",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          )
                                        ],
                                      );
                                    });
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
