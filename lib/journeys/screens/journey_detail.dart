import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finall/journeys/journeys.dart';

class JourneyDetail extends StatelessWidget {
  static const routeName = 'journeyDetail';
  final Journey journey;
  final Schedule schedule;
  JourneyDetail({@required this.journey, this.schedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.journey.distance}'),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateJourney.routeName,
              arguments: JourneyArgument(journey: this.journey, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<JourneyBloc>().add(JourneyDelete(this.journey));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    JourneyList.routeName, (route) => false);
              }),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white10, Colors.blue])),
        child: Center(
          child: Column(
            children: [
              Text(
                'Travel Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                  title: Text('Journey Source: ${this.journey.source}',
                      style: TextStyle(color: Colors.amber)),
                  subtitle: Text(
                      'Journey Destination: ${this.journey.destination}',
                      style: TextStyle(color: Colors.amber))),
              Text('Journey Price: ${this.journey.price}',
                  style: TextStyle(color: Colors.amber)),
              RaisedButton(
                child: Text('Book'),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    BookingList.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
