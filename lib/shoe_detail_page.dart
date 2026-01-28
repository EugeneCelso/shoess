import 'package:flutter/cupertino.dart';

class ShoeDetailPage extends StatefulWidget {
  final Map<String, dynamic> shoe;
  final Function(Map<String, dynamic>) onAddToCart;
  final bool isDark;

  const ShoeDetailPage({
    super.key,
    required this.shoe,
    required this.onAddToCart,
    required this.isDark,
  });

  @override
  State<ShoeDetailPage> createState() => _ShoeDetailPageState();
}

class _ShoeDetailPageState extends State<ShoeDetailPage> {
  void _showSizeColorSelector() {
    num? selectedSize;
    String? selectedColor;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                gradient: widget.isDark
                    ? LinearGradient(
                  colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : null,
                color: widget.isDark ? null : CupertinoColors.white,
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
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Info
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: widget.isDark
                                        ? LinearGradient(
                                      colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                                    )
                                        : null,
                                    color: widget.isDark ? null : CupertinoColors.systemGrey6,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      widget.shoe['image'],
                                      height: 70,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(CupertinoIcons.photo, size: 40);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.shoe['brand'].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: CupertinoColors.systemGrey,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        widget.shoe['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '₱${widget.shoe['price']}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30),

                            // Size Selection
                            Text(
                              'SELECT SIZE',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: widget.shoe['sizes'].map<Widget>((size) {
                                final isSelected = selectedSize == size;
                                return GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      selectedSize = size;
                                    });
                                  },
                                  child: Container(
                                    width: 65,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: isSelected
                                          ? LinearGradient(
                                        colors: widget.isDark
                                            ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                                            : [CupertinoColors.black, Color(0xFF333333)],
                                      )
                                          : null,
                                      color: isSelected
                                          ? null
                                          : (widget.isDark ? Color(0xFF1C1C1E) : CupertinoColors.systemGrey6),
                                      borderRadius: BorderRadius.circular(12),
                                      border: isSelected
                                          ? Border.all(
                                        color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                        width: 2,
                                      )
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'US ${size.toString()}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: isSelected
                                              ? (widget.isDark ? CupertinoColors.black : CupertinoColors.white)
                                              : CupertinoColors.systemGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: 30),

                            // Color Selection
                            Text(
                              'SELECT COLOR',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: widget.shoe['colors'].map<Widget>((color) {
                                final isSelected = selectedColor == color;
                                return GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      selectedColor = color;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    decoration: BoxDecoration(
                                      gradient: isSelected
                                          ? LinearGradient(
                                        colors: widget.isDark
                                            ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                                            : [CupertinoColors.black, Color(0xFF333333)],
                                      )
                                          : null,
                                      color: isSelected
                                          ? null
                                          : (widget.isDark ? Color(0xFF1C1C1E) : CupertinoColors.systemGrey6),
                                      borderRadius: BorderRadius.circular(12),
                                      border: isSelected
                                          ? Border.all(
                                        color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                        width: 2,
                                      )
                                          : null,
                                    ),
                                    child: Text(
                                      color,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? (widget.isDark ? CupertinoColors.black : CupertinoColors.white)
                                            : CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),

                    // Add to Cart Button
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: widget.isDark
                            ? LinearGradient(
                          colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
                        )
                            : null,
                        color: widget.isDark ? null : CupertinoColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (selectedSize == null || selectedColor == null) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text('Selection Required'),
                                  content: Text('Please select both size and color'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('OK'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            widget.onAddToCart({
                              ...widget.shoe,
                              'selectedSize': selectedSize,
                              'selectedColor': selectedColor,
                            });

                            Navigator.pop(modalContext);
                            Navigator.pop(this.context);

                            showCupertinoDialog(
                              context: this.context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Added to Cart ✓'),
                                content: Text('${widget.shoe['name']} (Size ${selectedSize}, $selectedColor) added to your cart!'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Continue Shopping'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 56,
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
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.cart_fill,
                                    color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'ADD TO CART',
                                    style: TextStyle(
                                      color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Full Image Header
                SliverToBoxAdapter(
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: widget.isDark
                          ? LinearGradient(
                        colors: [
                          Color(0xFF2C2C2E),
                          Color(0xFF1C1C1E),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                          : null,
                      color: widget.isDark ? null : CupertinoColors.systemGrey6,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Image.network(
                            widget.shoe['image'],
                            width: double.infinity,
                            height: 400,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                CupertinoIcons.photo,
                                size: 120,
                                color: CupertinoColors.systemGrey,
                              );
                            },
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => Navigator.pop(context),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: widget.isDark
                                      ? LinearGradient(
                                    colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                                  )
                                      : null,
                                  color: widget.isDark ? null : CupertinoColors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CupertinoColors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  CupertinoIcons.back,
                                  color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: widget.isDark
                          ? LinearGradient(
                        colors: [
                          Color(0xFF1C1C1E),
                          Color(0xFF000000),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                          : null,
                      color: widget.isDark ? null : CupertinoColors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.shoe['brand'].toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 8),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.shoe['name'],
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFFFCC00), Color(0xFFFFAA00)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(CupertinoIcons.star_fill, size: 14, color: CupertinoColors.white),
                                    SizedBox(width: 4),
                                    Text(
                                      '${widget.shoe['rating']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: CupertinoColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${widget.shoe['reviews']} reviews',
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),

                          SizedBox(height: 20),

                          Row(
                            children: [
                              Text(
                                '₱',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                ),
                              ),
                              Text(
                                '${widget.shoe['price']}',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24),

                          Text(
                            widget.shoe['description'],
                            style: TextStyle(
                              fontSize: 15,
                              color: widget.isDark ? Color(0xFFAAAAAA) : Color(0xFF666666),
                              height: 1.6,
                            ),
                          ),

                          SizedBox(height: 24),

                          Text(
                            'FEATURES',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          SizedBox(height: 12),
                          ...widget.shoe['features'].map<Widget>((feature) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF34C759), Color(0xFF30D158)],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),

                          SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: widget.isDark
                                        ? LinearGradient(
                                      colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                                    )
                                        : null,
                                    color: widget.isDark ? null : CupertinoColors.systemGrey6,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.shoe['weight'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Weight',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: widget.isDark
                                        ? LinearGradient(
                                      colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
                                    )
                                        : null,
                                    color: widget.isDark ? null : CupertinoColors.systemGrey6,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.shoe['material'].split('/')[0],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Material',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Fixed Add to Cart Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: widget.isDark
                      ? LinearGradient(
                    colors: [
                      Color(0xFF1C1C1E).withOpacity(0.95),
                      Color(0xFF2C2C2E).withOpacity(0.98),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                      : null,
                  color: widget.isDark ? null : CupertinoColors.white.withOpacity(0.95),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _showSizeColorSelector,
                    child: Container(
                      width: double.infinity,
                      height: 56,
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
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cart_fill,
                              color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'ADD TO CART',
                              style: TextStyle(
                                color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}