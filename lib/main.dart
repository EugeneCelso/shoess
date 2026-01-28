import 'package:flutter/cupertino.dart';
import 'homepage.dart';
import 'cart_page.dart';
import 'about_page.dart';
import 'orders_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> orderHistory = [];

  void addToCart(Map<String, dynamic> shoe) {
    setState(() {
      int existingIndex = cartItems.indexWhere((item) =>
      item['name'] == shoe['name'] &&
          item['selectedSize'] == shoe['selectedSize'] &&
          item['selectedColor'] == shoe['selectedColor']
      );

      if (existingIndex != -1) {
        cartItems[existingIndex]['quantity']++;
      } else {
        cartItems.add({...shoe, 'quantity': 1});
      }
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void updateQuantity(int index, int quantity) {
    setState(() {
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index]['quantity'] = quantity;
      }
    });
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  void addToOrderHistory(List<Map<String, dynamic>> items, int total) {
    setState(() {
      orderHistory.insert(0, {
        'orderId': 'ORD${DateTime.now().millisecondsSinceEpoch}',
        'items': List.from(items),
        'total': total,
        'date': DateTime.now(),
        'status': 'Processing',
        'trackingNumber': 'TRK${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
        'estimatedDelivery': DateTime.now().add(Duration(days: 3)),
        'shippingAddress': 'San Nicolas, Santa Ana, PH',
      });
    });
  }

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  Widget tiles(IconData icon, String title, dynamic trailing, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                icon,
                size: 20,
                color: CupertinoColors.white,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? CupertinoColors.white : CupertinoColors.black,
                ),
              ),
            ),
            trailing is Widget ? trailing : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: CupertinoColors.systemGrey,
        scaffoldBackgroundColor: isDark
            ? Color(0xFF000000)
            : CupertinoColors.white,
        barBackgroundColor: isDark
            ? Color(0xFF1C1C1E)
            : CupertinoColors.lightBackgroundGray,
      ),
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: isDark
              ? Color(0xFF1C1C1E)
              : CupertinoColors.white,
          activeColor: isDark ? CupertinoColors.white : CupertinoColors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(CupertinoIcons.cart),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF3B30), Color(0xFFFF6B6B)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartItems.length}',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(CupertinoIcons.cube_box),
                  if (orderHistory.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Color(0xFF34C759),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                ],
              ),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: "Settings",
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return Homepage(
                onAddToCart: addToCart,
                isDark: isDark,
              );
            case 1:
              return CartPage(
                cartItems: cartItems,
                onRemoveItem: removeFromCart,
                onUpdateQuantity: updateQuantity,
                onClearCart: clearCart,
                onOrderPlaced: addToOrderHistory,
                isDark: isDark,
              );
            case 2:
              return OrdersPage(
                orders: orderHistory,
                isDark: isDark,
              );
            case 3:
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
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  )
                      : null,
                  child: SafeArea(
                    child: ListView(
                      padding: EdgeInsets.all(20),
                      children: [
                        SizedBox(height: 10),

                        // Profile Section
                        Container(
                          padding: EdgeInsets.all(24),
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
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isDark
                                        ? [Color(0xFF3C3C3E), Color(0xFF2C2C2E)]
                                        : [CupertinoColors.white, CupertinoColors.systemGrey6],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '👤',
                                    style: TextStyle(fontSize: 35),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mr.Rico Suave ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: isDark
                                            ? CupertinoColors.white
                                            : CupertinoColors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'ricosuave@reale\$t.ph',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30),

                        // Appearance Section
                        Text(
                          'APPEARANCE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        SizedBox(height: 12),

                        tiles(
                          CupertinoIcons.moon_fill,
                          'Dark Mode',
                          CupertinoSwitch(
                            value: isDark,
                            onChanged: (value) => toggleTheme(),
                            activeColor: CupertinoColors.white,
                          ),
                          Color(0xFF5E5CE6),
                          null,
                        ),

                        SizedBox(height: 30),

                        // General Section
                        Text(
                          'GENERAL',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        SizedBox(height: 12),

                        tiles(
                          CupertinoIcons.info_circle_fill,
                          'About',
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: CupertinoColors.systemGrey,
                            size: 20,
                          ),
                          Color(0xFF007AFF),
                              () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AboutPage(isDark: isDark),
                              ),
                            );
                          },
                        ),

                        tiles(
                          CupertinoIcons.bell_fill,
                          'Notifications',
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: CupertinoColors.systemGrey,
                            size: 20,
                          ),
                          Color(0xFFFF9500),
                              () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Notifications'),
                                content: Text('Get notified about order updates, new arrivals, and exclusive deals!'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        tiles(
                          CupertinoIcons.location_fill,
                          'Shipping Address',
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: CupertinoColors.systemGrey,
                            size: 20,
                          ),
                          Color(0xFF34C759),
                              () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Shipping Address'),
                                content: Text('San Nicolas, Sta Ana, PH\n+63 961 605 7988'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        tiles(
                          CupertinoIcons.padlock_solid,
                          'Secret Key',
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: CupertinoColors.systemGrey,
                            size: 20,
                          ),
                          Color(0xFF5856D6),
                              () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Secret Key'),
                                content: Text('Manage your Xendit payment API keys securely.'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 30),

                        // Support Section
                        Text(
                          'SUPPORT',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        SizedBox(height: 12),

                        tiles(
                          CupertinoIcons.chat_bubble_fill,
                          'Help & Support',
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: CupertinoColors.systemGrey,
                            size: 20,
                          ),
                          Color(0xFF32ADE6),
                              () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Help & Support'),
                                content: Text('Contact us at:\nsupport@kicks.ph\n+63 961 605 7988'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 30),



                        Center(
                          child: Text(
                            'REALE\$T v2.0',
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey2,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}