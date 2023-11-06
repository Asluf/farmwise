import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  Future<void> _openGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Use the picked image for profile editing or display.
      // You can save the image to your app's storage or use it directly.
      File imageFile = File(pickedImage.path);
      // Now, you can do something with the image, like displaying it or uploading it.
    } else {
      // User canceled image picking.
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> profileInfo = widget.profileInfo;
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
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHkAAAB5CAMAAAAqJH57AAAARVBMVEXb29tjY2Pe3t5eXl7h4eFbW1tXV1d1dXVmZmbk5OTMzMzU1NRycnKvr6+RkZHCwsKFhYVsbGyLi4u4uLimpqZ8fHybm5uAPwHBAAADmUlEQVRoge2aCXLkIAxFQQJs4329/1EHO8kkaXfbyPn01FT6X+CVhCSEkFIvvfTSS79MRGYTPRurfL00w9AstVfmeWDjm95Zy6usy5aSnmM5qcaxzvW7cm1d54snsI3XrG/Ebm6L1GBqd9yNbTuf+LzL/B54ZfOiUrrczHdN3mSrNp3ZNNpHNm8uT2d20T/mbmZnPgmaitYdk4PZIz7IydTVGTjILWi0GXt7zl09PmAdTk0cNxQ1LJq6WPBqdYNDm8Hqg3TaoSdUYlPtBNxVHkRWjwvXffGACXAzCQ75HQ0yupKCNS+Qk/YRBeRWPcLdVIudHUoZAKzMIg0wGLm5QIZ4+wqZu/+cfOGcuUFkVWiBxGQ7QS4Nf4FcY66rCzWshZBJHmJcIsCKLpRPCDigMym4ArWBNAqNxiTVKnPS4d8KlFRKbrQdYT2gySThzTOKuz6bJdXEYrJ5A1MxxBvNA+w1S17bJb7vtR42sqGOdRUf3jk72GNWWrhRF4ZSwnQGZpX4skK9bmgWgitYhAn7IVxaUSksnpi3zSrTiYwGlm1hE+hw1VPJ3M3AqVghmhnkmC7sjSy4MLTOcGBlJhbcGLBeSL2PtSPZtgM6O6B1Fdl1oyef5MvTceubHNTiFU1lnLN7/HidogoZrtX+VNxYDNj9faqMIbsUQ/0Yd/Oc4uMq5qWRxNlrUp+bnObjiM5jLM3fjTodN9s61V/ZSWKlyOUP0WHnXSXjruF95G/kvbwj3/8E/rAZfVlEk5FdkIyM+r24Tz6KMGS3KyTjOvw92R+RcX9ze7B5uGewnXNTJFktIePr5vglnXfLWOKvyZIt83Hrm+t1qQZtNkX2ntqiszr6dxKeWyb2aYWP8NghN4MXDR7v7ewEvixDgMWiLbZ8myX6HYubAG4iwTSuQ4bY8fV4o7zEGU3qYD1rB+YBNWcOFTsTTCu2FbkWsLAVuIM7Kdh7tqsm9bNtUCo27gVZ1/xgJ5LMODuhuV8Nn9trbKKx50v2/mXbuZUHG6kxu7DPccvmeZSxjaoDN7/q6O92x7OJyilyBS6K7bIxKslCGjVWtBB2Lled222ozq6l0Qm7r81BPaeiXBjn5u+yPD1a9ibTdlZarSRiXvydwmZCFv0seyNkddfesE05VTY1d9WaZF8CnRQyi87YX5LM1M/jbgrsLdaoc5BqJWJ3wexifq7Bb2JdKvlSJQY9i3+XYVLRvzIJyP9Iv5H8B9BYLFfSyOwbAAAAAElFTkSuQmCC',
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
