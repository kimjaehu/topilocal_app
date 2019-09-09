import 'package:flutter/material.dart';
import 'package:topilocal_app/business/models/Job.dart';

import './schedule_view.dart';

class NewJobLocationView extends StatelessWidget {
  final Job job;
  NewJobLocationView({Key key, @required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = job.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create a job'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter a job'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            RaisedButton(
              child: Text('continue'),
              onPressed: () {
                job.title = _titleController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewJobScheduleView(
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
