import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finall/journeys/bloc/bloc.dart';
import 'package:finall/journeys/journeys.dart';

class JourneyList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Journeys'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white10, Colors.blue])),
        child: BlocBuilder<JourneyBloc, JourneyState>(
          builder: (_, state) {
            if (state is JourneyOperationFailure) {
              return Text('Could not do Journey operation');
            }

            if (state is JourneysLoadSuccess) {
              final journeys = state.journeys;

              return ListView.builder(
                itemCount: journeys.length,
                itemBuilder: (_, idx) => ListTile(
                  title: Text(
                    'Journey Source: ${journeys[idx].source}',
                    style: TextStyle(color: Colors.amber),
                  ),
                  subtitle: Text(
                    'Journey Price: ${journeys[idx].price}',
                    style: TextStyle(color: Colors.amber),
                  ),
                  onTap: () => Navigator.of(context).pushNamed(
                      JourneyDetail.routeName,
                      arguments: journeys[idx]),
                ),
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateJourney.routeName,
          arguments: JourneyArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
