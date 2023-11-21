import 'package:farmwise/investorScreens/allProposal.dart';
import 'package:farmwise/investorScreens/data/approvedProposalList.dart';
import 'package:farmwise/investorScreens/searchProposal.dart';
import 'package:farmwise/investorScreens/widgets/proposalCard.dart';
import 'package:farmwise/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/investorScreens/data/proposalList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProposalInvestor extends StatefulWidget {
  const ProposalInvestor({super.key});

  @override
  State<ProposalInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProposalInvestor> {
  final AuthService _authService = AuthService();
  String token = '';
  List<ApprovedProposalDetails> fetchedApprovedProposals = [];

  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchApprovedData();
  }

  Future<String> fetchApprovedData() async {
    token = await _authService.getToken();

    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // pendingData

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/showCultivation'),
        headers: headers,
        body: "",
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['approvedProposalDetails'];

        for (var proposalJson in proposalsJson) {
          ApprovedProposalDetails proposal =
              ApprovedProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedApprovedProposals.add(proposal);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
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
    return ListView(padding: EdgeInsets.all(16), children: [
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(99),
                      )),
                  //prefixIcon: ,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: IconButton.filled(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SearchProposal()),
                    // );
                  },
                  icon: const Icon(
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
                              backgroundColor: const MaterialStatePropertyAll(
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Featured Proposals",
            style: TextStyle(
              color: const Color.fromARGB(255, 4, 5, 4),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AllProposal()),
              // );
            },
            child: Text(
              "See all",
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      // Proposal Items card
      fetchedApprovedProposals.length > 0
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: fetchedApprovedProposals.length,
              itemBuilder: (BuildContext context, int index) {
                // returning the cart
                return ProposalCard(
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
                  "No pending proposals",
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
    ]);
  }
}
