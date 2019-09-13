import 'package:flutter/material.dart';
import 'package:topilocal_app/pages.dart';
import 'package:topilocal_app/business/models/Job.dart';
import 'package:topilocal_app/services/auth_service.dart';
import 'package:topilocal_app/widgets/provider_widget.dart';
import 'package:topilocal_app/personal/views/home_view.dart';
import 'package:topilocal_app/business/views/business_home_view.dart';
import 'package:topilocal_app/business/views/new_jobs/location_view.dart';
// import 'package:topilocal_app/views/sign_up_view.dart';

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomeState();
  }
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;
  final List<Widget> _businessChildren = [
    BusinessHomeView(),
    BusinessSearchView(),
    BusinessSavedView(),
    AccountView(),
  ];

  final List<Widget> _personalChildren = [
    HomeView(),
    SearchView(),
    SavedView(),
    AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newJob =
        new Job(null, null, null, null, null, null, null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Topilocal'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewJobLocationView(
                              job: newJob,
                            )));
              }),
              // IconButton(
              // icon: Icon(Icons.undo),
              // onPressed: () async {
              //  try {
              //    AuthService auth = Provider.of(context).auth;
              //    await auth.signOut();
              //    print('Signed Out');               
              // } catch (e) {
              //   print (e);
              // }
              // }),
              // IconButton(
              // icon: Icon(Icons.account_circle),
              // onPressed: () {
              //  Navigator.of(context).pushNamed('/convertUser');
              // }),
        ],
      ),
      body: _businessChildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text('Saved'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text('Account'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
