import 'package:farmwise/farmerScreens/FarmerProfile.dart';
import 'package:farmwise/farmerScreens/myInvestment.dart';
import 'package:farmwise/farmerScreens/myIncome.dart';
import 'package:farmwise/farmerScreens/proposal.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class farmerDashboard extends StatefulWidget {
  const farmerDashboard({super.key});

  @override
  State<farmerDashboard> createState() => _farmerDashboardState();
}

// ignore: camel_case_types
class _farmerDashboardState extends State<farmerDashboard> {
  final pages = [const myInvestment(), const proposal(), const myIncome()];
  int currentIndex = 0;

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
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HI PERERA",
                style: TextStyle(
                    color: Color.fromARGB(255, 192, 226, 190),
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
                    color: Color.fromARGB(255, 192, 226, 190),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Montserrat'),
              ),
            ],
          ),
          actions: [
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(
                Icons.notification_add_outlined,
                color: Color.fromARGB(255, 192, 226, 190),
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              color: const Color.fromARGB(255, 192, 226, 190),
              onSelected: (value) {
                if (value == 'logout') {
                  _showLogoutConfirmationDialog(context);
                } else if (value == 'profile') {
                  // navigate to profile page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FarmerProfile(),
                      ));
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
            items: const [
              BottomNavigationBarItem(
                icon:
                    Icon(Icons.home, color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.home),
                label: 'myInvestment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart,
                    color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.shopping_cart),
                label: 'proposal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded,
                    color: Color.fromARGB(255, 107, 156, 104)),
                activeIcon: Icon(Icons.person_2_rounded),
                label: 'myIncome',
              ),
            ]));
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          icon: const Icon(Icons.logout),
          buttonPadding: const EdgeInsets.fromLTRB(0, 0, 30, 30),
          // title: Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout or cancel?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle logout action here
                // Im just redirect to homepage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const farmerDashboard()),
                );
              },
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
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
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
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
