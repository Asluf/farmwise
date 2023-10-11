import 'package:flutter/material.dart';

class NotificationInvestor extends StatefulWidget {
  const NotificationInvestor({super.key});

  @override
  State<NotificationInvestor> createState() => _NotificationInvestorState();
}

class _NotificationInvestorState extends State<NotificationInvestor> {
  @override
  Widget build(BuildContext context) {
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
        title: Text("Notification"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [Text("Notificationsssssssss")],
      )),
    );
  }
}
