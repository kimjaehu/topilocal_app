import 'package:flutter/material.dart';
import 'package:topilocal_app/business/models/Job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topilocal_app/widgets/provider_widget.dart';

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
            Text('Start date ${job.startDate}'),
            Text('start ${job.startTime}'),
            Text('end ${job.endTime}'),
            
            RaisedButton(
              child: Text('Submit'),
              onPressed: () async {
                //save data to firebase later
                final uid = await Provider.of(context).auth.getCurrentUID();
                await db.collection('userData').document(uid).collection('jobs').add(job.toJson());
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
