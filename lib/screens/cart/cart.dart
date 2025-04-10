import 'package:fancy/data/shop.dart';
import 'package:fancy/screens/cart/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ProductData.cartItems;
    final cartTotal = ProductData.cartTotal;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.marcellus(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.black),
              onPressed: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          'Clear Cart',
                          style: GoogleFonts.marcellus(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to remove all items from your cart?',
                          style: GoogleFonts.marcellus(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.marcellus(
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ProductData.clearCart();
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Text(
                              'Clear',
                              style: GoogleFonts.marcellus(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
            ),
        ],
      ),
      body:
          cartItems.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: GoogleFonts.marcellus(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Items you add to your cart will appear here',
                      style: GoogleFonts.marcellus(color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  // Cart items list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final product = item.product;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product image
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  product.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // Product details
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: GoogleFonts.marcellus(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Rs.${product.price.toStringAsFixed(2)}',
                                        style: GoogleFonts.marcellus(
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromARGB(
                                            255,
                                            165,
                                            81,
                                            139,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Quantity selector
                                      Row(
                                        children: [
                                          // Decrease button
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (item.quantity > 1) {
                                                  ProductData.updateCartItemQuantity(
                                                    product.id,
                                                    item.quantity - 1,
                                                  );
                                                } else {
                                                  ProductData.removeFromCart(
                                                    product.id,
                                                  );
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                size: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  165,
                                                  81,
                                                  139,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Quantity
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '${item.quantity}',
                                              style: GoogleFonts.marcellus(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          // Increase button
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                ProductData.updateCartItemQuantity(
                                                  product.id,
                                                  item.quantity + 1,
                                                );
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  165,
                                                  81,
                                                  139,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const Spacer(),

                                          // Remove button
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                ProductData.removeFromCart(
                                                  product.id,
                                                );
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Checkout section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Order summary
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total (${cartItems.length} items):',
                              style: GoogleFonts.marcellus(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Rs.${cartTotal.toStringAsFixed(2)}',
                              style: GoogleFonts.marcellus(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 165, 81, 139),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckoutPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              165,
                              81,
                              139,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: GoogleFonts.marcellus(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
    );
  }
}
