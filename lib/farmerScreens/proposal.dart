import 'package:farmwise/farmerScreens/createProposal.dart';
import 'package:farmwise/farmerScreens/rejectCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/farmerScreens/productCard.dart';
import 'package:farmwise/farmerScreens/productList.dart';

class proposal extends StatefulWidget {
  const proposal({super.key});

  @override
  State<proposal> createState() => _myInvestmentState();
}

class _myInvestmentState extends State<proposal> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
              child: const Text(
                "Completed",
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
                return productCard(productList: productList[index]);
              },
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
              child: const Text(
                "Rejected",
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
                return rejectCard(productList: productList[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
