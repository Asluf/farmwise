import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../services/auth_services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:quickalert/quickalert.dart';
import 'dart:typed_data';


class CreateProposal extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<CreateProposal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? cropName;
  String? cropDetails;
  String? totalInvestment;
  String? farmerInvestment;
  String? district;
  String? city;
  String? province;
  String? acres;
  String? duration;
  String selectedDateText = "mm/dd/yyyy";
  DateTime selectedDate = DateTime.now();
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateText = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Proposal'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: cropName,
                decoration: InputDecoration(
                  labelText: 'Crop Name:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  cropName = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                initialValue: cropDetails,
                decoration: InputDecoration(
                  labelText: 'Crop Details:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  cropDetails = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                height: 50,
                child: Container(

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(selectedDateText),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Icon(
                          Icons.today,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                initialValue: duration,
                decoration: InputDecoration(
                  labelText: 'Duration:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  duration = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),

              TextFormField(
                initialValue: province,
                decoration: InputDecoration(
                  labelText: 'Province:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  province = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                initialValue: district,
                decoration: InputDecoration(
                  labelText: 'District:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  district = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                initialValue: city,
                decoration: InputDecoration(
                  labelText: 'City:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  city = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                height: 50.0,
                child: Container(
// Upload image
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),

                        child: Text("Upload the image of the land"),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                initialValue: farmerInvestment,
                decoration: InputDecoration(
                  labelText: 'Investment of Farmer:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  farmerInvestment = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(

                initialValue: totalInvestment,
                decoration: InputDecoration(
                  labelText: 'Total investment:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  totalInvestment = value;
                },
              ),
              SizedBox(height: 40),
              Container(
                width: 10,
                height: 45, // Set the desired width
                child: ElevatedButton(
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Submit Proposal"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
