import 'package:flutter/material.dart';
import 'package:fancy/data/shop.dart';
import 'package:fancy/model/shop.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminReviewsScreen extends StatefulWidget {
  const AdminReviewsScreen({super.key});

  @override
  State<AdminReviewsScreen> createState() => _AdminReviewsScreenState();
}

class _AdminReviewsScreenState extends State<AdminReviewsScreen> {
  Map<int, int> getRatingDistribution(List<Product> products) {
    Map<int, int> distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var product in products) {
      if (product.reviews != null) {
        for (var review in product.reviews!) {
          int rating = review.rating.round();
          distribution[rating] = (distribution[rating] ?? 0) + 1;
        }
      }
    }
    return distribution;
  }

  Widget _buildReviewChart(Map<int, int> distribution) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}★');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups:
              distribution.entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.toDouble(),
                      color: Colors.amber,
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ProductData.getAllProducts();
    final ratingDistribution = getRatingDistribution(products);

    return Scaffold(
      appBar: AppBar(title: const Text('Product Reviews Overview')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Review Distribution',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _buildReviewChart(ratingDistribution),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        product.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[200],
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        Text(' ${product.rating}'),
                        const SizedBox(width: 16),
                        Text('${product.reviewCount} reviews'),
                      ],
                    ),
                    children: [
                      ...product.reviews!.map(
                        (review) => ListTile(
                          leading:
                              review.userImage != null &&
                                      review.userImage!.isNotEmpty
                                  ? CircleAvatar(
                                    backgroundImage: AssetImage(
                                      review.userImage!,
                                    ),
                                  )
                                  : const CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                          title: Row(
                            children: [
                              Text(review.userName),
                              const SizedBox(width: 8),
                              if (review.verified)
                                const Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  Text(' ${review.rating}'),
                                  const SizedBox(width: 8),
                                  Text(review.date.toString().split(' ')[0]),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(review.comment),
                              if (review.helpfulCount != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${review.helpfulCount} found this helpful',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
