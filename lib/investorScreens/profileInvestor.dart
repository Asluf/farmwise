import 'package:farmwise/investorScreens/dashboardInvestor.dart';
import 'package:farmwise/investorScreens/profileEditInvestor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileInvestor extends StatefulWidget {
  const ProfileInvestor({super.key});

  @override
  State<ProfileInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileInvestor> {
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
              "My Profile",
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
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add_outlined,
              color: Color.fromARGB(255, 192, 226, 190),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: Color.fromARGB(255, 192, 226, 190),
            onSelected: (value) {
              if (value == 'edit profile') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const ProfileEditInvestor();
                }));
              }
              ;
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'edit profile',
                  child: ListTile(
                    leading: Icon(
                      Icons.person_2_outlined,
                      color: Color.fromARGB(255, 5, 46, 2),
                    ),
                    title: Text('Edit profile'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 40, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://png.pngtree.com/png-vector/20191110/ourmid/pngtree-avatar-icon-profile-icon-member-login-vector-isolated-png-image_1978396.jpg'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.white),
                        color: Colors.green.shade400,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      //padding: EdgeInsets.only(top: 20),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 50),
            itemProfile("Full Name", "ABC", CupertinoIcons.person),
            SizedBox(height: 15),
            itemProfile("Address", "ABC", CupertinoIcons.location),
            SizedBox(height: 15),
            itemProfile("E-mail", "ABC@", CupertinoIcons.mail),
            SizedBox(height: 15),
            itemProfile("Phone", "123456789", CupertinoIcons.phone),
            SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.green.shade300,
              spreadRadius: 2,
              blurRadius: 10,
            )
          ],
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData),
        ));
  }
}
