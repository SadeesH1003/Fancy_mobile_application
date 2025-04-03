import 'package:fancy/model/order.dart';

class OrderData {
  // Get all orders
  static List<Order> getOrders() {
    return _orders;
  }

  // Get orders by status
  static List<Order> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  // Get order by ID
  static Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }

  static final List<Order> _orders = [
    Order(
      id: "FN45692",
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: "Processing",
      items: [
        OrderItem(
          name: "Floral Summer Dress",
          price: 3299.99,
          quantity: 1,
          imageUrl: "assets/summer.jpg",
          variant: "Size: M, Color: Blue",
        ),
        OrderItem(
          name: "Leather Handbag",
          price: 2499.99,
          quantity: 1,
          imageUrl:
              "assets/Willow-brown-leather-sling-bag-brown-model+(12).jpg",
        ),
      ],
      total: 5799.98,
    ),
    Order(
      id: "FN45680",
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: "Shipped",
      items: [
        OrderItem(
          name: "Casual T-Shirt",
          price: 1299.99,
          quantity: 2,
          imageUrl: "assets/premium_photo-1690349404224-53f94f20df8f.jpg",
          variant: "Size: L, Color: White",
        ),
      ],
      total: 2599.98,
    ),
    Order(
      id: "FN45623",
      date: DateTime.now().subtract(const Duration(days: 15)),
      status: "Delivered",
      items: [
        OrderItem(
          name: "Running Shoes",
          price: 4599.99,
          quantity: 1,
          imageUrl: "assets/shoes.jpg",
          variant: "Size: 42, Color: Green",
        ),
        OrderItem(
          name: "Sports Shorts",
          price: 1499.99,
          quantity: 1,
          imageUrl: "assets/shorts.jpg",
          variant: "Size: M, Color: Gray",
        ),
      ],
      total: 6099.98,
    ),
    Order(
      id: "FN45599",
      date: DateTime.now().subtract(const Duration(days: 30)),
      status: "Delivered",
      items: [
        OrderItem(
          name: "Winter Jacket",
          price: 5299.99,
          quantity: 1,
          imageUrl: "assets/brazo-latest-short-off-white-wom.jpg",
          variant: "Size: L, Color: White",
        ),
      ],
      total: 5299.99,
    ),
  ];
}
