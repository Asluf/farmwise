import 'package:farmwise/buyerScreens/buyerProfile.dart';
import 'package:farmwise/buyerScreens/data/orderList.dart';
import 'package:farmwise/buyerScreens/models/order.dart';
import 'package:farmwise/buyerScreens/widgets/orderItem.dart';
import 'package:farmwise/mainScreens/homePage.dart';
import 'package:farmwise/utils/enums/order.dart';
import 'package:flutter/material.dart';

class buyerOrder extends StatefulWidget {
  const buyerOrder({super.key});

  @override
  State<buyerOrder> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buyerOrder> {
  @override
  Widget build(BuildContext context) {
    final tabs = OrderStatus.values.map((e) => e.name).toList();
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  indicatorColor: Colors.green.shade600,
                  tabs: List.generate(tabs.length, (index) {
                    return Tab(
                      text: tabs[index],
                    );
                  })),
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
                    "My Orders ",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 192, 226, 190),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Montserrat'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
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
            body: Theme(
              data: ThemeData(primaryColor: Colors.green.shade600),
              child: TabBarView(
                children: List.generate(tabs.length, (index) {
                  final filteredOrders = orderList
                      .where(
                          (order) => order.status == OrderStatus.values[index])
                      .toList();
                  return ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return OrderItem(
                          Order: order,
                          visibleProducts: 3, //doubt
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: filteredOrders.length);
                }),
              ),
            )));
  }
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
              Navigator.pushNamedAndRemoveUntil(
                  context, '/logout', (route) => false);
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
