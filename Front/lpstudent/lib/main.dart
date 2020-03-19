import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'home.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'auth.dart';
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
  //final _storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                    body: Container(
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(bottom: 15),child: Image.asset(
                          "assets/images/logo2.png",
                          scale: 2.25,
                        )),
                        SignInButton(Buttons.Google, onPressed: (){
                          signInWithGoogle().whenComplete(() {
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                        });
                        } ,)
                      ],
                    ),
                  ),
                ))));
  }
}
