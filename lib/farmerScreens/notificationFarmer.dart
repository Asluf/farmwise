import 'package:farmwise/farmerScreens/data/cultivationProposalList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/services/auth_services.dart';

class NotificationFarmer extends StatefulWidget {
  const NotificationFarmer({Key? key}) : super(key: key);

  @override
  State<NotificationFarmer> createState() => _NotificationFarmerState();
}

class _NotificationFarmerState extends State<NotificationFarmer> {
  final AuthService _authService = AuthService();
  String token = '';
  String email = '';
  List<ProposalDetails> fetchedRequestedNotifications = [];

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
      final Map<String, dynamic> data = {"farmer_email": email};
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      // requested Notifications
      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getRequestedNotification'),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> proposalsJson = jsonData['data'];

        for (var proposalJson in proposalsJson) {
          ProposalDetails proposal = ProposalDetails.fromJson(proposalJson);
          setState(() {
            fetchedRequestedNotifications.add(proposal);
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

  void callAcceptRequest(String proposal_id) {
    setState(() {
      futureData;
      futureData = acceptRequest(proposal_id);
    });
  }

  Future<String> acceptRequest(String proposal_id) async {
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      final Map<String, dynamic> data = {"proposal_id": proposal_id};

      final response = await http.post(
        Uri.parse(
          "http://localhost:5005/api/acceptCultivationRequest",
        ),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proposal accepted successful!')));

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/farmerDash', (route) => false);
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

  void callRejectRequest(String proposal_id) {
    setState(() {
      futureData;
      futureData = rejectRequest(proposal_id);
    });
  }

  Future<String> rejectRequest(String proposal_id) async {
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      final Map<String, dynamic> data = {"proposal_id": proposal_id};

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
              context, '/farmerDash', (route) => false);
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
            child: fetchedRequestedNotifications.length > 0
                ? ListView.builder(
                    itemCount: fetchedRequestedNotifications.length,
                    itemBuilder: (context, index) {
                      bool isAccepted = index.isEven;
                      return GestureDetector(
                        onTap: () {
                          print('Tapped index: $index');
                        },
                        child: NotificationCard(
                          crop_name:
                              fetchedRequestedNotifications[index].crop_name,
                          date: 'Date',
                          time: 'Time',
                          index: index + 1,
                          onAccept: () {
                            callAcceptRequest(
                                fetchedRequestedNotifications[index]
                                    .proposal_id);
                          },
                          onReject: () {
                            callRejectRequest(
                                fetchedRequestedNotifications[index]
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
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onPressed;

  const NotificationCard({
    Key? key,
    required this.crop_name,
    required this.date,
    required this.time,
    required this.index,
    required this.onAccept,
    required this.onReject,
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
                    "Investor is willing to invest in your ${crop_name} proposal. Would you like to proceed now? ",
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
                          onPressed: onAccept,
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
                          child: const Text("Accept"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: onReject,
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
                          child: const Text("Reject"),
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
