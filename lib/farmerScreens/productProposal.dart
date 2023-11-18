
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
  String? quantity;
  String? unit_price;
  String selectedDateText = "Produced Date"; 
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
  String selectedDateText2 = "Expire Date";
  DateTime selectedDate2 = DateTime.now();
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
                onSaved: (value){
                  product_name = value;
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
                onSaved: (value){
                  product_description = value;
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
                onSaved: (value){
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
                onSaved: (value){
                  unit_price = value;
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
                  if (_formKey.currentState!.validate()) {
                    String productName = productNameController.text;
                    String productDescr = productDescrController.text;
                    String productQty = productQtyController.text;
                    String unitPrice = unitPriceController.text;
                    print('Crop Name: $productName, Product Description: $productDescr, Quantity: $productQty, Unit Price: $unitPrice');
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
