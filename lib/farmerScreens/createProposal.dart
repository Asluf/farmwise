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
  String? acres;
  String? duration;
  String? experience;
  String selectedDateText = "mm/dd/yyyy";
  DateTime? selectedDate;
  DateTime today = DateTime.now();
  String imgName = "Upload the image of the land";

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
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

  final AuthService _authService = AuthService();
  String? token;
  String? email;
  Uint8List? imageBytes;
  final imagePicker = ImagePicker();

  Future<void> _openGallery() async {
    token = await _authService.getToken();
    email = await _authService.getEmail();

    try {
      if (kIsWeb) {
        // Perform web-specific file picking operations
        var newImageBytes = await ImagePickerWeb.getImageAsBytes();

        // Update the widget state inside a call to setState
        setState(() {
          imageBytes = newImageBytes;
          imgName = "Selected";
        });
      } else {
        print("for mobile");
        // final pickedImage =
        //     await imagePicker.pickImage(source: ImageSource.gallery);
        // if (pickedImage != null) {
        //   final imageFile = File(pickedImage.path);
        //   final imageBytes = await imageFile.readAsBytes();

        //   final request = http.MultipartRequest(
        //       'POST', Uri.parse('http://localhost:5005/api/createCultivationProposal'));

        //   request.headers['authorization'] = 'Bearer $token';
        //   request.headers['x-access-token'] = token ?? '';

        //   request.fields['email'] = email ?? '';

        //   // Create a `http.MultipartFile` object from the image bytes
        //   final multipartFile = http.MultipartFile.fromBytes(
        //     'image',
        //     imageBytes,
        //     filename: imageFile.path.split('/').last,
        //   );

        //   request.files.add(multipartFile);

        //   final response = await request.send();

        //   if (response.statusCode == 200) {
        //     // Image uploaded successfully
        //     print('Image uploaded successfully - $response');
        //   } else {
        //     // Handle the error, e.g., show an error message
        //     print('Image upload failed - - $response');
        //   }
        // } else {
        //   // User canceled image picking.
        //   print("nothing picked");
        // }
      }
    } catch (e) {
      print("Error reading file: $e");
    }
  }

  //calling to api
  void createProposal() async {
    try {
      if (imageBytes != null) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:5005/api/createCultivationProposal'),
        );

        // Attach the image file to the request
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes!.toList(),
            filename: 'image.png',
          ),
        );

        request.headers['authorization'] = 'Bearer $token';
        request.headers['x-access-token'] = token ?? '';

        request.fields['farmer_email'] = email ?? '';
        request.fields['crop_name'] = cropName ?? '';
        request.fields['crop_details'] = cropDetails ?? '';
        request.fields['duration'] = duration ?? '';
        request.fields['start_date'] = selectedDate.toString();
        request.fields['acres'] = acres ?? '';
        request.fields['total_amount'] = totalInvestment ?? '';
        request.fields['investment_of_farmer'] = farmerInvestment ?? '';
        request.fields['years_of_experience'] = experience ?? '';

        // Send the request
        try {
          final response = await request.send();
          String responseBody = await response.stream.bytesToString();

          if (response.statusCode == 200) {
            // Successfully uploaded, parse the response if needed
            print('Proposal submission successfully.');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Proposal submission successful!')));

            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/farmerDash', (route) => false);
            });
          } else {
            // Handle error
            print(
                'Failed to upload proposal. Status code: ${response.statusCode}');
            print('Response body: $responseBody');
            _showEditError();
          }
        } catch (error) {
          print('Error uploading image: $error');
          _showEditError();
        }
      } else {
        _showImgError();
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
      text: 'Proposal submission failed. Please try again later.',
      confirmBtnText: 'Try again',
      confirmBtnColor: Color.fromARGB(255, 67, 78, 68),
    );
  }

  void _showImgError() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Oops!",
      text: 'Should select a picture. Please try again later.',
      confirmBtnText: 'Try again',
      confirmBtnColor: Color.fromARGB(255, 67, 78, 68),
    );
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
              TextFormField(
                initialValue: totalInvestment,
                decoration: InputDecoration(
                  labelText: 'Acres:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  acres = value;
                },
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
              SizedBox(
                height: 50.0,
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
                        child: Text(imgName),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _openGallery,
                      ),
                    ],
                  ),
                ),
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
                decoration: InputDecoration(
                  labelText: 'Years of experience:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field cannot be left blank.";
                  }
                  return null;
                },
                onSaved: (value) {
                  experience = value;
                },
              ),
              SizedBox(height: 40),
              Container(
                width: 10,
                height: 45, // Set the desired width
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        (selectedDate != null)) {
                      _formKey.currentState!.save();
                      createProposal();
                    } else if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Date field cant be empty!')));
                    } else if (imageBytes == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please select a valid image!')));
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
