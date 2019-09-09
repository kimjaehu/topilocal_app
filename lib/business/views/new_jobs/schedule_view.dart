import 'package:flutter/material.dart';
import 'package:topilocal_app/business/models/Job.dart';

import './summary_view.dart';

class NewJobScheduleView extends StatelessWidget {
  final Job job;
  NewJobScheduleView({Key key, @required this.job}) : super(key: key);

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
            Text('location ${job.title}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Enter a start time'),
                Text('Enter a end time'),
              ],
            ),
            
            RaisedButton(
              child: Text('continue'),
              onPressed: () {
                job.scheduleStart = DateTime.now();
                job.scheduleEnd = DateTime.now();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewJobSummaryView(
                      job: job,
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
