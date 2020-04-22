import 'package:lpstudent/auth.dart';
import 'main.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
class Calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarState();
  }
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    BackButtonInterceptor.remove(myInterceptor);

    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    return true;
  }

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
                  icon: Icon(Icons.more_vert, color: Colors.grey,),
                  onPressed: () {},
                )
              ],
              backgroundColor: Colors.white,
            ),
            body: Column(children: [TableCalendar(calendarController: _calendarController, locale: 'en_US',), Divider(thickness: 2,)])));
  }
}
