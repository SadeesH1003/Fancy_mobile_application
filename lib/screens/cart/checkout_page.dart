import 'package:fancy/data/shop.dart';
import 'package:fancy/main.dart';
import 'package:fancy/model/delivery_options.dart';
import 'package:fancy/notifications/notifications.dart';
import 'package:fancy/providers/user_provider.dart';
import 'package:fancy/services/stripe_services.dart';
import 'package:fancy/widgets/cart/checkout_bottom_bar.dart';
import 'package:fancy/widgets/cart/delivery_options.dart';
import 'package:fancy/widgets/cart/order_summery.dart';
import 'package:fancy/widgets/cart/payment_method.dart';
import 'package:fancy/widgets/section_tile.dart';
import 'package:fancy/widgets/cart/shipping_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _paymentMethods = ['Credit Card', 'Cash on Delivery'];
  String _selectedPaymentMethod = 'Credit Card';

  final List<DeliveryOption> _deliveryOptions = [
    DeliveryOption(
      id: 'standard',
      name: 'Standard Delivery',
      price: 350.0,
      description: '3-5 business days',
    ),
    DeliveryOption(
      id: 'express',
      name: 'Express Delivery',
      price: 650.0,
      description: '1-2 business days',
    ),
  ];
  DeliveryOption? _selectedDeliveryOption;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _termsAccepted = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _selectedDeliveryOption = _deliveryOptions.first;

    final userProvider = context.read<UserProvider>();

    _nameController.text = userProvider.user!.username;
    _phoneController.text = userProvider.user!.contactNumber;
    _addressController.text = '123 Main Street, Apartment 4B';
    _cityController.text = 'Colombo';
    _postalCodeController.text = '00100';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  double get _subtotal => ProductData.cartTotal;
  double get _deliveryFee => _selectedDeliveryOption?.price ?? 0;
  double get _total => _subtotal + _deliveryFee;

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedPaymentMethod == 'Credit Card') {
      final user = context.read<UserProvider>();
      user.toggleLoading();
      await StripeService.instance.makePayment(user.user!.username);
      user.toggleLoading();
      _showOrderSuccessDialog();
    } else {
      setState(() {
        _isProcessing = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isProcessing = false;
        });

        _showOrderSuccessDialog();
      });
    }
  }

  Future<void> _showOrderSuccessDialog() async {
    try {
      await Notifications().showNotification(
        title: 'Fancy: Order Confirmation',
        body:
            '${_nameController.text}, your order has been placed successfully! Thank you for shopping with Fancy!',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send notification: $e')),
        );
      }
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Order Placed!',
                  style: GoogleFonts.marcellus(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your order has been placed successfully.',
                  style: GoogleFonts.marcellus(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Order #: FN${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
                  style: GoogleFonts.marcellus(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                Text(
                  'Thank you for shopping with Fancy!',
                  style: GoogleFonts.marcellus(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ProductData.clearCart();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Continue Shopping',
                  style: GoogleFonts.marcellus(
                    color: const Color.fromARGB(255, 165, 81, 139),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ProductData.cartItems;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.marcellus(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          _isProcessing
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 165, 81, 139),
                    ),
                    SizedBox(height: 16),
                    Text('Processing your order...'),
                  ],
                ),
              )
              : Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Main scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Order summary
                            const SectionTitle(title: 'Order Summary'),
                            OrderSummary(
                              cartItems: cartItems,
                              subtotal: _subtotal,
                              deliveryFee: _deliveryFee,
                              total: _total,
                            ),

                            const SizedBox(height: 24),

                            // Shipping information
                            const SectionTitle(title: 'Shipping Information'),
                            ShippingInformationForm(
                              nameController: _nameController,
                              phoneController: _phoneController,
                              addressController: _addressController,
                              cityController: _cityController,
                              postalCodeController: _postalCodeController,
                            ),

                            const SizedBox(height: 24),

                            // Delivery options
                            const SectionTitle(title: 'Delivery Options'),
                            DeliveryOptionsSelector(
                              deliveryOptions: _deliveryOptions,
                              selectedDeliveryOption: _selectedDeliveryOption,
                              onChanged: (option) {
                                setState(() {
                                  _selectedDeliveryOption = option;
                                });
                              },
                            ),

                            const SizedBox(height: 24),

                            // Payment method
                            const SectionTitle(title: 'Payment Method'),
                            PaymentMethodSelector(
                              paymentMethods: _paymentMethods,
                              selectedPaymentMethod: _selectedPaymentMethod,
                              onChanged: (method) {
                                if (method != null) {
                                  setState(() {
                                    _selectedPaymentMethod = method;
                                  });
                                }
                              },
                            ),

                            const SizedBox(height: 24),

                            // Terms and conditions
                            CheckboxListTile(
                              value: _termsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _termsAccepted = value!;
                                });
                              },
                              title: Text(
                                'I agree to the Terms and Conditions',
                                style: GoogleFonts.marcellus(),
                              ),
                              activeColor: const Color.fromARGB(
                                255,
                                165,
                                81,
                                139,
                              ),
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              dense: true,
                            ),

                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // Bottom payment bar
                    CheckoutBottomBar(
                      total: _total,
                      onPayPressed: _processPayment,
                    ),
                  ],
                ),
              ),
    );
  }
}
