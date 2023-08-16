import 'package:flutter/material.dart';
import './diagnose_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('AIDoctor'),
              SizedBox(width: 200,),

              Align(
                alignment: Alignment.topRight,
                  child:IconButton(
                    icon: Icon(Icons.logout),
                onPressed: (){
                  _auth.signOut();
                  Navigator.pushNamed(context, '/loginScreen');
                },
              ))
            ],
          ),
          backgroundColor: Colors.blue[600],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.health_and_safety), text: 'Diagnose'),
              Tab(icon: Icon(Icons.info), text: 'About',),
            ],
          ),
        ),
        body: TabBarView(
         children: [
           DiagnosePage(),
           Text('About'),
         ],
        ),
      ),
    );
  }
}
