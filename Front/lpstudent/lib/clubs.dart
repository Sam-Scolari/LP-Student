import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';

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

  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  // List<String> items = List<String>();
  // bool done = false;
  // int length;
  @override
  void initState() {
    // items.addAll(duplicateItems);
    controller.addListener(() {
      setState(() {
        query = controller.text;
      });
    });
  }

  // void filterSearchResults(String query) {
  //   List<String> dummySearchList = List<String>();
  //   dummySearchList.addAll(duplicateItems);
  //   if (query.isNotEmpty) {
  //     List<String> dummyListData = List<String>();
  //     dummySearchList.forEach((item) {
  //       if (item.contains(query)) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     setState(() {
  //       items.clear();
  //       items.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       items.clear();
  //       items.addAll(duplicateItems);
  //     });
  //   }
  // }

  // void filterSearchResults(String query) { // query = every character in the search bar
  //   print("at least its calling the method.");
  //   List<String> desired = new List<String>();
  //   List<String> notDesired = new List<String>();
  //   print(items.length);
  //   for (String club in items){
  //     if (club.contains(query)){
  //       desired.add(club);
  //     } else {
  //       notDesired.add(club);
  //     }
  //   }
  //   for(String desire in desired){
  //     print(desire);
  //     setState(() {
  //       items.add(desire);
  //     });
  //   }
  //   for(String notDesire in notDesired){
  //     print(notDesire);
  //     setState(() {
  //       items.add(notDesire);
  //     });
  //   }

  //   print(desired.length);

  // }

  // String filterSearch(String value){
  //   return value;
  // }
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
                    //filterSearchResults(value);
                    // filterSearch(value);
                    setState(() {
                      query = value;
                    });
                    // print(query + "_"+ value + "_");
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
                            ? ListTile(
                                title: Text(snapshot.data.documents[index]['name']),
                              )
                            : (snapshot.data.documents[index]['name']
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                ? ListTile(
                                    title: Text(snapshot.data.documents[index]['name']),
                                  )
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
