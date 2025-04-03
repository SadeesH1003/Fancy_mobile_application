import 'package:fancy/model/order.dart';
import 'package:fancy/widgets/my_orders/order_tracking_dialog.dart';
import 'package:fancy/widgets/my_orders/return_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (order.status) {
      case "Processing":
        statusColor = Colors.black;
        break;
      case "Shipped":
        statusColor = const Color.fromARGB(255, 85, 52, 175);
        break;
      case "Delivered":
        statusColor = const Color.fromARGB(255, 49, 114, 52);
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order header with ID and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order #${order.id}",
                  style: GoogleFonts.marcellus(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: GoogleFonts.marcellus(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Order date
            Text(
              "Placed on ${DateFormat('MMM dd, yyyy').format(order.date)}",
              style: GoogleFonts.marcellus(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),

            const Divider(height: 24),

            // First item preview (simplified)
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    order.items[0].imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported_outlined),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.items[0].name,
                        style: GoogleFonts.marcellus(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (order.items.length > 1)
                        Text(
                          "+ ${order.items.length - 1} more items",
                          style: GoogleFonts.marcellus(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      Text(
                        "Rs. ${order.total.toStringAsFixed(2)}",
                        style: GoogleFonts.marcellus(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 165, 81, 139),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action buttons - track order or return
            if (order.status == "Processing" || order.status == "Shipped")
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Show tracking info
                    _showTrackingInfo(context, order);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 165, 81, 139),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Track Order",
                    style: GoogleFonts.marcellus(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            if (order.status == "Delivered")
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Show return dialog
                    _showReturnDialog(context, order);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 165, 81, 139),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    "Return Items",
                    style: GoogleFonts.marcellus(
                      color: const Color.fromARGB(255, 165, 81, 139),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showTrackingInfo(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => OrderTrackingDialog(order: order),
    );
  }

  void _showReturnDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => ReturnDialog(order: order),
    );
  }
}
