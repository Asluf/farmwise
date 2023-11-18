import 'package:farmwise/buyerScreens/models/product.dart';
import 'package:flutter/material.dart';

class produtProposal extends StatefulWidget {
  produtProposal({Key? key}) : super(key: key);

  @override
  State<produtProposal> createState() => _productProposalState();
}

class _productProposalState extends State<produtProposal> {
  final _formKey = GlobalKey<FormState>(); 
  String? product_name;
  String? product_description;
  String? unit_price;

  late TextEditingController cropNameController;
  late TextEditingController unitPriceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    cropNameController = TextEditingController();
    unitPriceController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    cropNameController.dispose();
    unitPriceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
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
                controller: cropNameController,
                decoration: InputDecoration(
                  labelText: 'Crop Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the crop name';
                  }
                  return null;
                },
                onSaved: (value){
                  product_name = value;
                },
              ),

              SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
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
                onSaved: (value){
                  product_description = value;
                },
              ),

              SizedBox(height: 16.0),
              TextFormField(
                controller: unitPriceController,
                decoration: InputDecoration(
                  labelText: 'Unit price (Rs)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
                onSaved: (value){
                  unit_price = value;
                },
              ),

              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String cropName = cropNameController.text;
                    String description = descriptionController.text;
                    String unitPrice = unitPriceController.text;
                    print('Crop Name: $cropName, Unit Price: $unitPrice, Product Description: $description');
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
