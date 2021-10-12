import 'package:finall/journeys/bloc/schedule_event.dart';
import 'package:finall/journeys/bloc/schedule_state.dart';
import 'package:finall/journeys/repository/schedule_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finall/journeys/bloc/bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({@required this.scheduleRepository})
      : assert(scheduleRepository != null),
        super(ScheduleLoading());

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (event is ScheduleLoad) {
      yield ScheduleLoading();
      try {
        final schedules = await scheduleRepository.getSchedules();
        yield SchedulesLoadSuccess(schedules);
      } catch (e) {
        print(e);
        yield ScheduleOperationFailure();
      }
    }

    if (event is ScheduleCreate) {
      try {
        await scheduleRepository.createSchedule(event.schedule);
        final schedules = await scheduleRepository.getSchedules();
        yield SchedulesLoadSuccess(schedules);
      } catch (e) {
        print(e);
        yield ScheduleOperationFailure();
      }
    }

    if (event is ScheduleUpdate) {
      try {
        await scheduleRepository.updateSchedule(event.schedule);
        final schedules = await scheduleRepository.getSchedules();
        yield SchedulesLoadSuccess(schedules);
      } catch (e) {
        print(e);
        yield ScheduleOperationFailure();
      }
    }

    if (event is ScheduleDelete) {
      try {
        await scheduleRepository.deleteSchedule(event.schedule.id);
        final schedules = await scheduleRepository.getSchedules();
        yield SchedulesLoadSuccess(schedules);
      } catch (e) {
        print(e);
        yield ScheduleOperationFailure();
      }
    }
  }
}
