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

class FarmerProfileEdit extends StatefulWidget {
  final Map<String, dynamic> profileInfo;
  const FarmerProfileEdit({required this.profileInfo});

  @override
  _FarmerProfileEditState createState() => _FarmerProfileEditState();
}

class _FarmerProfileEditState extends State<FarmerProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? farmer_name;
  String? farm_name;
  String? farmer_address;
  String? email;
  String? mobile;

  final AuthService _authService = AuthService();
  String token = '';

  void editFarmer() async {
    token = await _authService.getToken();
    try {
      final Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'x-access-token': token,
        'Content-Type': 'application/json'
      };
      final Map<String, dynamic> data = {
        "farmer_name": farmer_name,
        "farm_name": farm_name,
        "farmer_address": farmer_address,
        "mobile_number": mobile,
        "email": email
      };

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/editFarmer'),
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
              context, '/farmerDash', (route) => false);
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

    Future<void> _openGallery() async {
      token = await _authService.getToken();

      try {
        if (kIsWeb) {
          // Perform web-specific file picking operations
          // Image? imageBytes = await ImagePickerWeb.getImageAsWidget();
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
                      context, '/farmerDash', (route) => false);
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

      // final imageBytes = await imageFile.readAsBytes();
      // print('hello');
      // final request = http.MultipartRequest(
      //     'POST', Uri.parse('http://localhost:5005/api/uploadDp'));

      // // Add headers to the request
      // request.headers['authorization'] = 'Bearer $token';
      // request.headers['x-access-token'] = token;

      // // Add the email address as a form field
      // request.fields['email'] = profileInfo['data']['email'];

      // // Create a `http.MultipartFile` object from the image bytes
      // final multipartFile = http.MultipartFile.fromBytes(
      //   'image',
      //   imageBytes,
      //   filename: imageFile.path.split('/').last,
      // );

      // request.files.add(multipartFile);

      // final response = await request.send();

      // if (response.statusCode == 200) {
      //   // Image uploaded successfully
      //   print('Image uploaded successfully - $response');
      // } else {
      //   // Handle the error, e.g., show an error message
      //   print('Image upload failed - - $response');
      // }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile picture and edit button
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
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage((profileInfo != null &&
                                  profileInfo['dpDetails'] != null &&
                                  profileInfo['dpDetails']['profile_pic'] != '')
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
                          color: Colors.green.shade400,
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

              // Profile fields
              SizedBox(height: 20),
              TextFormField(
                initialValue:
                    (profileInfo != null && profileInfo['data'] != null)
                        ? profileInfo['data']['farmer_name'] ?? ''
                        : '',
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name cannot be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  farmer_name = value;
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                initialValue:
                    (profileInfo != null && profileInfo['data'] != null)
                        ? profileInfo['data']['farm_name'] ?? ''
                        : '',
                decoration: InputDecoration(
                  labelText: 'Farm Name',
                  hintText: 'Enter your farm name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Farm Name cannot be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  farm_name = value;
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                initialValue:
                    (profileInfo != null && profileInfo['data'] != null)
                        ? profileInfo['data']['farmer_address'] ?? ''
                        : '',
                maxLength: 100,
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address cannot be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  farmer_address = value;
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                initialValue:
                    (profileInfo != null && profileInfo['data'] != null)
                        ? profileInfo['data']['email'] ?? ''
                        : '',
                readOnly: true,
                maxLength: 100,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                initialValue:
                    (profileInfo != null && profileInfo['data'] != null)
                        ? profileInfo['data']['mobile_number'] ?? ''
                        : '',
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a mobile number";
                  }
                  return null;
                },
                onSaved: (value) {
                  mobile = value;
                },
              ),

              // Save button
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    editFarmer();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade300,
                ),
                child: Text("UPDATE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
