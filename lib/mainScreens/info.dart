import 'dart:ui';

import 'package:farmwise/mainScreens/homePage.dart';
import 'package:farmwise/mainScreens/login.dart';
import 'package:farmwise/mainScreens/registerFarmer.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    final double hei = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(children: [
      Container(
          height: hei,
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("bgLeaves.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // IconButton(
                      //   onPressed: () {
                      //     Navigator.pop(context, Homepage());
                      //   },
                      //   icon: const Icon(Icons.arrow_back),
                      //   color: Color.fromARGB(255, 192, 226, 190),
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("FARMWISE",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 192, 226, 190),
                                      fontSize: 40)),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Grow Crops Grow Wealth",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 192, 226, 190),
                                      fontSize: 20)),
                              SizedBox(
                                height: 25,
                              )
                            ],
                          )),
                      Expanded(
                          child: Container(
                              child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 45,
                            ),
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SectionCard(
                                    icon: Icons.info,
                                    title: 'About Us',
                                    content:
                                        'FarmWise is a mobile application that connects farmers, investors, and buyers in the agricultural industry. We strive to promote sustainable farming and support farmers in reaching their potential.',
                                  ),
                                  const SizedBox(height: 24.0),
                                  SectionCard(
                                    icon: Icons.assistant_photo,
                                    title: 'Aims and Objectives',
                                    content: 'Our primary objectives are:\n'
                                        '- To empower farmers through technology\n'
                                        '- To provide investment opportunities in agriculture\n'
                                        '- To bridge the gap between farmers and buyers',
                                  ),
                                  const SizedBox(height: 24.0),
                                  SectionCard(
                                    icon: Icons.contact_mail,
                                    title: 'Contact Us',
                                    content:
                                        'Email: contact@farmconnectapp.com\nPhone: +1 (123) 456-7890',
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, registerFarmer());
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 248, 248, 248)),
                                        elevation: MaterialStateProperty.all(4),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(30, 60)),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 50)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Get Started  ',
                                            style: TextStyle(
                                              color: Colors.green[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward,
                                              color: Colors.green[
                                                  600] // Customize icon color
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )))
                    ]),
              ))
            ],
          )),
    ]));
  }
}

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  SectionCard({required this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 36.0, color: Colors.green[600]),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
