import 'dart:ui';
import 'package:farmwise/mainScreens/info.dart';
import 'package:farmwise/mainScreens/login.dart';
//import 'package:farmwise/mainScreens/registerFarmer.dart';
import 'package:farmwise/mainScreens/registerSelection.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final double wid = MediaQuery.of(context).size.width;
    final double hei = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("bgLeaves.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              child: Text(
                "FARMWISE",
                style: TextStyle(
                  color: const Color.fromARGB(255, 192, 226, 190),
                  fontSize: 37,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Grow Crops, Grow Wealth",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 192, 226, 190),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, hei / 2, 0, 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => registerSelection()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 5, 46, 2)),
                  elevation: MaterialStatePropertyAll(4),
                  minimumSize: MaterialStatePropertyAll(Size(wid - 50, 60)),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 70)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 192, 226, 190)),
                elevation: const MaterialStatePropertyAll(4),
                minimumSize: MaterialStatePropertyAll(Size(wid - 50, 60)),
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 70)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: const Text(
                "Sign in",
                style: TextStyle(
                    color: Color.fromARGB(255, 5, 46, 2), fontSize: 22),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Info()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    elevation: MaterialStatePropertyAll(4),
                    // minimumSize: MaterialStatePropertyAll(Size(100, 40)),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 70)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "More info",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 192, 226, 190),
                            fontSize: 15),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.arrow_circle_right_sharp,
                        color: const Color.fromARGB(255, 192, 226, 190),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
