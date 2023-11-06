import 'package:farmwise/investorScreens/incomeInvestor.dart';
import 'package:farmwise/investorScreens/investmentInvestor.dart';
import 'package:farmwise/investorScreens/notificationInvestor.dart';
import 'package:farmwise/investorScreens/profileInvestor.dart';
import 'package:farmwise/mainScreens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'proposalInvestor.dart';

class DashboardInvestor extends StatefulWidget {
  const DashboardInvestor({super.key});

  @override
  State<DashboardInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DashboardInvestor> {
  final pages = [
    const ProposalInvestor(),
    const InvestmentInvestor(),
    const IncomeInvestor()
  ];
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
            IconButton.filledTonal(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationInvestor()),
                );
              },
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
              setState(() {
                currentIndex = index;
              });
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

//   void _showLogoutConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           alignment: Alignment.topCenter,
//           icon: Icon(Icons.logout),
//           buttonPadding: EdgeInsets.fromLTRB(0, 0, 30, 30),
//           // title: Text('Confirm Logout'),
//           content: Text('Are you sure you want to logout or cancel?'),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 // Handle logout action here
//                 // Im just redirect to homepage
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/logout', (route) => false);
//               },
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStatePropertyAll(Color.fromARGB(255, 5, 46, 2)),
//                 elevation: MaterialStatePropertyAll(4),
//                 shape: MaterialStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               ),
//               child: Icon(
//                 Icons.check,
//                 color: Colors.white,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStatePropertyAll(Color.fromARGB(255, 177, 24, 3)),
//                 elevation: MaterialStatePropertyAll(4),
//                 shape: MaterialStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               ),
//               child: Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
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
