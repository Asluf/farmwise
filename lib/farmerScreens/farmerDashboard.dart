import 'package:farmwise/farmerScreens/FarmerProfile.dart';
import 'package:farmwise/farmerScreens/myInvestment.dart';
import 'package:farmwise/farmerScreens/myIncome.dart';
import 'package:farmwise/farmerScreens/notificationFarmer.dart';
import 'package:farmwise/farmerScreens/productProposal.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
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
        title: Column(
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
          IconButton(
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
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            color: Color.fromARGB(255, 192, 226, 190),
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutConfirmationDialog(context);
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerProfile()),
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
