import 'package:flutter/material.dart';
import 'package:topilocal_app/business/models/Job.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import './summary_view.dart';

class NewJobScheduleView extends StatefulWidget {
  final Job job;
  NewJobScheduleView({Key key, @required this.job}) : super(key: key);

  @override
  _NewJobScheduleViewState createState() => _NewJobScheduleViewState();
}

class _NewJobScheduleViewState extends State<NewJobScheduleView> {
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 8)));

  Future displayDatePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(
        Duration(seconds: 1),
      ),
      firstDate: new DateTime.now().subtract(Duration(days: 1)),
      lastDate: new DateTime(DateTime.now().year + 5),
    );
    if (selectedDate != null) {
      setState(() {
        _startDate = selectedDate;
      });
    }
  }

  Future displayStartTimePicker(BuildContext context) async {
    final selectedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedStartTime != null) {
      setState(() {
        _startTime = selectedStartTime;
      });
    }
  }

  Future displayEndTimePicker(BuildContext context) async {
    final selectedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedEndTime != null) {
      setState(() {
        _endTime = selectedEndTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController _titleController = new TextEditingController();
    // _titleController.text = job.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create a job'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text('Start date'),
                onPressed: () async {
                  await displayDatePicker(context);
                }),
            Text('business name ${widget.job.businessName}'),
            Text('location ${widget.job.location}'),
            Text('title ${widget.job.title}'),
            Text(
                'Start date: ${DateFormat('MM/dd/yyyy').format(_startDate).toString()}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Enter a start time'),
                Text('Enter a end time'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    child: Text('Start Time'),
                    onPressed: () async {
                      await displayStartTimePicker(context);
                    }),
                RaisedButton(
                    child: Text('Finish Time'),
                    onPressed: () async {
                      await displayEndTimePicker(context);
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Start time: ${_startTime.hour}:${_startTime.minute}'),
                Text('End time: ${_endTime.hour}:${_endTime.minute}'),
              ],
            ),
            RaisedButton(
              child: Text('continue'),
              onPressed: () {
                widget.job.startDate = _startDate;
                widget.job.startTime = _startTime.toString();
                widget.job.endTime = _endTime.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewJobSummaryView(
                      job: widget.job,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
