import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(int) onRemoveItem;
  final Function(int, int) onUpdateQuantity;
  final Function() onClearCart;
  final Function(List<Map<String, dynamic>>, int) onOrderPlaced;
  final bool isDark;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
    required this.onUpdateQuantity,
    required this.onClearCart,
    required this.onOrderPlaced,
    required this.isDark,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String key = "xnd_development_hv67wthoiNF1QBFXlyauMn4Oy63vVL37nkXAAmWpeoVgHel1tep0QNiFRa1m21uP";
  Timer? _pollingTimer;
  bool _orderPlaced = false; // Flag to prevent duplicate orders

  int get totalAmount {
    return widget.cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int));
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> payNow(int price) async {
    // Reset the order placed flag when starting a new payment
    _orderPlaced = false;

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Loading Payment"),
          content: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );

    final url = "https://api.xendit.co/v2/invoices";
    String auth = 'Basic ' + base64Encode(utf8.encode('$key:'));

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": auth,
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "external_id": "invoice" + DateTime.now().millisecondsSinceEpoch.toString(),
          "amount": price
        }),
      );

      final data = jsonDecode(response.body);
      String id = data["id"];
      print(data["invoice_url"]);

      // Close loading dialog
      Navigator.pop(context);

      // Navigate to payment page
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => PaymentPage(
            url: data["invoice_url"],
            isDark: widget.isDark,
          ),
        ),
      );

      // Start polling for payment status
      paymentPolling(id, auth);
    } catch (e) {
      Navigator.pop(context);
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Error'),
          content: Text('Failed to create payment. Please try again.'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  Future<void> paymentPolling(String id, String auth) async {
    // Cancel any existing timer
    _pollingTimer?.cancel();

    _pollingTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      final url = "https://api.xendit.co/v2/invoices/" + id;

      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {"Authorization": auth},
        );

        final data = jsonDecode(response.body);
        print(data['status']);

        if (data["status"] == "PAID" && !_orderPlaced) {
          // Set flag to prevent duplicate orders
          _orderPlaced = true;

          // Cancel timer immediately
          timer.cancel();
          _pollingTimer?.cancel();

          // Create a deep copy of cart items before clearing
          final orderItems = widget.cartItems.map((item) => Map<String, dynamic>.from(item)).toList();
          final orderTotal = totalAmount;

          // Add to order history
          widget.onOrderPlaced(orderItems, orderTotal);

          // Clear cart after successful payment
          widget.onClearCart();

          // Close payment page if still open
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          // Show success message
          if (mounted) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Text('Payment Successful! 🎉'),
                content: Text('Your order has been placed and will be delivered soon.'),
                actions: [

                  CupertinoDialogAction(
                    child: Text('Continue Shopping'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
        }
      } catch (e) {
        print("Polling error: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: widget.isDark ? Color(0xFF000000) : CupertinoColors.white,
      child: Container(
        decoration: widget.isDark
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
          child: widget.cartItems.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '🛒',
                  style: TextStyle(fontSize: 80),
                ),
                SizedBox(height: 20),
                Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Add some kicks to get started!',
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey2,
                  ),
                ),
              ],
            ),
          )
              : Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: widget.isDark
                            ? [CupertinoColors.white, Color(0xFFAAAAAA)]
                            : [CupertinoColors.black, Color(0xFF555555)],
                      ).createShader(bounds),
                      child: Text(
                        'CART',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: CupertinoColors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    if (widget.cartItems.isNotEmpty)
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: Color(0xFFFF3B30),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text('Clear Cart'),
                              content: Text('Remove all items from your cart?'),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: Text('Clear'),
                                  onPressed: () {
                                    widget.onClearCart();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: _buildCartItem(item, index),
                    );
                  },
                ),
              ),

              // Checkout Section
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: widget.isDark
                      ? LinearGradient(
                    colors: [
                      Color(0xFF1C1C1E),
                      Color(0xFF2C2C2E),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: widget.isDark ? null : CupertinoColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, -5),
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(height: 4),
                          Text(
                            '₱${totalAmount.toString()}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: widget.isDark
                                  ? CupertinoColors.white
                                  : CupertinoColors.black,
                            ),
                          ),
                        ],
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => payNow(totalAmount),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: widget.isDark
                                  ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                                  : [CupertinoColors.black, Color(0xFF333333)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: widget.isDark
                                ? [
                              BoxShadow(
                                color: CupertinoColors.white.withOpacity(0.3),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              )
                            ]
                                : null,
                          ),
                          child: Text(
                            'CHECKOUT',
                            style: TextStyle(
                              color: widget.isDark
                                  ? CupertinoColors.black
                                  : CupertinoColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: widget.isDark
            ? LinearGradient(
          colors: [
            Color(0xFF1C1C1E),
            Color(0xFF2C2C2E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        color: widget.isDark ? null : CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(20),
        boxShadow: widget.isDark
            ? [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: Offset(0, 8),
          )
        ]
            : null,
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              gradient: widget.isDark
                  ? LinearGradient(
                colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
              )
                  : null,
              color: widget.isDark ? null : CupertinoColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Image.network(
                item['image'],
                height: 75,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    CupertinoIcons.photo,
                    size: 40,
                    color: CupertinoColors.systemGrey,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: widget.isDark
                        ? CupertinoColors.white
                        : CupertinoColors.black,
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
                SizedBox(height: 8),
                Text(
                  '₱${item['price']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: widget.isDark
                        ? CupertinoColors.white
                        : CupertinoColors.black,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.onUpdateQuantity(index, item['quantity'] - 1);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: widget.isDark
                            ? LinearGradient(
                          colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                        )
                            : null,
                        color: widget.isDark ? null : CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        CupertinoIcons.minus,
                        size: 16,
                        color: widget.isDark
                            ? CupertinoColors.white
                            : CupertinoColors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '${item['quantity']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: widget.isDark
                          ? CupertinoColors.white
                          : CupertinoColors.black,
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      widget.onUpdateQuantity(index, item['quantity'] + 1);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: widget.isDark
                              ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                              : [CupertinoColors.black, Color(0xFF333333)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        CupertinoIcons.add,
                        size: 16,
                        color: widget.isDark
                            ? CupertinoColors.black
                            : CupertinoColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () => widget.onRemoveItem(index),
                child: Icon(
                  CupertinoIcons.delete,
                  size: 22,
                  color: Color(0xFFFF3B30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final String url;
  final bool isDark;

  const PaymentPage({
    super.key,
    required this.url,
    required this.isDark,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: widget.isDark ? Color(0xFF000000) : CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: widget.isDark
            ? Color(0xFF1C1C1E).withOpacity(0.9)
            : CupertinoColors.white.withOpacity(0.9),
        middle: Text(
          "Payment",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.back,
            color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}