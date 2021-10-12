import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:finall/journeys/models/schedule.dart';
import 'package:http/http.dart' as http;

class ScheduleDataProvider {
  final _baseUrl = 'http://192.168.8.148:8181';
  final http.Client httpClient;

  ScheduleDataProvider({@required this.httpClient})
      : assert(httpClient != null);

  Future<Schedule> createSchedule(Schedule schedule) async {
    final response = await httpClient.post(
      Uri.http('192.168.8.148:8181', '/schedules'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'travelID': schedule.travelID,
        'startingTime': schedule.startingTime,
        'classs': schedule.classs,
        'trainID': schedule.trainID,
        'day': schedule.day,
        'booked': schedule.booked
      }),
    );

    if (response.statusCode == 201) {
      return Schedule.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Schedule.');
    }
  }

  Future<List<Schedule>> getSchedules() async {
    final response = await httpClient.get('$_baseUrl/schedules');

    if (response.statusCode == 200) {
      final schedules = jsonDecode(response.body) as List;
      return schedules.map((schedule) => Schedule.fromJson(schedule)).toList();
    } else {
      throw Exception('Failed to load Schedule');
    }
  }

  Future<void> deleteSchedule(int id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/schedules/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete Schedule.');
    }
  }

  Future<void> updateSchedule(Schedule schedule) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/schedules/${schedule.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': schedule.id,
        'travelID': schedule.travelID,
        'startingTime': schedule.startingTime,
        'classs': schedule.classs,
        'trainID': schedule.trainID,
        'day': schedule.day,
        'booked': schedule.booked
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update schedule.');
    }
  }
}
