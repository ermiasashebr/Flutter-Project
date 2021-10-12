import 'package:finall/journeys/journeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateSchedule extends StatefulWidget {
  static const routeName = 'scheduleAddUpdate';
  final ScheduleArgument args;

  AddUpdateSchedule({this.args});
  @override
  _AddUpdateScheduleState createState() => _AddUpdateScheduleState();
}

class _AddUpdateScheduleState extends State<AddUpdateSchedule> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _schedule = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Booking" : "Add New Booking"}'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white10, Colors.blue])),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.schedule.travelID : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Schedule travelID';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Schedule travelID'),
                    onSaved: (value) {
                      setState(() {
                        this._schedule["travelID"] = value;
                      });
                    }),
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.schedule.classs : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Schedule class';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Schedule Class'),
                    onSaved: (value) {
                      this._schedule["classs"] = value;
                    }),
                TextFormField(
                    initialValue: widget.args.edit
                        ? widget.args.schedule.startingTime
                        : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Schedule starting time';
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(labelText: 'Schedule starting time'),
                    onSaved: (value) {
                      this._schedule["classs"] = value;
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        final ScheduleEvent event = widget.args.edit
                            ? ScheduleUpdate(
                                Schedule(
                                  id: widget.args.schedule.id,
                                  travelID: this._schedule["travelID"],
                                  classs: this._schedule["class"],
                                  startingTime: this._schedule["startingTime"],
                                ),
                              )
                            : ScheduleCreate(
                                Schedule(
                                  travelID: this._schedule["travelID"],
                                  classs: this._schedule["class"],
                                  startingTime: this._schedule["startingTime"],
                                ),
                              );
                        BlocProvider.of<ScheduleBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            BookingList.routeName, (route) => false);
                      }
                    },
                    label: Text('SAVE'),
                    icon: Icon(Icons.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
