import 'package:farmwise/main.dart';
import 'package:flutter/material.dart';

class reviewOngoing extends StatefulWidget {
  const reviewOngoing({super.key});

  @override
  State<reviewOngoing> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<reviewOngoing> {
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
                  "Review Ongoing",
                  style: TextStyle(
                      color: Color.fromARGB(255, 192, 226, 190),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Montserrat'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                ),
              ],
            )),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
              child: const Text(
                "Tomato",
                style: TextStyle(
                  color: Colors.green,
                  
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              
              ),
            ),
             Container(child: Image.asset('assets/tomato.jpeg',
             width: 500,height: 300,)),

             Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Crop Name:",
                  style: TextStyle(fontSize: 17),
                  ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Tomato",
                      style: TextStyle(fontSize: 17),
                    ),
                  

                  
                )
              ]
             ),
           Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Farmer Name:",
                  style: TextStyle(fontSize: 17),
                  ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Ishani Bandara",
                      style: TextStyle(fontSize: 17),
                    ),
                  

                  
                )
              ]
             ),
              Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Time Period:",
                  style: TextStyle(fontSize: 17),
                  ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "2023/8/30 to 2023/12/30",
                      style: TextStyle(fontSize: 17),
                    ),
                  

                  
                )
              ]
             ),
              Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Total Investment:",
                  style: TextStyle(fontSize: 17),
                  ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Rs.100000",
                      style: TextStyle(fontSize: 17),
                    ),
                  

                  
                )
              ]
             ),
              Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("From Farmer:",
                  style: TextStyle(fontSize: 17),
                  ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Rs.40000",
                      style: TextStyle(fontSize: 17),
                    ),
                  

                  
                )
              ]
             ),
               Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Amount Needed (Investor):",
                  style: TextStyle(fontSize: 17),
                  ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Rs.60000",
                      style: TextStyle(fontSize: 17),
                    ),
                  

                  
                )
              ]
             ),
            
              Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("ROI:",
                  style: TextStyle(fontSize: 17),
                  ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "17%",
                      style: TextStyle(fontSize: 17),
                    ),
                  

                  
                )
              ]
             ),


          ],
        )));
  }
}
