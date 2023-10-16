import 'package:flutter/material.dart';

class NotificationInvestor extends StatefulWidget {
  const NotificationInvestor({super.key});

  @override
  State<NotificationInvestor> createState() => _NotificationInvestorState();
}

class _NotificationInvestorState extends State<NotificationInvestor> {
  @override
  Widget build(BuildContext context) {
    final double wid = MediaQuery.of(context).size.width;
    final double hei = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("bgAppbar.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text("Notifications"),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white, // White container
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10),
              width: wid - 20,
              child: Text("Notificationsssssssss"),
            ),
          ],
        ),
      ),
    );
  }
}
