// ignore_for_file: deprecated_member_use

import 'package:fancy/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductInfoSection extends StatefulWidget {
  final Product product;
  final int quantity;
  final Function(int) onQuantityChanged;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 165, 81, 139).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.product.category,
              style: GoogleFonts.marcellus(
                fontSize: 12,
                color: const Color.fromARGB(255, 165, 81, 139),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Product name
          Text(
            widget.product.name,
            style: GoogleFonts.marcellus(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Rating
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  i < widget.product.rating.floor()
                      ? Icons.star
                      : i < widget.product.rating
                      ? Icons.star_half
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                ),
              const SizedBox(width: 8),
              Text(
                '${widget.product.rating} (${widget.product.reviewCount} reviews)',
                style: GoogleFonts.marcellus(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Price
          Row(
            children: [
              Text(
                '\Rs.${widget.product.price.toStringAsFixed(2)}',
                style: GoogleFonts.marcellus(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              if (widget.product.originalPrice != null &&
                  widget.product.originalPrice! > widget.product.price)
                Text(
                  '\Rs.${widget.product.originalPrice!.toStringAsFixed(2)}',
                  style: GoogleFonts.marcellus(
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[500],
                  ),
                ),
            ],
          ),

          // Availability
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                widget.product.inStock ? Icons.check_circle : Icons.cancel,
                color:
                    widget.product.inStock
                        ? const Color.fromARGB(255, 165, 81, 139)
                        : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                widget.product.inStock ? 'In Stock' : 'Out of Stock',
                style: GoogleFonts.marcellus(
                  color:
                      widget.product.inStock
                          ? const Color.fromARGB(255, 165, 81, 139)
                          : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const Divider(height: 32),

          // Quantity selector
          Row(
            children: [
              Text(
                'Quantity',
                style: GoogleFonts.marcellus(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed:
                          widget.quantity > 1
                              ? () =>
                                  widget.onQuantityChanged(widget.quantity - 1)
                              : null,
                      color:
                          widget.quantity > 1
                              ? const Color.fromARGB(255, 165, 81, 139)
                              : Colors.grey,
                      iconSize: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        '${widget.quantity}',
                        style: GoogleFonts.marcellus(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed:
                          () => widget.onQuantityChanged(widget.quantity + 1),
                      color: const Color.fromARGB(255, 165, 81, 139),
                      iconSize: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Description header
          Text(
            'Description',
            style: GoogleFonts.marcellus(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            widget.product.description,
            style: GoogleFonts.marcellus(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Features header
          Text(
            'Features',
            style: GoogleFonts.marcellus(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Features list
          ...(widget.product.features ?? [])
              .map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color.fromARGB(255, 165, 81, 139),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: GoogleFonts.marcellus(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
