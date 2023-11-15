import 'package:flutter/material.dart';

class ReviewProposal extends StatefulWidget {
  const ReviewProposal({super.key, required this.proposalId});
  final String proposalId;

  @override
  State<ReviewProposal> createState() => _ReviewProposalState();
}

class _ReviewProposalState extends State<ReviewProposal> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
        title: Text("Proposal Overview"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        width: 10,
                        color: Color.fromARGB(255, 192, 226, 190),
                      ),
                    ),
                  ),
                  width: (screenWidth / 2) - 10,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/Garlic.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 192, 226, 190),
                borderRadius: BorderRadius.circular(5),
              ),
              width: screenWidth - 30,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "Crop Name:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          "Garlic",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "Farmer Name:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          "Perera",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "Time Period:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "2023-8-10  to  20223-11-5",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "Total Investment:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          "Rs.100,000",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "From Farmer:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          "40,000",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "Amount Needed (Investor):",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          "Rs. 60,000",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: (screenWidth - 60) / 2,
                        child: const Text(
                          "Expected ROI:",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Text(
                          "17%",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: ElevatedButton(
                onPressed: () {
                  _showAcceptConfirmationDialog(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 5, 46, 2)),
                  elevation: MaterialStatePropertyAll(4),
                  minimumSize:
                      MaterialStatePropertyAll(Size(screenWidth - 100, 50)),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 70)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                child: const Text(
                  "Accept",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAcceptConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          // icon: const Icon(Icons.check),
          buttonPadding: EdgeInsets.fromLTRB(0, 0, 30, 30),
          // title: Text('Confirm Logout'),
          content:
              Text('Are you sure you want to accept or cancel the proposal?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle the operations for accept the proposal
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 5, 46, 2)),
                elevation: MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text("Accept"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 177, 24, 3)),
                elevation: MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text("Dismiss"),
            ),
          ],
        );
      },
    );
  }
}
