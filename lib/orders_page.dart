import 'package:flutter/cupertino.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final bool isDark;

  const OrdersPage({
    super.key,
    required this.orders,
    required this.isDark,
  });

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, ${date.year} • ${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
  }

  String _formatDateShort(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _getStatusIcon(String status) {
    switch (status) {
      case 'Processing':
        return '⏳';
      case 'Shipped':
        return '🚚';
      case 'Delivered':
        return '✅';
      default:
        return '📦';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Color(0xFFFF9500);
      case 'Shipped':
        return Color(0xFF007AFF);
      case 'Delivered':
        return Color(0xFF34C759);
      default:
        return CupertinoColors.systemGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: isDark ? Color(0xFF000000) : CupertinoColors.white,
      child: Container(
        decoration: isDark
            ? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF1C1C1E),
              Color(0xFF000000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
            : null,
        child: SafeArea(
          child: orders.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '📦',
                  style: TextStyle(fontSize: 80),
                ),
                SizedBox(height: 20),
                Text(
                  'No Orders Yet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isDark ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your order history will appear here',
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey2,
                  ),
                ),
              ],
            ),
          )
              : CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: isDark
                              ? [CupertinoColors.white, Color(0xFFAAAAAA)]
                              : [CupertinoColors.black, Color(0xFF555555)],
                        ).createShader(bounds),
                        child: Text(
                          'MY ORDERS',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: CupertinoColors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${orders.length} ${orders.length == 1 ? 'order' : 'orders'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final order = orders[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: _buildOrderCard(context, order),
                    );
                  },
                  childCount: orders.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () => _showOrderDetails(context, order),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
            colors: [
              Color(0xFF1C1C1E),
              Color(0xFF2C2C2E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isDark ? null : CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isDark
              ? [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: Offset(0, 8),
            )
          ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['orderId'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? CupertinoColors.white : CupertinoColors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _formatDate(order['date']),
                      style: TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getStatusColor(order['status']),
                        _getStatusColor(order['status']).withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _getStatusIcon(order['status']),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(width: 4),
                      Text(
                        order['status'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CupertinoColors.systemGrey.withOpacity(0.2),
                    CupertinoColors.systemGrey.withOpacity(0.05),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Items Summary
            Text(
              '${order['items'].length} ${order['items'].length == 1 ? 'item' : 'items'}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 12),

            // Items Preview
            ...order['items'].take(2).map<Widget>((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: isDark
                            ? LinearGradient(
                          colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                        )
                            : null,
                        color: isDark ? null : CupertinoColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Image.network(
                          item['image'],
                          height: 40,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              CupertinoIcons.photo,
                              size: 25,
                              color: CupertinoColors.systemGrey,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? CupertinoColors.white : CupertinoColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Size ${item['selectedSize']} • ${item['selectedColor']} • Qty ${item['quantity']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            if (order['items'].length > 2)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  '+${order['items'].length - 2} more items',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),

            SizedBox(height: 16),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CupertinoColors.systemGrey.withOpacity(0.2),
                    CupertinoColors.systemGrey.withOpacity(0.05),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Total and Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₱${order['total']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: isDark ? CupertinoColors.white : CupertinoColors.black,
                      ),
                    ),
                  ],
                ),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoColors.systemGrey,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
            colors: [
              Color(0xFF1C1C1E),
              Color(0xFF2C2C2E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isDark ? null : CupertinoColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    // Header
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: isDark ? CupertinoColors.white : CupertinoColors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      order['orderId'],
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),

                    SizedBox(height: 24),

                    // Delivery Tracking
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getStatusColor(order['status']).withOpacity(0.2),
                            _getStatusColor(order['status']).withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _getStatusIcon(order['status']),
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order['status'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: _getStatusColor(order['status']),
                                    ),
                                  ),
                                  Text(
                                    'Expected: ${_formatDateShort(order['estimatedDelivery'])}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Tracking Number',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            order['trackingNumber'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isDark ? CupertinoColors.white : CupertinoColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Shipping Address
                    Text(
                      'SHIPPING ADDRESS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: isDark
                            ? LinearGradient(
                          colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                        )
                            : null,
                        color: isDark ? null : CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_fill,
                            color: Color(0xFF34C759),
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              order['shippingAddress'],
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? CupertinoColors.white : CupertinoColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Order Items
                    Text(
                      'ITEMS (${order['items'].length})',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    SizedBox(height: 12),

                    ...order['items'].map<Widget>((item) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: isDark
                              ? LinearGradient(
                            colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                          )
                              : null,
                          color: isDark ? null : CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: isDark
                                    ? LinearGradient(
                                  colors: [Color(0xFF3C3C3E), Color(0xFF4C4C4E)],
                                )
                                    : null,
                                color: isDark ? null : CupertinoColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Image.network(
                                  item['image'],
                                  height: 50,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      CupertinoIcons.photo,
                                      size: 30,
                                      color: CupertinoColors.systemGrey,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isDark ? CupertinoColors.white : CupertinoColors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Size ${item['selectedSize']} • ${item['selectedColor']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '₱${item['price']} × ${item['quantity']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? CupertinoColors.white : CupertinoColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    SizedBox(height: 24),

                    // Total
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: isDark
                            ? LinearGradient(
                          colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                        )
                            : null,
                        color: isDark ? null : CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          Text(
                            '₱${order['total']}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: isDark ? CupertinoColors.white : CupertinoColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}