import 'package:flutter/material.dart';

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ExpansionTile(
            title: Text('See More'),
            collapsedTextColor: Colors.green[600],
            textColor: Colors.red,
            iconColor: Colors.green[600],
            backgroundColor: Colors.grey[200],
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (value) {
              setState(() {
                _isExpanded = value;
              });
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Additional content goes here.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
