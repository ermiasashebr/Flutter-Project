import 'package:finall/journeys/data_provider/schedule_provider.dart';
import 'package:meta/meta.dart';
import 'package:finall/journeys/models/schedule.dart';

class ScheduleRepository {
  final ScheduleDataProvider dataProvider;

  ScheduleRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Schedule> createSchedule(Schedule scheudle) async {
    print(scheudle.travelID);
    return await dataProvider.createSchedule(scheudle);
  }

  Future<List<Schedule>> getSchedules() async {
    return await dataProvider.getSchedules();
  }

  Future<void> updateSchedule(Schedule schedule) async {
    await dataProvider.updateSchedule(schedule);
  }

  Future<void> deleteSchedule(int id) async {
    await dataProvider.deleteSchedule(id);
  }
}
