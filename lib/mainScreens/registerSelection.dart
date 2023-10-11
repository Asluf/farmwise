import 'package:farmwise/mainScreens/registerBuyer.dart';
import 'package:farmwise/mainScreens/registerFarmer.dart';
import 'package:farmwise/mainScreens/registerInvestor.dart';
import 'package:flutter/material.dart';

class registerSelection extends StatefulWidget {
  const registerSelection({super.key});

  @override
  State<registerSelection> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<registerSelection> {
  @override
  Widget build(BuildContext context) {
    final double wid = MediaQuery.of(context).size.width;
    final double hei = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Select to Register"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, Placeholder());
              },
              icon: const Icon(Icons.arrow_back)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("bgAppbar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: Center(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, (hei / 14), 0, (hei / 14)),
              child: Text(
                "Register as",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 46, 2)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 192, 226, 190)),
                      elevation: const MaterialStatePropertyAll(4),
                      minimumSize:
                          MaterialStatePropertyAll(Size((wid / 2) - 30, 150)),
                      maximumSize:
                          MaterialStatePropertyAll(Size((wid / 2) - 30, 150)),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      shadowColor: MaterialStateProperty.all(Colors.green),
                      overlayColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 215, 226, 216)),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.green)),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return registerFarmer();
                      }));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.agriculture,
                          color: Colors.green,
                          size: 50,
                        ),
                        Text(
                          "Farmer",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 20, 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 192, 226, 190)),
                      elevation: const MaterialStatePropertyAll(4),
                      minimumSize:
                          MaterialStatePropertyAll(Size((wid / 2) - 30, 150)),
                      maximumSize:
                          MaterialStatePropertyAll(Size((wid / 2) - 30, 150)),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      shadowColor: MaterialStateProperty.all(Colors.blue),
                      overlayColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 215, 226, 216)),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.blue)),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return registerInvestor();
                      }));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          color: Colors.blue,
                          size: 50,
                        ),
                        Text(
                          "Investor",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 192, 226, 190)),
                elevation: const MaterialStatePropertyAll(4),
                minimumSize:
                    MaterialStatePropertyAll(Size((wid / 2) - 10, 150)),
                maximumSize:
                    MaterialStatePropertyAll(Size((wid / 2) - 10, 150)),
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 10)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                shadowColor: MaterialStateProperty.all(Colors.orange),
                overlayColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 215, 226, 216)),
                side:
                    MaterialStateProperty.all(BorderSide(color: Colors.orange)),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return registerBuyer();
                }));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.orange,
                    size: 50,
                  ),
                  Text(
                    "Buyer",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
