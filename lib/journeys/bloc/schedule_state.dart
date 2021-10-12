import 'package:equatable/equatable.dart';
import 'package:finall/journeys/models/schedule.dart';

class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleLoading extends ScheduleState {}

class SchedulesLoadSuccess extends ScheduleState {
  final List<Schedule> schedules;

  SchedulesLoadSuccess([this.schedules = const []]);

  @override
  List<Object> get props => [schedules];
}

class ScheduleOperationFailure extends ScheduleState {}
