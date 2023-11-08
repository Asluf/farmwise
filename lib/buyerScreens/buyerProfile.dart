import 'package:farmwise/buyerScreens/buyerDashboard.dart';
import 'package:farmwise/buyerScreens/buyerProfileEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class buyerProfile extends StatefulWidget {
  const buyerProfile({super.key});

  @override
  State<buyerProfile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buyerProfile> {
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
        Uri.parse('http://localhost:5005/api/getBuyer'),
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
            Navigator.pop(context, const buyerDashboard());
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
                            image: NetworkImage(
                                'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHkAAAB5CAMAAAAqJH57AAAARVBMVEXb29tjY2Pe3t5eXl7h4eFbW1tXV1d1dXVmZmbk5OTMzMzU1NRycnKvr6+RkZHCwsKFhYVsbGyLi4u4uLimpqZ8fHybm5uAPwHBAAADmUlEQVRoge2aCXLkIAxFQQJs4329/1EHO8kkaXfbyPn01FT6X+CVhCSEkFIvvfTSS79MRGYTPRurfL00w9AstVfmeWDjm95Zy6usy5aSnmM5qcaxzvW7cm1d54snsI3XrG/Ebm6L1GBqd9yNbTuf+LzL/B54ZfOiUrrczHdN3mSrNp3ZNNpHNm8uT2d20T/mbmZnPgmaitYdk4PZIz7IydTVGTjILWi0GXt7zl09PmAdTk0cNxQ1LJq6WPBqdYNDm8Hqg3TaoSdUYlPtBNxVHkRWjwvXffGACXAzCQ75HQ0yupKCNS+Qk/YRBeRWPcLdVIudHUoZAKzMIg0wGLm5QIZ4+wqZu/+cfOGcuUFkVWiBxGQ7QS4Nf4FcY66rCzWshZBJHmJcIsCKLpRPCDigMym4ArWBNAqNxiTVKnPS4d8KlFRKbrQdYT2gySThzTOKuz6bJdXEYrJ5A1MxxBvNA+w1S17bJb7vtR42sqGOdRUf3jk72GNWWrhRF4ZSwnQGZpX4skK9bmgWgitYhAn7IVxaUSksnpi3zSrTiYwGlm1hE+hw1VPJ3M3AqVghmhnkmC7sjSy4MLTOcGBlJhbcGLBeSL2PtSPZtgM6O6B1Fdl1oyef5MvTceubHNTiFU1lnLN7/HidogoZrtX+VNxYDNj9faqMIbsUQ/0Yd/Oc4uMq5qWRxNlrUp+bnObjiM5jLM3fjTodN9s61V/ZSWKlyOUP0WHnXSXjruF95G/kvbwj3/8E/rAZfVlEk5FdkIyM+r24Tz6KMGS3KyTjOvw92R+RcX9ze7B5uGewnXNTJFktIePr5vglnXfLWOKvyZIt83Hrm+t1qQZtNkX2ntqiszr6dxKeWyb2aYWP8NghN4MXDR7v7ewEvixDgMWiLbZ8myX6HYubAG4iwTSuQ4bY8fV4o7zEGU3qYD1rB+YBNWcOFTsTTCu2FbkWsLAVuIM7Kdh7tqsm9bNtUCo27gVZ1/xgJ5LMODuhuV8Nn9trbKKx50v2/mXbuZUHG6kxu7DPccvmeZSxjaoDN7/q6O92x7OJyilyBS6K7bIxKslCGjVWtBB2Lled222ozq6l0Qm7r81BPaeiXBjn5u+yPD1a9ibTdlZarSRiXvydwmZCFv0seyNkddfesE05VTY1d9WaZF8CnRQyi87YX5LM1M/jbgrsLdaoc5BqJWJ3wexifq7Bb2JdKvlSJQY9i3+XYVLRvzIJyP9Iv5H8B9BYLFfSyOwbAAAAAElFTkSuQmCC'))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            itemProfile(
                "Buyer Name",
                (profileInfo != null && profileInfo['data'] != null)
                    ? profileInfo['data']['buyer_name'] ?? ''
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
                    ? profileInfo['data']['mobile_number'] ?? ''
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
                      return buyerProfileEdit(profileInfo: profileInfo);
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
