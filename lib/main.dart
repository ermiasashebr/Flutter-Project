import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finall/bloc_observer.dart';
import 'package:finall/journeys/journeys.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();

  final JourneyRepository journeyRepository = JourneyRepository(
    dataProvider: JourneyDataProvider(
      httpClient: http.Client(),
    ),
  );
  final ScheduleRepository scheduleRepository = ScheduleRepository(
    dataProvider: ScheduleDataProvider(
      httpClient: http.Client(),
    ),
  );
  runApp(
    JourneyApp(journeyRepository: journeyRepository),
  );
}

class JourneyApp extends StatelessWidget {
  final JourneyRepository journeyRepository;

  JourneyApp({@required this.journeyRepository})
      : assert(journeyRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.journeyRepository,
      child: BlocProvider(
        create: (context) =>
            JourneyBloc(journeyRepository: this.journeyRepository)
              ..add(JourneyLoad()),
        child: MaterialApp(
          title: 'Journey App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: JourneyAppRoute.generateRoute,
        ),
      ),
    );
  }
}
