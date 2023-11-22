import 'package:flutter/material.dart';

class Test3 extends StatefulWidget {
  @override
  _Test3State createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  // Mock data for the example
  List<String> items = List.generate(20, (index) => 'Item $index');

  // Function to simulate data refresh
  Future<void> _refreshData() async {
    // Simulate a network request or any asynchronous operation
    await Future.delayed(Duration(seconds: 2));

    // Update the data
    setState(() {
      items = List.generate(20, (index) => 'Refreshed Item $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull-to-Refresh Example'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}
