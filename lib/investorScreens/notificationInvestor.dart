import 'package:farmwise/investorScreens/data/cultivationProposalList.dart';
import 'package:farmwise/investorScreens/paymentInvestor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/services/auth_services.dart';

class NotificationInvestor extends StatefulWidget {
  const NotificationInvestor({Key? key}) : super(key: key);

  @override
  State<NotificationInvestor> createState() => _NotificationInvestorState();
}

class _NotificationInvestorState extends State<NotificationInvestor> {
  final AuthService _authService = AuthService();
  String token = '';
  String email = '';
  List<ProposalDetails> fetchedAcceptedNotifications = [];

  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchRequestedProposal();
  }

  Future<String> fetchRequestedProposal() async {
    token = await _authService.getToken();
    email = await _authService.getEmail();
    try {
      final Map<String, dynamic> data = {"investor_email": email};
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // requested Notifications
      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getAcceptedNotification'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['data'];

        for (var proposalJson in proposalsJson) {
          ProposalDetails proposal = ProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedAcceptedNotifications.add(proposal);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
      }
    } catch (er) {
      print(er);
    }

    return "fetched";
  }

  void callPayRequest(String proposal_id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentInvestor(proposal_id: proposal_id)),
    );
  }

  void callCancelRequest(String proposal_id) {
    setState(() {
      futureData;
      futureData = cancelRequest(proposal_id);
    });
  }

  Future<String> cancelRequest(String proposal_id) async {
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      final Map<String, dynamic> data = {"proposal_id": proposal_id};
// this is in farmercontroller
      final response = await http.post(
        Uri.parse(
          "http://localhost:5005/api/rejectCultivationRequest",
        ),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proposal rejected successful!')));

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/investorDash', (route) => false);
        });
      } else {
        // print('Failed to fetch data ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch data. Try again!')));
      }
    } catch (er) {
      print(er);
    }
    // await Future.delayed(Duration(seconds: 1));
    return "done";
  }

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
        title: const Text("Notifications"),
      ),
      backgroundColor: Colors.grey[200],
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
            return Text('Error: ${snapshot.error}');
          } else {
            return Notifications(context);
          }
        },
      ),
    );
  }

  Widget Notifications(BuildContext context) {
    return Column(
      children: [
        // Requsting for accept or reject
        Container(
          child: Expanded(
            child: fetchedAcceptedNotifications.length > 0
                ? ListView.builder(
                    itemCount: fetchedAcceptedNotifications.length,
                    itemBuilder: (context, index) {
                      bool isAccepted = index.isEven;
                      return GestureDetector(
                        onTap: () {
                          print('Tapped index: $index');
                        },
                        child: NotificationCard(
                          crop_name:
                              fetchedAcceptedNotifications[index].crop_name,
                          date: 'Date',
                          time: 'Time',
                          index: index + 1,
                          onPay: () {
                            callPayRequest(fetchedAcceptedNotifications[index]
                                .proposal_id);
                          },
                          onCancel: () {
                            callCancelRequest(
                                fetchedAcceptedNotifications[index]
                                    .proposal_id);
                          },
                          onPressed: () {
                            print('Button in notification $index pressed.');
                          },
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Notifications",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        // Any other notofication
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String crop_name;
  final String date;
  final String time;
  final int index;
  final VoidCallback onPay;
  final VoidCallback onCancel;
  final VoidCallback onPressed;

  const NotificationCard({
    Key? key,
    required this.crop_name,
    required this.date,
    required this.time,
    required this.index,
    required this.onPay,
    required this.onCancel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.notification_add_rounded,
              size: 20,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Farmer is ready to accept the investment in his ${crop_name} proposal. Would you like to proceed now? ",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Spacer(),
                        // Text(
                        //   'Date: $date, Time: $time',
                        //   style: const TextStyle(fontSize: 14),
                        // ),
                        ElevatedButton(
                          onPressed: onPay,
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 5, 46, 2)),
                            elevation: const MaterialStatePropertyAll(4),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          child: const Text("Pay now"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: onCancel,
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 177, 24, 3)),
                            elevation: const MaterialStatePropertyAll(4),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
