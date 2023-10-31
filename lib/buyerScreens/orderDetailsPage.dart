import 'package:easy_stepper/easy_stepper.dart';
import 'package:farmwise/buyerScreens/buyerOrder.dart';
import 'package:farmwise/buyerScreens/models/order.dart';
import 'package:farmwise/buyerScreens/widgets/orderItem.dart';
import 'package:farmwise/utils/enums/order.dart';
import 'package:farmwise/utils/extensions/date.dart';
import 'package:flutter/material.dart';

class orderDetailsPage extends StatelessWidget {
  const orderDetailsPage({super.key, required this.Order});
  final order Order;

  @override
  Widget build(BuildContext context) {
    const steps = OrderStatus.values;
    final activeStep = steps.indexOf(Order.status);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(
              color: const Color.fromARGB(255, 192, 226, 190),
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, buyerOrder());
          },
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 192, 226, 190)),
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          EasyStepper(
            activeStep:
                activeStep == steps.length - 1 ? activeStep + 1 : activeStep,
            stepRadius: 10,
            activeStepTextColor: Colors.black87,
            finishedStepTextColor: Theme.of(context).colorScheme.primary,
            lineStyle: LineStyle(
                defaultLineColor: Colors.grey.shade300,
                lineLength:
                    (MediaQuery.of(context).size.width * 0.7) / steps.length),
            steps: List.generate(steps.length, (index) {
              return EasyStep(
                icon: Icon(
                  Icons.local_shipping,
                  color: Colors.green.shade400,
                ),
                finishIcon: const Icon(Icons.done),
                title: steps[index].name,
                //topTitle: true,
              );
            }),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            clipBehavior: Clip.antiAlias, //clip the edges
            elevation: 0.1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                width: 0.2,
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //order id
                  Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order: ${Order.id}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Chip(
                          label: Text(
                            steps[activeStep].name,
                            style: TextStyle(
                                color: Colors.green.shade500,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: StadiumBorder(),
                          side: BorderSide.none,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.4),
                          labelPadding: EdgeInsets.zero,
                          avatar: Icon(
                            Icons.fire_truck,
                            size: 15,
                            color: Colors.green.shade600,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Estimate"),
                      Text(
                        Order.deliveryDate.formatDate,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Mr. Perera",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.home,
                        size: 15,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                      Expanded(child: Text("90, Flower Street, Colombo"))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.call,
                        size: 15,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                      Expanded(child: Text("0774678903"))
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Text("Payment Method"),
                      const Spacer(),
                      Text(
                        "Credit card ******78",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  //order status as chip
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          OrderItem(
            Order: Order,
            visibleProducts: 1,
          )
        ],
      ),
    );
  }
}
