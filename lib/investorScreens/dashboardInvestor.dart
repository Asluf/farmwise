import 'package:farmwise/investorScreens/incomeInvestor.dart';
import 'package:farmwise/investorScreens/data/cultivationProposalList.dart';

import 'package:farmwise/investorScreens/investmentInvestor.dart';
import 'package:farmwise/investorScreens/notificationInvestor.dart';
import 'package:farmwise/investorScreens/profileInvestor.dart';
import 'package:farmwise/investorScreens/incomeInvestor.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'proposalInvestor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/services/auth_services.dart';

class DashboardInvestor extends StatefulWidget {
  const DashboardInvestor({super.key});

  @override
  State<DashboardInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DashboardInvestor> {
  final AuthService _authService = AuthService();
  String token = '';
  String email = '';
  List<ProposalDetails> fetchedAcceptedNotifications = [];

  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchAcceptedProposal();
  }

  Future<String> fetchAcceptedProposal() async {
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

  final pages = [
    const ProposalInvestor(),
    const InvestmentInvestor(),
    const incomeInvestor(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("bgAppbar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HI INVESTOR",
                style: TextStyle(
                    color: const Color.fromARGB(255, 192, 226, 190),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Montserrat'),
              ),
            ],
          ),
          actions: [
            FutureBuilder<String>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // If the Future is still running, display a loading spinner or an animation
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationInvestor()),
                      );
                    },
                    icon: Icon(
                      Icons.notifications, // Change to the appropriate icon
                      color: Colors.white, // Change the icon color
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return NotificationsCount(context);
                }
              },
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              color: Color.fromARGB(255, 192, 226, 190),
              onSelected: (value) {
                if (value == 'logout') {
                  _showLogoutConfirmationDialog(context);
                } else if (value == 'profile') {
                  // navigate to profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileInvestor()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    height: 50,
                    value: 'profile',
                    child: ListTile(
                      leading: Icon(
                        Icons.person_2_outlined,
                        color: Color.fromARGB(255, 5, 46, 2),
                      ),
                      title: Text('Profile'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Color.fromARGB(255, 5, 46, 2),
                      ),
                      title: Text('Logout'),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => incomeInvestor()),
                );
              } else {
                setState(() {
                  currentIndex = index;
                });
              }
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded,
                    color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Proposal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.browse_gallery_rounded,
                    color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.browse_gallery),
                label: 'My Investment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_rounded,
                    color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.attach_money),
                label: 'Income',
              ),
            ]));
  }

  Widget NotificationsCount(BuildContext context) {
    return Container(
      child: fetchedAcceptedNotifications.isNotEmpty
          ? Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationInvestor()),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    fetchedAcceptedNotifications.length.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          : IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationInvestor()),
                );
              },
              icon: Icon(
                Icons.notifications, // Change to the appropriate icon
                color: Colors.white, // Change the icon color
              ),
            ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        text: 'Do you want to logout',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        confirmBtnColor: Color.fromARGB(255, 67, 78, 68),
        onConfirmBtnTap: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, '/logout', (route) => false);
        });
  }
}
