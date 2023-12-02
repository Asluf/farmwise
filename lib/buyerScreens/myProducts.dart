import 'package:flutter/material.dart';

class Myproducts extends StatefulWidget {
  const Myproducts({super.key});

  @override
  State<Myproducts> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Myproducts> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            " Products",
            style: TextStyle(
              color: const Color.fromARGB(255, 4, 5, 4),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ])
      ],
    );
  }
}
