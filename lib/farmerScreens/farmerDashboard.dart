import 'package:farmwise/farmerScreens/FarmerProfile.dart';
import 'package:farmwise/farmerScreens/data/cultivationProposalList.dart';
import 'package:farmwise/farmerScreens/myInvestment.dart';
import 'package:farmwise/farmerScreens/myIncome.dart';
import 'package:farmwise/farmerScreens/notificationFarmer.dart';
import 'package:farmwise/farmerScreens/productProposal.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/services/auth_services.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
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

  final pages = [
    const myInvestment(),
    const ProductProposal(),
    const myIncome()
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
              "HI PERERA",
              style: TextStyle(
                color: Color.fromARGB(255, 192, 226, 190),
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Montserrat',
              ),
            ),
            // Use SizedBox to add space between the two Text widgets
            SizedBox(height: 5.0),
            Text(
              "Enjoy our Services",
              style: TextStyle(
                color: Color.fromARGB(255, 192, 226, 190),
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Montserrat',
              ),
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
                          builder: (context) => NotificationFarmer()),
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

          // ================================
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: const Color.fromARGB(255, 192, 226, 190),
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutConfirmationDialog(context);
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FarmerProfile()),
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
                      Icons.person,
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
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 107, 156, 104),
            ),
            activeIcon: Icon(Icons.home),
            label: 'My Investment',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 107, 156, 104),
            ),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 107, 156, 104),
            ),
            activeIcon: Icon(Icons.person),
            label: 'My Income',
          ),
        ],
      ),
    );
  }

  Widget NotificationsCount(BuildContext context) {
    return Container(
      child: fetchedRequestedNotifications.isNotEmpty
          ? Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationFarmer()),
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
                    fetchedRequestedNotifications.length.toString(),
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
                  MaterialPageRoute(builder: (context) => NotificationFarmer()),
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
        confirmBtnColor: const Color.fromARGB(255, 67, 78, 68),
        onConfirmBtnTap: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, '/logout', (route) => false);
        });
  }
}
