import 'package:finall/journeys/screens/booking_add_update.dart';
import 'package:flutter/material.dart';
import 'package:finall/journeys/journeys.dart';
import 'package:finall/journeys/models/schedule.dart';

class JourneyAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => JourneyList());
    }

    if (settings.name == AddUpdateJourney.routeName) {
      JourneyArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateJourney(
                args: args,
              ));
    }

    if (settings.name == JourneyDetail.routeName) {
      Journey journey = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => JourneyDetail(
                journey: journey,
              ));
    }

    if (settings.name == BookingList.routeName) {
      Schedule schedule = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => BookingList(
                schedule: schedule,
              ));
    }

    if (settings.name == AddUpdateSchedule.routeName) {
      ScheduleArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateSchedule(
                args: args,
              ));
    }

    return MaterialPageRoute(builder: (context) => JourneyList());
  }
}

class JourneyArgument {
  final Journey journey;

  final bool edit;
  JourneyArgument({this.journey, this.edit});
}

class ScheduleArgument {
  final Schedule schedule;

  final bool edit;
  ScheduleArgument({this.schedule, this.edit});
}
