import 'package:farmwise/investorScreens/dashboardInvestor.dart';
import 'package:farmwise/investorScreens/profileEditInvestor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileInvestor extends StatefulWidget {
  const ProfileInvestor({super.key});

  @override
  State<ProfileInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileInvestor> {
  Map<String, dynamic> profileInfo = {};

  final AuthService _authService = AuthService();
  String email = '';
  String token = '';

  Future<void> fetchData() async {
    email = await _authService.getEmail();
    token = await _authService.getToken();

    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json',
      };
      final Map<String, dynamic> data = {"email": email};

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/getInvestor'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Process the data retrieved from the server
        setState(() {
          profileInfo = json.decode(response.body);
        });
      } else {
        // Handle any errors
        print('Failed to fetch data ${response.body}');
      }
    } catch (er) {
      print(er);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the profile page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, const DashboardInvestor());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("bgAppbar.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
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
                      border: Border.all(width: 2, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage((profileInfo != null &&
                                profileInfo['dpDetails'] != null &&
                                profileInfo['dpDetails']['profile_pic'] != '')
                            ? 'http://localhost:5005/${profileInfo['dpDetails']['profile_pic']}' ??
                                'http://localhost:5005/uploads/profilepic/a.png'
                            : 'http://localhost:5005/uploads/profilepic/a.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            itemProfile(
                "Investor Name",
                (profileInfo != null && profileInfo['data'] != null)
                    ? profileInfo['data']['investor_name'] ?? ''
                    : '',
                CupertinoIcons.person),
            SizedBox(height: 15),
            itemProfile(
                "Address",
                (profileInfo != null && profileInfo['data'] != null)
                    ? profileInfo['data']['address'] ?? ''
                    : '',
                CupertinoIcons.location),
            SizedBox(height: 15),
            itemProfile(
                "E-mail",
                (profileInfo != null && profileInfo['data'] != null)
                    ? profileInfo['data']['email'] ?? ''
                    : '',
                CupertinoIcons.mail),
            SizedBox(height: 15),
            itemProfile(
                "Phone",
                (profileInfo != null && profileInfo['data'] != null)
                    ? profileInfo['data']['mobile'] ?? ''
                    : '',
                CupertinoIcons.phone),
            SizedBox(height: 20),
            Container(
              width: 150,
              child: ElevatedButton(
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Color.fromARGB(255, 25, 25, 25),
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return ProfileEditInvestor(profileInfo: profileInfo);
                    }));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 192, 226, 190)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                  )),
            )
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
