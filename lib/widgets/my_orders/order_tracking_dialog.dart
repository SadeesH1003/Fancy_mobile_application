import 'package:fancy/model/order.dart';
import 'package:fancy/widgets/my_orders/tracking_step.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderTrackingDialog extends StatelessWidget {
  final Order order;

  const OrderTrackingDialog({super.key, required this.order});

  List<Map<String, dynamic>> _getTimelineEntries() {
    // Define all possible statuses in order
    final allStatuses = ['Order Placed', 'Processing', 'Shipped', 'Delivered'];

    // Find the current status index
    int currentStatusIndex;
    switch (order.status) {
      case 'Processing':
        currentStatusIndex = 1;
        break;
      case 'Shipped':
        currentStatusIndex = 2;
        break;
      case 'Delivered':
        currentStatusIndex = 3;
        break;
      default:
        currentStatusIndex = 0; // Default to Order Placed
    }

    // Create timeline entries with appropriate descriptions
    return [
      {
        'title': 'Order Placed',
        'description': 'We have received your order',
        'isFirst': true,
        'isLast': false,
        'isCompleted': currentStatusIndex >= 0,
        'isActive': currentStatusIndex == 0,
      },
      {
        'title': 'Order Confirmed',
        'description': 'We have confirmed your order',
        'isFirst': false,
        'isLast': false,
        'isCompleted': currentStatusIndex >= 1,
        'isActive': currentStatusIndex == 1,
      },
      {
        'title': 'Order Shipped',
        'description': 'We have shipped your order',
        'isFirst': false,
        'isLast': false,
        'isCompleted': currentStatusIndex >= 2,
        'isActive': currentStatusIndex == 2,
      },
      {
        'title': 'Delivered',
        'description': 'Order has been delivered',
        'isFirst': false,
        'isLast': true,
        'isCompleted': currentStatusIndex >= 3,
        'isActive': currentStatusIndex == 3,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final timelineEntries = _getTimelineEntries();

    return Center(
      child: Container(
        height: 450,
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: timelineEntries.length,
              itemBuilder: (context, index) {
                final entry = timelineEntries[index];
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: entry['isFirst'] as bool,
                  isLast: entry['isLast'] as bool,
                  indicatorStyle: IndicatorStyle(
                    width: 30,
                    color:
                        entry['isCompleted']
                            ? Colors.purple.shade500
                            : Colors.grey.shade300,
                    iconStyle: IconStyle(
                      iconData:
                          entry['isCompleted']
                              ? Icons.check
                              : Icons.circle_outlined,
                      color:
                          entry['isActive']
                              ? Colors.white
                              : (entry['isCompleted']
                                  ? Colors.white
                                  : Colors.grey.shade500),
                    ),
                  ),
                  beforeLineStyle: LineStyle(
                    color: getLineColor(index, timelineEntries),
                    thickness: 3,
                  ),
                  afterLineStyle: LineStyle(
                    color: getLineColor(index + 1, timelineEntries),
                    thickness: 3,
                  ),
                  endChild: _buildTimelineCard(
                    title: entry['title'] as String,
                    description: entry['description'] as String,
                    isActive: entry['isActive'] as bool,
                    isCompleted: entry['isCompleted'] as bool,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Color getLineColor(int index, List<Map<String, dynamic>> entries) {
    if (index < 0 || index >= entries.length) {
      return Colors.grey.shade300;
    }
    return entries[index]['isCompleted']
        ? Colors.purple.shade500
        : Colors.grey.shade300;
  }
}

Widget _buildTimelineCard({
  required String title,
  required String description,
  required bool isActive,
  required bool isCompleted,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      constraints: const BoxConstraints(minHeight: 40),
      decoration: BoxDecoration(
        color:
            isActive
                ? Colors.purple.withOpacity(0.1)
                : Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.purple.shade300 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.marcellus(
                        fontWeight: FontWeight.bold,
                        color:
                            isActive ? Colors.purple.shade700 : Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                    if (isActive)
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade500,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Current',
                          style: GoogleFonts.marcellus(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.marcellus(
                    color: isActive ? Colors.purple.shade700 : Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
