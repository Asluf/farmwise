import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../services/auth_services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:quickalert/quickalert.dart';
import 'dart:typed_data';

class createProductProposal extends StatefulWidget {
  createProductProposal({Key? key}) : super(key: key);
  @override
  State<createProductProposal> createState() => _createProductProposalState();
}

class _createProductProposalState extends State<createProductProposal> {
  final _formKey = GlobalKey<FormState>();

  String? productName;
  String? productDescription;
  String? quantity;
  String? unitPrice;
  String selectedDateText = "Produced Date";
  DateTime selectedDate = DateTime.now();
  String selectedDateText2 = "Expire Date";
  DateTime selectedDate2 = DateTime.now();
  String imgName = "Upload the image of the product";

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

  void _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
        selectedDateText2 = "${picked.month}/${picked.day}/${picked.year}";
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
      }
    } catch (e) {
      print("Error reading file: $e");
    }
  }

  //calling to api
  void createProductProposal() async {
    try {
      if (imageBytes != null) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:5005/api/createProductProposal'),
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
        request.fields['product_name'] = productName ?? '';
        request.fields['product_description'] = productDescription ?? '';
        request.fields['quantity'] = quantity ?? '';
        request.fields['unit_price'] = unitPrice ?? '';
        request.fields['produced_date'] = selectedDate.toString();
        request.fields['expire_date'] = selectedDate2.toString();

        try {
          final response = await request.send();
          String responseBody = await response.stream.bytesToString();

          if (response.statusCode == 200) {
            // Successfully uploaded, parse the response if needed
            print('Product proposal submission successfully.');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Product proposal submission successful!')));

            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/farmerDash', (route) => false);
            });
          } else {
            // Handle error
            print(
                'Failed to upload product proposal. Status code: ${response.statusCode}');
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

  late TextEditingController productNameController;
  late TextEditingController productDescrController;
  late TextEditingController productQtyController;
  late TextEditingController unitPriceController;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    productDescrController = TextEditingController();
    productQtyController = TextEditingController();
    unitPriceController = TextEditingController();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productDescrController.dispose();
    productQtyController.dispose();
    unitPriceController.dispose();
    super.dispose();
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
        title: Text('New Product Proposal'),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  productName = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: productDescrController,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description of the product';
                  }
                  return null;
                },
                onSaved: (value) {
                  productDescription = value;
                },
              ),
              SizedBox(height: 16.0),
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
              SizedBox(height: 16.0),
              TextFormField(
                controller: productQtyController,
                decoration: InputDecoration(
                  labelText: 'Quantity (Kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity of the product ';
                  }
                  return null;
                },
                onSaved: (value) {
                  quantity = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: unitPriceController,
                decoration: InputDecoration(
                  labelText: 'Unit Price (Rs)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the unit price';
                  }
                  return null;
                },
                onSaved: (value) {
                  unitPrice = value;
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
                        child: Text(selectedDateText2),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate2(context),
                        child: Icon(
                          Icons.today,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      (selectedDate != null)) {
                    _formKey.currentState!.save();
                    createProductProposal();
                  } else if (selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Date field cant be empty!')));
                  } else if (selectedDate2 == null) {
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
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
