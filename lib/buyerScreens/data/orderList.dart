import 'package:farmwise/buyerScreens/data/productList.dart';
import 'package:farmwise/buyerScreens/models/order.dart';
import 'package:farmwise/utils/enums/order.dart';

List<order> orderList = [
  order(
    id: "0001",
    products: productList.reversed.take(3).toList(),
    orderingDate: DateTime.utc(2023, 1, 1),
    deliveryDate: DateTime.utc(2023, 2, 1),
    status: OrderStatus.Completed,
  ),
  order(
    id: "0002",
    products: productList.reversed.take(3).skip(2).toList(),
    orderingDate: DateTime.utc(2023, 3, 3),
    deliveryDate: DateTime.utc(2023, 5, 2),
    status: OrderStatus.Completed,
  ),
  order(
    id: "0003",
    products: productList.reversed.skip(3).toList(),
    orderingDate: DateTime.utc(2023, 10, 1),
    deliveryDate: DateTime.utc(2023, 11, 1),
    status: OrderStatus.Requested,
  ),
  order(
    id: "0004",
    products: productList.reversed.skip(3).toList(),
    orderingDate: DateTime.utc(2023, 9, 1),
    deliveryDate: DateTime.utc(2023, 10, 8),
    status: OrderStatus.Picking,
  ),
  order(
    id: "0005",
    products: productList.reversed.take(4).toList(),
    orderingDate: DateTime.utc(2023, 10, 7),
    deliveryDate: DateTime.utc(2023, 11, 7),
    status: OrderStatus.Requested,
  ),
  order(
    id: "0006",
    products: productList.reversed.take(3).skip(1).toList(),
    orderingDate: DateTime.utc(2023, 10, 7),
    deliveryDate: DateTime.utc(2023, 11, 7),
    status: OrderStatus.Requested,
  ),
  order(
    id: "0007",
    products: productList.reversed.take(3).skip(1).toList(),
    orderingDate: DateTime.utc(2023, 10, 7),
    deliveryDate: DateTime.utc(2023, 11, 7),
    status: OrderStatus.Picking,
  ),
  order(
    id: "0008",
    products: productList.reversed.take(4).skip(2).toList(),
    orderingDate: DateTime.utc(2023, 10, 7),
    deliveryDate: DateTime.utc(2023, 11, 7),
    status: OrderStatus.Completed,
  )
];
