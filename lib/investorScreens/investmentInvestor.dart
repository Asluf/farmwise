import 'package:farmwise/investorScreens/data/cultivationProposalList.dart';
import 'package:farmwise/investorScreens/widgets/investmentCard.dart';
import 'package:flutter/material.dart';
import 'package:farmwise/investorScreens/data/proposalList.dart';
import '../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvestmentInvestor extends StatefulWidget {
  const InvestmentInvestor({super.key});

  @override
  State<InvestmentInvestor> createState() => _InvestmentInvestor();
}

class _InvestmentInvestor extends State<InvestmentInvestor> {
  final AuthService _authService = AuthService();
  String email = '';
  String token = '';
  List<ProposalDetails> fetchedOngoingProposals = [];
  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchOngoingData();
  }

  Future<String> fetchOngoingData() async {
    email = await _authService.getEmail();
    token = await _authService.getToken();

    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // ongoing data
      final Map<String, dynamic> data = {"email": email};
      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getOngoingCultivation'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['proposalDetails'];
        for (var proposalJson in proposalsJson) {
          ProposalDetails proposal = ProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedOngoingProposals.add(proposal);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
      }
    } catch (er) {
      print(er);
    }
    return "done";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.green.shade600),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Ongoing(context);
          }
        },
      ),
    );
  }

  Widget Ongoing(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                      style: const TextStyle(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: fetchedOngoingProposals.length,
                      itemBuilder: (BuildContext context, int index) {
                        // returning the cart
                        return InvestmentCard(
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
            ],
          ),
        ),
      ],
    );
  }
}
