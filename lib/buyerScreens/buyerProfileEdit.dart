import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../services/auth_services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:quickalert/quickalert.dart';

import 'dart:typed_data';
import 'dart:convert';

class buyerProfileEdit extends StatefulWidget {
  final Map<String, dynamic> profileInfo;
  const buyerProfileEdit({required this.profileInfo});

  @override
  State<buyerProfileEdit> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buyerProfileEdit> {
  String? name;
  String? address;
  String? email;
  String? mobile;

  final AuthService _authService = AuthService();
  String token = '';

  void editBuyer() async {
    token = await _authService.getToken();
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json'
      };
      final Map<String, dynamic> data = {
        "buyer_name": name,
        "address": address,
        "mobile_number": mobile,
        "email": email
      };

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/editBuyer'),
        headers: headers,
        body: jsonEncode(data),
      );
      //saving the response
      if (response.statusCode == 200) {
        // Request was successful
        print('Profile edited successfully');
        print(response.body);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Profile edit successful!')));

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/buyerDash', (route) => false);
        });
      } else {
        // Request failed
        print('Failed to send POST request');
        _showEditError();
      }
    } catch (er) {
      print(er);
    }
  }

  void _showEditError() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Oops!",
      text: 'Profile edit failed. Please try again later.',
      confirmBtnText: 'Try again',
      confirmBtnColor: Color.fromARGB(255, 67, 78, 68),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> profileInfo = widget.profileInfo;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController(
        text: (profileInfo['data'] != null)
            ? profileInfo['data']['buyer_name'] ?? ''
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
            ? profileInfo['data']['mobile_number'] ?? ''
            : '');

    Future<void> _openGallery() async {
      token = await _authService.getToken();

      try {
        if (kIsWeb) {
          Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();

          if (imageBytes != null) {
            var request = http.MultipartRequest(
              'POST',
              Uri.parse('http://localhost:5005/api/uploadDp'),
            );

            // Attach the image file to the request
            request.files.add(
              http.MultipartFile.fromBytes(
                'image',
                imageBytes.toList(),
                filename: 'image.png',
              ),
            );

            request.headers['authorization'] = 'Bearer $token';
            request.headers['x-access-token'] = token;

            // Add the email address as a form field
            request.fields['email'] = profileInfo['data']['email'];

            // Send the request
            try {
              final response = await request.send();

              if (response.statusCode == 200) {
                // Successfully uploaded, parse the response if needed
                String imagePath = await response.stream.bytesToString();
                print('Image uploaded successfully. Image path: $imagePath');
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile photo updated!')));

                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/buyerDash', (route) => false);
                });
              } else {
                // Handle error
                print('Failed to upload image. Status code: ${response}');
              }
            } catch (error) {
              print('Error uploading image: $error');
            }
          }
        } else {
          final imagePicker = ImagePicker();
          final pickedImage =
              await imagePicker.pickImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            final imageFile = File(pickedImage.path);
            final imageBytes = await imageFile.readAsBytes();
            // Rest of your code for non-web platforms

            final request = http.MultipartRequest(
                'POST', Uri.parse('http://localhost:5005/api/uploadDp'));

            // Add headers to the request
            request.headers['authorization'] = 'Bearer $token';
            request.headers['x-access-token'] = token;

            // Add the email address as a form field
            request.fields['email'] = profileInfo['data']['email'];

            // Create a `http.MultipartFile` object from the image bytes
            final multipartFile = http.MultipartFile.fromBytes(
              'image',
              imageBytes,
              filename: imageFile.path.split('/').last,
            );

            request.files.add(multipartFile);

            final response = await request.send();

            if (response.statusCode == 200) {
              // Image uploaded successfully
              print('Image uploaded successfully - $response');
            } else {
              // Handle the error, e.g., show an error message
              print('Image upload failed - - $response');
            }
          } else {
            // User canceled image picking.
            print("nothing picked");
          }
        }
      } catch (e) {
        print("Error reading file: $e");
      }
    }

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
                            image: NetworkImage((profileInfo != null &&
                                    profileInfo['dpDetails'] != null &&
                                    profileInfo['dpDetails']['profile_pic'] !=
                                        '')
                                ? 'http://localhost:5005/${profileInfo['dpDetails']['profile_pic']}' ??
                                    'http://localhost:5005/uploads/profilepic/a.png'
                                : 'http://localhost:5005/uploads/profilepic/a.png'),
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
                            onPressed: _openGallery,
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
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      name = value;
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
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      address = value;
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
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more complex email validation here.
                      return null;
                    },
                    onSaved: (value) {
                      email = value;
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
                      if (value!.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      // You can add more complex email validation here.
                      return null;
                    },
                    onSaved: (value) {
                      mobile = value;
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
                          editBuyer();
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
            // style: ButtonStyle(
            //   backgroundColor:
            //       MaterialStatePropertyAll(Color.fromARGB(255, 96, 174, 91)),
            //   elevation: MaterialStatePropertyAll(4),
            //   shape: MaterialStatePropertyAll(
            //     RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   ),
            // ),
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
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => buyerProfile()));
            },
            // style: ButtonStyle(
            //   backgroundColor:
            //       MaterialStatePropertyAll(Color.fromARGB(255, 96, 174, 91)),
            //   elevation: MaterialStatePropertyAll(4),
            //   shape: MaterialStatePropertyAll(
            //     RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   ),
            // ),
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
