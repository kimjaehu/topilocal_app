import 'package:flutter/material.dart';
import 'package:topilocal_app/business/models/Job.dart';

import 'schedule_view.dart';

class NewJobLocationView extends StatelessWidget {
  final Job job;
  NewJobLocationView({Key key, @required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _businessNameController = new TextEditingController();
    TextEditingController _titleController = new TextEditingController();
    TextEditingController _locationController = new TextEditingController();

    _businessNameController.text = job.businessName;
    _titleController.text = job.title;
    _locationController.text = job.location;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create a job'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Business name'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _businessNameController,
                autofocus: true,
              ),
            ),
            Text('Enter a title'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            Text('Location'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _locationController,
                autofocus: true,
              ),
            ),
            RaisedButton(
              child: Text('continue'),
              onPressed: () {
                job.businessName = _businessNameController.text;
                job.location = _locationController.text;
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
