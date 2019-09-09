import 'package:flutter/material.dart';
import 'package:topilocal_app/business/models/Job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewJobSummaryView extends StatelessWidget {
  final db = Firestore.instance;

  final Job job;
  NewJobSummaryView({Key key, @required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a job'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter a job'),
            Text('location ${job.title}'),
            Text('start ${job.scheduleStart}'),
            Text('end ${job.scheduleEnd}'),

            RaisedButton(
              child: Text('Submit'),
              onPressed: () async {
                //save data to firebase later
                await db.collection("jobs").add(job.toJson());

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
