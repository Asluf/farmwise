import 'package:farmwise/farmerScreens/createProposal.dart';
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
  List<ProposalDetails> fetchedProposals = [];
  List<UserData> fetchedFarmer = [];
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
      final Map<String, dynamic> data = {"email": email};

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getPendingCultivation'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Process the data retrieved from the server

        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['proposalDetails'];

        for (var proposalJson in proposalsJson) {
          ProposalDetails proposal = ProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedProposals.add(proposal);
          });
        }
      } else {
        // Handle any errors
        print('Failed to fetch data ${response.body}');
      }
    } catch (er) {
      print(er);
    }
    await Future.delayed(Duration(seconds: 2));
    return "hi";
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
        fetchedProposals.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: fetchedProposals.length,
                itemBuilder: (BuildContext context, int index) {
                  return pendingCard(proposalList: fetchedProposals[index]);
                },
              )
            : Text("No any pending proposal"),
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
            return completedCard(productList: productList[index]);
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
    );
  }
}
