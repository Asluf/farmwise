import 'package:farmwise/buyerScreens/Explore.dart';
import 'package:farmwise/buyerScreens/buyerOrder.dart';
import 'package:farmwise/buyerScreens/buyerProfile.dart';
import 'package:farmwise/buyerScreens/data/ApprovedProductList.dart';
import 'package:farmwise/buyerScreens/myProducts.dart';
import 'package:farmwise/mainScreens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmwise/services/auth_services.dart';

class buyerDashboard extends StatefulWidget {
  const buyerDashboard({super.key});

  @override
  State<buyerDashboard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buyerDashboard> {
  final AuthService _authService = AuthService();
  String token = '';
  String email = '';
  // List<ProductProposalDetails> fetchedAcceptedNotifications = [];

  late Future<String> futureData;

  @override
  void initState() {
    super.initState();
    // futureData = fetchAcceptedProposal();
  }

  // Future<String> fetchAcceptedProposal() async {
  //   token = await _authService.getToken();
  //   email = await _authService.getEmail();
  //   try {
  //     final Map<String, dynamic> data = {"investor_email": email};
  //     final Map<String, String> headers = {
  //       'authorization': 'Bearer $token',
  //       'x-access-token': token,
  //       'Content-Type': 'application/json',
  //     };
  //     // requested Notifications
  //     final response = await http.post(
  //       Uri.parse('http://localhost:5005/api/getAcceptedNotification'),
  //       headers: headers,
  //       body: jsonEncode(data),
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonData = json.decode(response.body);
  //       List<dynamic> proposalsJson = jsonData['data'];

  //       for (var proposalJson in proposalsJson) {
  //         ProposalDetails proposal = ProposalDetails.fromJson(proposalJson);
  //         setState(() {
  //           fetchedAcceptedNotifications.add(proposal);
  //         });
  //       }
  //     } else {
  //       print('Failed to fetch data ${response.body}');
  //     }
  //   } catch (er) {
  //     print(er);
  //   }

  //   return "fetched";
  // }

  final pages = [const explorePage(), const Myproducts()];
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
                    color: const Color.fromARGB(255, 192, 226, 190),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Montserrat'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
              ),
              Text(
                "Enjoy our Services",
                style: TextStyle(
                    color: const Color.fromARGB(255, 192, 226, 190),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Montserrat'),
              ),
            ],
          ),
          actions: [
            IconButton.filledTonal(
              onPressed: () {},
              icon: Icon(
                Icons.notification_add_outlined,
                color: const Color.fromARGB(255, 192, 226, 190),
              ),
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
                    MaterialPageRoute(builder: (context) => buyerProfile()),
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
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon:
                    Icon(Icons.home, color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart,
                    color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.shopping_cart),
                label: 'My Products',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.shopping_bag,
              //       color: Color.fromARGB(255, 107, 156, 104)),
              //   activeIcon: Icon(Icons.shopping_bag),
              //   label: 'My orders',
              // ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    GestureDetector(
                        onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => buyerOrder()),
                              ),
                            },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 3),
                              child: Icon(Icons.shopping_bag,
                                  color: Color.fromARGB(255, 107, 156, 104)),
                            ),
                            Text(
                              'My orders',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 135, 142, 135),
                                  fontSize: 13),
                            ),
                          ],
                        ))
                  ],
                ),
                label: '',
              ),
            ]));
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
