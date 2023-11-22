import 'package:farmwise/investorScreens/data/approvedProposalList.dart';
import 'package:farmwise/investorScreens/data/proposalList.dart';
import 'package:farmwise/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewProposal extends StatefulWidget {
  const ReviewProposal({super.key, required this.proposalList});

  final ApprovedProposalDetails proposalList;

  @override
  State<ReviewProposal> createState() => _ReviewProposalState();
}

class _ReviewProposalState extends State<ReviewProposal> {
  final AuthService _authService = AuthService();
  String token = '';
  String email = '';
  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(); // Fetch data when the profile page loads
  }

  Future<String> fetchData() async {
    token = await _authService.getToken();
    await Future.delayed(const Duration(seconds: 1));
    return "done";
  }

  Future<void> requestProposal(String proposal_id) async {
    setState(() {
      futureData = Future.value("Requesting");
    });
    email = await _authService.getEmail();
    // calling to api to change the status
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json'
      };
      final Map<String, dynamic> data = {
        "proposal_id": proposal_id,
        "investor_email": email
      };

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/requestCultivation'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print('Requested successfully');

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Requested successfully')));

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/investorDash', (route) => false);
        });
      } else {
        print('Failed to send POST request');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to request. Try again')));

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/investorDash', (route) => false);
        });
      }
    } catch (er) {
      print(er);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ApprovedProposalDetails proposalList = widget.proposalList;

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
      body: FutureBuilder<String>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, display a loading spinner or an animation
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green.shade600), // Set your desired color
              ),
            );
          } else if (snapshot.hasError) {
            // If there's an error in the Future, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete and data is received, display the data
            // return Text('Data: ${snapshot.data}');
            return review(context);
          }
        },
      ),
    );
  }

  Widget review(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ApprovedProposalDetails proposalList = widget.proposalList;
    String roiInvestorString = proposalList.roi_investor;
    double roiInvestor = double.parse(roiInvestorString);
    double roundedRoiInvestor = double.parse(roiInvestor.toStringAsFixed(2));

    return SingleChildScrollView(
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
                  child: Image.network((proposalList != '' &&
                          proposalList.land_img_path != '')
                      ? 'http://localhost:5005/${proposalList.land_img_path}' ??
                          'http://localhost:5005/uploads/culproposal/default.png'
                      : 'http://localhost:5005/uploads/culproposal/default.png'),
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
                      child: Text(
                        proposalList.crop_name,
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
                      child: Text(
                        proposalList.farmerDetails.farmer_name,
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
                      child: Text(
                        proposalList.duration,
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
                      child: Text(
                        proposalList.total_amount,
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
                      child: Text(
                        proposalList.investment_of_farmer,
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
                      child: Text(
                        proposalList.investment_of_investor,
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
                      child: Text(
                        "$roundedRoiInvestor %",
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
                "Request",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
        ],
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
                Navigator.of(context).pop();
                requestProposal(widget.proposalList.proposal_id);
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
              child: Text("Request"),
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
