import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'auth.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: StreamBuilder(
            stream: authService.user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: EdgeInsets.only(left: 10, top: 35, right: 10),
                    child: Center(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            //aaaaaaaaaaaaaaaaaaddddddd circle thing
                            // Image.network(
                            //   snapshot.data('photoURL'),
                            //   scale: 2.5,
                            // ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(children: [
                                  Text("First",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                  Text("Last",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25))
                                ]))
                          ],
                        ),
                        Divider(
                          thickness: 2.0,
                        ),
                        Text("Quick Access",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        FlatButton(onPressed: () {authService.signOut();}, child: Text("Logout")),
                        Text("")
                        
                      ],
                    )));
              } else {
                return Center(
                    child: FlatButton(
                  onPressed: () => authService.googleSignIn(),
                  child: Text("Login"),
                ));
              }
            }));
  }
}
