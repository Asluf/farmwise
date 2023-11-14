import 'package:farmwise/farmerScreens/createProposal.dart';
import 'package:farmwise/farmerScreens/ongoingCard.dart';
import 'package:farmwise/farmerScreens/pandingCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/farmerScreens/productList.dart';

class myInvestment extends StatefulWidget {
  const myInvestment({super.key});

  @override
  State<myInvestment> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<myInvestment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return CreateProposal();
          }));
        }, // Action to be taken on press
        child: Icon(Icons.add), // Icon to be displayed
        backgroundColor: const Color.fromARGB(
            255, 5, 46, 2), // Optional: specify the background color
        foregroundColor: Colors.white, // Optional: specify the icon color
        tooltip: 'Add', // Optional: tooltip text on hover
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //filter
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here..",
                      isDense: true,
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(99),
                          )),
                      //prefixIcon: ,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton.filled(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 107, 156, 104),
                      )),
                )
              ],
            ),
          ),
          //consultation
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              height: 170,
              child: Card(
                color: Colors.green.shade50,
                elevation: 0.1,
                shadowColor: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Free Consultation",
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Get free support from our customer service"),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Color.fromARGB(255, 85, 127, 83)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  )),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Call now",
                                  style: TextStyle(),
                                ))
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/contact_us.png",
                        width: 140,
                      ),
                    ],
                  ),
                ),

                //image
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
            child: const Text(
              "On going",
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return ongoingCard(productList: productList[index]);
            },
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
            child: const Text(
              "pending",
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return pandingCard(productList: productList[index]);
            },
          )
        ],
      ),
    );
  }
}
