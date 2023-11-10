import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FarmerProfileEdit extends StatefulWidget {
  final Map<String, dynamic> profileInfo;
  const FarmerProfileEdit({required this.profileInfo});

  @override
  _FarmerProfileEditState createState() => _FarmerProfileEditState();
}

class _FarmerProfileEditState extends State<FarmerProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  String? address;
  String? email;
  String? mobile;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> profileInfo = widget.profileInfo;
    Future<void> _openGallery() async {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        File imageFile = File(pickedImage.path);

        var request = http.MultipartRequest(
            'POST', Uri.parse('http://localhost:5005/api/'));
        // Add the email address as a form field
        request.fields['email'] = profileInfo['data']['email'];
        request.files.add(http.MultipartFile(
            'image', imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
            filename: imageFile.path.split("/").last));

        var response = await request.send();

        if (response.statusCode == 200) {
          // Image uploaded successfully
          print('Image uploaded successfully');
        } else {
          // Handle the error, e.g., show an error message
          print('Image upload failed');
        }
      } else {
        // User canceled image picking.
      }
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
                                  profileInfo['dpDetails'] != null)
                              ? 'http://localhost:5005/uploads/profilepic/${profileInfo['dpDetails']['profile_pic']}' ??
                                  'http://localhost:5005/uploads/profilepic/dp.png'
                              : 'http://localhost:5005/uploads/profilepic/dp.png'),
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
                  name = value;
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
                  name = value;
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
                  address = value;
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
