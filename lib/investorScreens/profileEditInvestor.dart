import 'package:farmwise/investorScreens/dashboardInvestor.dart';
import 'package:farmwise/investorScreens/profileInvestor.dart';
import 'package:flutter/material.dart';

class ProfileEditInvestor extends StatefulWidget {
  final Map<String, dynamic> profileInfo;
  const ProfileEditInvestor({required this.profileInfo});

  @override
  State<ProfileEditInvestor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileEditInvestor> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> profileInfo = widget.profileInfo;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController(
        text: (profileInfo['data'] != null)
            ? profileInfo['data']['investor_name'] ?? ''
            : '');
    TextEditingController _addressController = TextEditingController(
        text: (profileInfo['data'] != null)
            ? profileInfo['data']['address'] ?? ''
            : '');
    TextEditingController _emailController = TextEditingController(
        text: (profileInfo['data'] != null)
            ? profileInfo['data']['email'] ?? ''
            : '');
    TextEditingController _mobileController = TextEditingController(
        text: (profileInfo['data'] != null)
            ? profileInfo['data']['mobile'] ?? ''
            : '');

    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
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
                "Edit Profile",
                style: TextStyle(
                    color: const Color.fromARGB(255, 192, 226, 190),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Montserrat'),
              ),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              color: Color.fromARGB(255, 192, 226, 190),
              onSelected: (value) {
                if (value == 'exit') {
                  _showExitConfirmationDialog(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'exit',
                    child: Text(
                      'Exit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile picture and edit button
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://png.pngtree.com/png-vector/20191110/ourmid/pngtree-avatar-icon-profile-icon-member-login-vector-isolated-png-image_1978396.jpg',
                            ),
                          ),
                        ),
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
                            color: Color.fromARGB(255, 62, 170, 97),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add_a_photo),
                            color: Colors.white,
                            onPressed: () {
                              // Implement the logic to change the profile picture here.
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      prefixIcon: Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more complex email validation here.
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      // You can add more complex email validation here.
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 50.0),
                Container(
                  width: 100,
                  height: 45,
                  child: ElevatedButton(
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: Color.fromARGB(255, 25, 25, 25),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('valid form');
                          _formKey.currentState!.save();
                        } else {
                          print('not valid form');
                          return;
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 192, 226, 190)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showExitConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //backgroundColor: Color.fromARGB(255, 192, 226, 190),
        title: Text(
          'Exit Confirmation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Do you want to exit without saving changes?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 51, 125, 45)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Leave',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 208, 48, 20)),
            ),
          ),
        ],
      );
    },
  );
}
