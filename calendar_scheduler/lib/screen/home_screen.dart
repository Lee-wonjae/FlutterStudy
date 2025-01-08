import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  DateTime selectedDate=DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [MainCalendar(onDaySelected: onDaySelected, selectedDate: selectedDate)],
      )),
    );
  }

  void onDaySelected(DateTime selectedDate,DateTime focusedDate){
    setState((){
      this.selectedDate = selectedDate;
    });
  }
}

