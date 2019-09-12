import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topilocal_app/widgets/provider_widget.dart';

class BusinessHomeView extends StatelessWidget {
  // final List<Job> jobList = [
  //   Job(
  //       'Server at Wonka',
  //       'Wonka Industries',
  //       'Toronto, ON',
  //       '> 1yr',
  //       DateTime.now(),
  //       'Mon-Fri',
  //       DateTime.now().toString(),
  //       DateTime.now().toString(),
  //       15.25,
  //       DateTime.now()),
  //   Job(
  //       'Truck Driver needed',
  //       'Acme Corp.',
  //       'Mississauga, ON',
  //       '> 1yr',
  //       DateTime.now(),
  //       'Mon-Fri',
  //       DateTime.now().toString(),
  //       DateTime.now().toString(),
  //       18.25,
  //       DateTime.now()),
  //   Job(
  //       'Good lawyer at a large lawfirm',
  //       'Stark Industries',
  //       'Toronto, ON',
  //       '> 1yr',
  //       DateTime.now(),
  //       'Mon-Fri',
  //       DateTime.now().toString(),
  //       DateTime.now().toString(),
  //       115.50,
  //       DateTime.now()),
  //   Job(
  //       'Wand maker',
  //       'Ollivander\'s Wand Shop',
  //       'Burlington, ON',
  //       '> 1yr',
  //       DateTime.now(),
  //       'Mon-Fri',
  //       DateTime.now().toString(),
  //       DateTime.now().toString(),
  //       25.25,
  //       DateTime.now()),
  //   Job(
  //       'Programmer part time web development',
  //       'Gekko & Co',
  //       'Markham, ON',
  //       '> 1yr',
  //       DateTime.now(),
  //       'Mon-Fri',
  //       DateTime.now().toString(),
  //       DateTime.now().toString(),
  //       35.25,
  //       DateTime.now()),
  //   Job(
  //     'Robin',
  //     'Wayne Enterprises',
  //     'Toronto, ON',
  //     '> 1yr',
  //     DateTime.now(),
  //     'Mon-Fri',
  //     DateTime.now().toString(),
  //     DateTime.now().toString(),
  //     250.25,
  //     DateTime.now(),
  //   ),
  //   // 'Wonka Industries',
  //   // 'Acme Corp.',
  //   // 'Stark Industries',
  //   // 'Ollivander\'s Wand Shop',
  //   // 'Gekko & Co',
  //   // 'Wayne Enterprises',
  //   // 'Cyberdyne Systems',
  //   // 'Cheers',
  //   // 'Genco Pura Olive Oil Company',
  //   // 'The New York Inquirer',
  //   // 'Duff Beer',
  //   // 'Bubba Gump',
  //   // 'Olivia Pope & Associates',
  //   // 'Krusty Krab',
  //   // 'Sterling Cooper',
  //   // 'Soylent',
  //   // 'Hooli',
  //   // 'Good Burger',
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersJobsStreamSnapshots(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading');
          return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) =>
                buildJobCard(context, snapshot.data.documents[index]),
          );
        }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersJobsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('jobs').snapshots();
  }

  Widget buildJobCard(BuildContext context, DocumentSnapshot job) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(job['businessName']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(job['title'], style: new TextStyle(fontSize: 16.0)),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(job['location']),
                    Spacer(),
                    Text('${(job['startDate'] == null) ? 'N/A' : DateFormat('MMM dd, yyyy').format(job['startDate'].toDate()).toString()}'),
                    // Text('\$${job.hrlyWage.toStringAsFixed(2)}/hr'),
                  ],
                ),
              ),
              // Text(job.duration),
              // Text(
              //     '${job.workDays} ${DateFormat('Hm').format(job.scheduleStart)} - ${DateFormat('Hm').format(job.scheduleEnd)}'),
              // Text(DateFormat('MM/dd/yyyy').format(job.expiry)),
            ],
          ),
        ),
      ),
    );
  }
}
