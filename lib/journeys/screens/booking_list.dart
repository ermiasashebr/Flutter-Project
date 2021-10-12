import 'package:finall/journeys/journeys.dart';
import 'package:finall/journeys/screens/booking_add_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingList extends StatelessWidget {
  static const routeName = 'bookingList';
  final Schedule schedule;
  BookingList({this.schedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Booked Schedules'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white10, Colors.blue])),
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (_, state) {
            if (state is ScheduleOperationFailure) {
              return Text('Could not do Schedule operation');
            }

            if (state is SchedulesLoadSuccess) {
              final schedules = state.schedules;

              return ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (_, idx) => ListTile(
                  title: Text(
                    'Schedle TravelID: ${schedules[idx].travelID}',
                    style: TextStyle(color: Colors.amber),
                  ),
                  subtitle: Text(
                    'Schedule Class: ${schedules[idx].classs}',
                    style: TextStyle(color: Colors.amber),
                  ),
                  onTap: () => Navigator.of(context).pushNamed(
                      JourneyDetail.routeName,
                      arguments: schedules[idx]),
                ),
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateSchedule.routeName,
          arguments: ScheduleArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
