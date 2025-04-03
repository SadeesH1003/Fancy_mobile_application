class Order {
  final String id;
  final DateTime date;
  final String status;
  final List<OrderItem> items;
  final double total;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.total,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}

class OrderItem {
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String? variant;

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.variant,
  });
}
