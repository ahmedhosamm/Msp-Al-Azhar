import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home 1')),
      body: Center(child: Text('1', style: TextStyle(fontSize: 48))),
    );
  }
}
