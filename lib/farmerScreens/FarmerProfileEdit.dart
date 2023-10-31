import 'package:flutter/material.dart';

class FarmerProfileEdit extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
          title: Text('My Profile'),
          leading: IconButton(
            onPressed: () {
              
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
                          color: Colors.green.shade400,
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

              // Profile fields
              SizedBox(height: 20),
              TextFormField(
                initialValue: name,
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
                initialValue: name,
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
                initialValue: address,
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
                initialValue: email,
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
                initialValue: mobile,
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
