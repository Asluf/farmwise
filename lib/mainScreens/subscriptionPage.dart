import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});
void showPopupDialog(BuildContext context) {
    final double wid = MediaQuery.of(context).size.width;
    final double hei = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pricing',
            style: TextStyle(
              color: const Color.fromARGB(255, 28, 80, 31),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.8,
            child: Container(
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: wid - 30,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            width: 2,
                            color: Colors.grey,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Silver',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.credit_card,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                    'Monthly plan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: const Color.fromARGB(
                                          255, 100, 41, 20),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    ' \$10',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 100, 41, 20),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      height: 120,
                      width: wid - 30,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            width: 2,
                            color: Colors.amber,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gold',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.credit_card, color: Colors.amber),
                                  Row(
                                    children: [
                                      Text(
                                    '6 Month plan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: const Color.fromARGB(
                                          255, 100, 41, 20),                                         
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    ' \$50',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 100, 41, 20),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: wid,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            width: 2.5,
                            color: Colors.green.shade600,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Premium',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.credit_card,
                                    color: Colors.green.shade600,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Yearly plan ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: const Color.fromARGB(
                                            255,
                                            100,
                                            41,
                                            20,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                    ' \$90',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 100, 41, 20,
                                          ),
  
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: const Color.fromARGB(255, 28, 80, 31),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}