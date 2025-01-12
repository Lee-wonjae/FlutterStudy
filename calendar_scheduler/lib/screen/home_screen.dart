import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) =>
                ScheduleBottomSheet(
                  selectedDate: selectedDate,
                ),
            isScrollControlled: true,
          );
        },
      ),
      body: SafeArea(
          child: Column(
            children: [
              MainCalendar(
                onDaySelected: onDaySelected,
                selectedDate: selectedDate,
              ),
              SizedBox(
                height: 8,
              ),
              TodayBanner(
                selectedDate: selectedDate,
                count: 0,
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: StreamBuilder<List<Schedule>>(
                      stream: GetIt.I<LocalDatabase>().watchSchedules(
                          selectedDate),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final schedule = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8,
                                left: 8,
                                right: 8,),
                              child: ScheduleCard(
                                startTime: schedule.startTime,
                                endTime: schedule.endTime,
                                content: schedule.content,),
                            );
                          },
                        );
                      }))
            ],
          )),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
