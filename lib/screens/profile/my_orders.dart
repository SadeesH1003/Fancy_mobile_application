import 'package:fancy/data/order.dart';
import 'package:fancy/model/order.dart';
import 'package:fancy/widgets/my_orders/empty_orders_view.dart';
import 'package:fancy/widgets/my_orders/order_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Order> _orders = OrderData.getOrders();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Orders",
          style: GoogleFonts.marcellus(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color.fromARGB(255, 165, 81, 139),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color.fromARGB(255, 165, 81, 139),
          labelStyle: GoogleFonts.marcellus(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.marcellus(),
          tabs: const [
            Tab(text: "All"),
            Tab(text: "In Progress"),
            Tab(text: "Delivered"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(_orders),
          _buildOrdersList(
            _orders
                .where(
                  (order) =>
                      order.status == "Processing" || order.status == "Shipped",
                )
                .toList(),
          ),
          _buildOrdersList(
            _orders.where((order) => order.status == "Delivered").toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders) {
    if (orders.isEmpty) {
      return const EmptyOrdersView();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(order: order);
      },
    );
  }
}
