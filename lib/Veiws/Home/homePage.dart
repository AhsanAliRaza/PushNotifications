import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Push Notifications',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(children: [

        ],),
      ),
    );
  }
}
