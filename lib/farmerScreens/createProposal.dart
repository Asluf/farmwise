import 'dart:typed_data';

import 'package:farmwise/farmerScreens/farmerDashboard.dart';
import 'package:flutter/material.dart';




class CreateProposal extends StatefulWidget {
  CreateProposal({Key? key}) : super(key: key);

  @override
  State<CreateProposal> createState() => _CreateProposalState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

}

class _CreateProposalState extends State<CreateProposal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final cropTypes = ['Select the type of crop', 'Grains', 'Vegetables', 'Fruits'];
  String crType = 'Select the type of crop';

  final crops = ['Select the crop', 'Carrot','Beetroot', 'Rice', 'Leeks', 'Papaw', 'Orange', 'Mango', 'Onion', 'Chili '];
  String crp = 'Select the crop';

  final monthsDuration = ['Select the duration Month', '3 Months', '4 Months', '5 Months', '6 Months', '7 Months' ];
  String duration = 'Select the duration Month';

  final province = ['Province', 'Central', 'Eastern', 'North Central', 'Northern', 'North Western','Sabaragamuwa', 'Southern', 'Uva', 'Western'];
  String prov = 'Province';

  final district = ['District', 'Colombo', 'Gampaha', 'Kaluthara'];
  String dist = 'District';

  final city = ['City',];
  String cty = 'City';

  final acres = ['Acres', '2', '3', '4','5'];
  String acr = 'Acres';

  final costPerAcres = ['Cost per Acre'];
  String cost = 'Cost per Acre';

  final kgPerAcre = ['Kg per Acre'];
  String kgAcre = 'Kg per Acre';

  final marketPrice = ['Market price/Kg'];
  String marPrice = 'Market price/Kg';

  final wholesalePrice = ['Wholesale price/Kg'];
  String wholePrice = 'Wholesale price/Kg';

  final farmerInvestment = ['Investment of Farmer'];
  String farmerInvest = 'Investment of Farmer';


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

  void calculateROI() {}

  String? totalInvestment;
  String? investedByInvestors;
  String? roi;
  String? roiAmount;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(  //type of crop
              decoration: BoxDecoration(                                 
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white70 // Border radius
              ),
              
              child: DropdownButton<String?>(
                
                items: cropTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                      child: Text(value),
                    ),
                  );
                }).toList(),
                value: crType,
                onChanged: (String? value) {
                  onDropDownChanged1(value);
                },
      
                underline: Container(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
      
            Container(  //crop        
              decoration: BoxDecoration(                   
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white70 // Border radius
              ),
          
              child: DropdownButton<String?>(
                items: crops.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                      child: Text(value),
                    ),
                  );
                }).toList(),
                value: crp,
                onChanged: (String? value) {
                  onDropDownChanged2(value);
                },
      
            underline: Container(),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
            ),
                                                              
            SizedBox(
              height: 50,
              child: Container( //date
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
                      child:Text(selectedDateText),
                    ),
      
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Icon(
                      Icons.today,
                      size: 40,
                  ),
                  )
                ],
              ),
            ),
            ),
         
            Padding(
              padding: EdgeInsets.all(10),
            ),

            Container(  //month duration        
              decoration: BoxDecoration(                   
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white70 // Border radius
              ),
          
              child: DropdownButton<String?>(
                items: monthsDuration.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                      child: Text(value),
                    ),
                  );
                }).toList(),
                value: duration,
                onChanged: (String? value) {
                  onDropDownChanged3(value);
                },
      
            underline: Container(),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
            ),

            Row(
              children: [
                Container(  //province        
                  decoration: BoxDecoration(                   
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),
          
                  child: DropdownButton<String?>(
                    items: province.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                      }).toList(),
                      value: prov,
                      onChanged: (String? value) {
                        onDropDownChanged4(value);
                      },
      
                      underline: Container(),
                        ),
                      ),  
            
                SizedBox(width: 10),
                Container(  //district       
                  decoration: BoxDecoration(                                       
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),
          
                  child: DropdownButton<String?>(
                    items: district.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    value: dist,
                    onChanged: (String? value) {
                      onDropDownChanged5(value);
                    },
              
                    underline: Container(),
                      ),
                    ),            
              ],
            ),

            Padding(
              padding: EdgeInsets.all(10),
            ),

            SizedBox(width: 10,),
            Container(  //city       
              decoration: BoxDecoration(                   
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white70,                 
              ),
          
              child: DropdownButton<String?>(
                
                items: city.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                      child: Text(value),
                    ),
                  );
                }).toList(),
                value: cty,
                onChanged: (String? value) {
                  onDropDownChanged6(value);
                },
      
                underline: Container(),
                  ),
                ),

            Padding(
              padding: EdgeInsets.all(10),
            ),

            SizedBox(
              height: 50.0,
              child: Container( //upload image
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
                    child:Text("Upload the image of the land"),
                  ),      
                ],
              ),
            ),
            ),

            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  "INVESTMENT DETAILS",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ),

              Row(
              children: [
                Container(  //acres       
                  decoration: BoxDecoration(                   
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),

                  child: DropdownButton<String?>(                
                    items: acres.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    value: acr,
                    onChanged: (String? value) {
                      onDropDownChanged7(value);
                    },      
                    underline: Container(),
                  ),
                ),

                SizedBox(width: 10),
                Container(  //acres cost        
                  decoration: BoxDecoration(                   
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),

                  child: DropdownButton<String?>(                
                    items: costPerAcres.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    value: cost,
                    onChanged: (String? value) {
                      onDropDownChanged8(value);
                    },      
                    underline: Container(),
                  ),
                ),
              ]
              ),

              Padding(
              padding: EdgeInsets.all(10),
              ),
              Container(  //kg per acre         
                  decoration: BoxDecoration(                   
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),

                  child: DropdownButton<String?>(                
                    items: kgPerAcre.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    value: kgAcre,
                    onChanged: (String? value) {
                      onDropDownChanged9(value);
                    },      
                    underline: Container(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  ),

                Container(  //marker price/kg         
                  decoration: BoxDecoration(                   
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),

                  child: DropdownButton<String?>(                
                    items: marketPrice.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    value: marPrice,
                    onChanged: (String? value) {
                      onDropDownChanged10(value);
                    },      
                    underline: Container(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  ),

                Container(  //wholosale price/kg         
                  decoration: BoxDecoration(                   
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),

                  child: DropdownButton<String?>(                
                    items: wholesalePrice.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    value: wholePrice,
                    onChanged: (String? value) {
                      onDropDownChanged11(value);
                    },      
                    underline: Container(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  ),

                Container(  //investment of farmer        
                  decoration: BoxDecoration(                   
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white70 // Border radius
                  ),

                  child: DropdownButton<String?>(                
                    items: farmerInvestment.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0), // Add some padding for the text
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    value: farmerInvest,
                    onChanged: (String? value) {
                      onDropDownChanged12(value);
                    },      
                    underline: Container(),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                ElevatedButton(
                  
                  onPressed: () {
                    calculateROI();
                  }, 
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                                        
                  child: Text("Calculate ROI"),
                ),

                SizedBox(height: 20),
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

                SizedBox(height: 20),
                TextFormField(
                  initialValue: investedByInvestors,
                  decoration: InputDecoration(
                    labelText: 'Invested by investors:',                    
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

                SizedBox(height: 20),
                TextFormField(
                  initialValue: roi,
                  decoration: InputDecoration(
                    labelText: 'ROI:',                    
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

                SizedBox(height: 20),
                TextFormField(
                  initialValue: roiAmount,
                  decoration: InputDecoration(
                    labelText: 'ROI in Amount:',                    
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

                ElevatedButton(
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
          ]
        )
      ),
    );
  }

  void onDropDownChanged1(String? value) {
  if (value != null) {
    setState(() {
      this.crType = value;      
    });
  }
}

  void onDropDownChanged2(String? value) {
  if (value != null) {
    setState(() {      
      this.crp = value;
    });
  }
}

  void onDropDownChanged3(String? value) {
  if (value != null) {
    setState(() {      
      this.duration = value;
    });
  }
}

  void onDropDownChanged4(String? value) {
  if (value != null) {
    setState(() {      
      this.prov = value;
    });
  }
}

  void onDropDownChanged5(String? value) {
  if (value != null) {
    setState(() {      
      this.dist = value;
    });
  }
}

  void onDropDownChanged6(String? value) {
  if (value != null) {
    setState(() {      
      this.cty = value;
    });
  }
} 

  void onDropDownChanged7(String? value) {
  if (value != null) {
    setState(() {      
      this.acr = value;
    });
  }
}

  void onDropDownChanged8(String? value) {
  if (value != null) {
    setState(() {      
      this.cost = value;
    });
  }
}

  void onDropDownChanged9(String? value) {
  if (value != null) {
    setState(() {      
      this.kgAcre = value;
    });
  }
}

  void onDropDownChanged10(String? value) {
  if (value != null) {
    setState(() {      
      this.marPrice = value;
    });
  }
}

  void onDropDownChanged11(String? value) {
  if (value != null) {
    setState(() {      
      this.wholePrice = value;
    });
  }
}

  void onDropDownChanged12(String? value) {
  if (value != null) {
    setState(() {      
      this.farmerInvest = value;
    });
  }
}
}
