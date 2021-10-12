import 'package:equatable/equatable.dart';
import 'package:finall/journeys/models/schedule.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class ScheduleLoad extends ScheduleEvent {
  const ScheduleLoad();

  @override
  List<Object> get props => [];
}

class ScheduleCreate extends ScheduleEvent {
  final Schedule schedule;

  const ScheduleCreate(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  String toString() => 'Schedule Created {schedule: $schedule}';
}

class ScheduleUpdate extends ScheduleEvent {
  final Schedule schedule;

  const ScheduleUpdate(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  String toString() => 'Schedule Updated {schedule: $schedule}';
}

class ScheduleDelete extends ScheduleEvent {
  final Schedule schedule;

  const ScheduleDelete(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  toString() => 'Schedule Deleted {schedule: $schedule}';
}
