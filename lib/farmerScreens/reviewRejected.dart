import 'package:flutter/material.dart';

class reviewRejected extends StatefulWidget {
  const reviewRejected({super.key});

  @override
  State<reviewRejected> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<reviewRejected> {
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
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Review Rejected",
                  style: TextStyle(
                      color: Color.fromARGB(255, 192, 226, 190),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Montserrat'),
                ),
 
              ])
                  

                  
                )
              
             );
  }
}
