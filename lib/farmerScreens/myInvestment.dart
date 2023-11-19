import 'package:farmwise/farmerScreens/createProposal.dart';
import 'package:farmwise/farmerScreens/widgets/approvedCard.dart';
import 'package:farmwise/farmerScreens/widgets/ongoingCard.dart';
import 'package:farmwise/farmerScreens/widgets/pendingCard.dart';
import 'package:farmwise/farmerScreens/widgets/completedCard.dart';
import 'package:farmwise/farmerScreens/widgets/rejectCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/farmerScreens/data/productList.dart';
import '../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/farmerScreens/data/pendingProposalList.dart';

class myInvestment extends StatefulWidget {
  const myInvestment({super.key});

  @override
  State<myInvestment> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<myInvestment> {
  final AuthService _authService = AuthService();
  String email = '';
  String token = '';
  List<ProposalDetails> fetchedPendingProposals = [];
  List<ProposalDetails> fetchedApprovedProposals = [];
  List<ProposalDetails> fetchedOngoingProposals = [];
  List<ProposalDetails> fetchedCompletedProposals = [];
  List<ProposalDetails> fetchedRejectedProposals = [];

  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchPendingData();
  }

  Future<String> fetchPendingData() async {
    email = await _authService.getEmail();
    token = await _authService.getToken();

    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // pendingData
      final Map<String, dynamic> data = {
        "email": email,
        "proposal_status": "pending",
        "cultivation_status": "pending"
      };
      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getCultivation'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['proposalDetails'];

        for (var proposalJson in proposalsJson) {
          ProposalDetails proposal = ProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedPendingProposals.add(proposal);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
      }
      // approved data
      final Map<String, dynamic> data2 = {
        "email": email,
        "proposal_status": "approved",
        "cultivation_status": "pending"
      };
      final response2 = await http.post(
        Uri.parse('http://localhost:5005/api/getCultivation'),
        headers: headers,
        body: jsonEncode(data2),
      );
      if (response2.statusCode == 200) {
        Map<String, dynamic> jsonData2 = json.decode(response2.body);
        List<dynamic> proposalsJson2 = jsonData2['proposalDetails'];
        for (var proposalJson2 in proposalsJson2) {
          ProposalDetails proposal2 = ProposalDetails.fromJson(proposalJson2);
          setState(() {
            fetchedApprovedProposals.add(proposal2);
          });
        }
      } else {
        print('Failed to fetch data ${response2.body}');
      }
      // rejected data
      final Map<String, dynamic> data3 = {
        "email": email,
        "proposal_status": "rejected",
        "cultivation_status": "pending"
      };
      final response3 = await http.post(
        Uri.parse('http://localhost:5005/api/getCultivation'),
        headers: headers,
        body: jsonEncode(data3),
      );
      if (response3.statusCode == 200) {
        Map<String, dynamic> jsonData3 = json.decode(response3.body);
        List<dynamic> proposalsJson3 = jsonData3['proposalDetails'];
        for (var proposalJson3 in proposalsJson3) {
          ProposalDetails proposal3 = ProposalDetails.fromJson(proposalJson3);
          setState(() {
            fetchedRejectedProposals.add(proposal3);
          });
        }
      } else {
        print('Failed to fetch data ${response3.body}');
      }
      // ongoing data
      final Map<String, dynamic> data4 = {
        "email": email,
        "proposal_status": "approved",
        "cultivation_status": "ongoing"
      };
      final response4 = await http.post(
        Uri.parse('http://localhost:5005/api/getCultivation'),
        headers: headers,
        body: jsonEncode(data4),
      );
      if (response4.statusCode == 200) {
        Map<String, dynamic> jsonData4 = json.decode(response4.body);
        List<dynamic> proposalsJson4 = jsonData4['proposalDetails'];
        for (var proposalJson4 in proposalsJson4) {
          ProposalDetails proposal4 = ProposalDetails.fromJson(proposalJson4);
          setState(() {
            fetchedOngoingProposals.add(proposal4);
          });
        }
      } else {
        print('Failed to fetch data ${response4.body}');
      }
      // complted data
      final Map<String, dynamic> data5 = {
        "email": email,
        "proposal_status": "approved",
        "cultivation_status": "completed"
      };
      final response5 = await http.post(
        Uri.parse('http://localhost:5005/api/getCultivation'),
        headers: headers,
        body: jsonEncode(data5),
      );
      if (response5.statusCode == 200) {
        Map<String, dynamic> jsonData5 = json.decode(response5.body);
        List<dynamic> proposalsJson5 = jsonData5['proposalDetails'];
        for (var proposalJson5 in proposalsJson5) {
          ProposalDetails proposal5 = ProposalDetails.fromJson(proposalJson5);
          setState(() {
            fetchedOngoingProposals.add(proposal5);
          });
        }
      } else {
        print('Failed to fetch data ${response5.body}');
      }
    } catch (er) {
      print(er);
    }
    await Future.delayed(const Duration(seconds: 1));
    return "done";
  }

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
        tooltip: 'Add Proposal', // Optional: tooltip text on hover
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
            return Home(context);
          }
        },
      ),
    );
  }

  Widget Home(BuildContext context) {
    // print(fetchedProposals[1].crop_name);
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
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
                      ),
                    ),
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
                  ),
                ),
              ),
            ],
          ),
        ),
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
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 85, 127, 83)),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Call now",
                              style: TextStyle(),
                            ),
                          ),
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
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'On-Going ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedOngoingProposals.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedOngoingProposals.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.76,
                ),
                itemCount: fetchedOngoingProposals.length,
                itemBuilder: (BuildContext context, int index) {
                  return ongoingCard(
                      proposalList: fetchedOngoingProposals[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No ongoing proposals",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Pending ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedPendingProposals.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedPendingProposals.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.76,
                ),
                itemCount: fetchedPendingProposals.length,
                itemBuilder: (BuildContext context, int index) {
                  return pendingCard(
                      proposalList: fetchedPendingProposals[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No pending proposals",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Approved ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedApprovedProposals.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedApprovedProposals.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.76,
                ),
                itemCount: fetchedApprovedProposals.length,
                itemBuilder: (BuildContext context, int index) {
                  return approvedCard(
                      proposalList: fetchedApprovedProposals[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No approved proposals",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Completed ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedCompletedProposals.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedCompletedProposals.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.76,
                ),
                itemCount: fetchedCompletedProposals.length,
                itemBuilder: (BuildContext context, int index) {
                  return completedCard(
                      proposalList: fetchedCompletedProposals[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No completed proposals",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Row(
            children: [
              const Text(
                'Rejected ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${fetchedRejectedProposals.length})',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        fetchedRejectedProposals.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.76,
                ),
                itemCount: fetchedRejectedProposals.length,
                itemBuilder: (BuildContext context, int index) {
                  return rejectedCard(
                      proposalList: fetchedRejectedProposals[index]);
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 48.0,
                    color: Color.fromARGB(255, 119, 114, 114),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "No rejected proposals",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
      ],
    );
  }
}
