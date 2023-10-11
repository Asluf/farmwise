import 'package:farmwise/buyerScreens/Explore.dart';
import 'package:farmwise/buyerScreens/buyerOrder.dart';
import 'package:farmwise/buyerScreens/buyerProfile.dart';
import 'package:farmwise/buyerScreens/cartPage.dart';
import 'package:farmwise/mainScreens/homePage.dart';
import 'package:flutter/material.dart';

class buyerDashboard extends StatefulWidget {
  const buyerDashboard({super.key});

  @override
  State<buyerDashboard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buyerDashboard> {
  final pages = [const explorePage(), const cartPage(), const cartPage()];
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
                label: 'Cart',
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          icon: Icon(Icons.logout),
          buttonPadding: EdgeInsets.fromLTRB(0, 0, 30, 30),
          // title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout or cancel?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle logout action here
                // Im just redirect to homepage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 5, 46, 2)),
                elevation: MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 177, 24, 3)),
                elevation: MaterialStatePropertyAll(4),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Icon(
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