import 'package:flutter/cupertino.dart';
import 'shoe_detail_page.dart';

class Homepage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  final bool isDark;

  const Homepage({
    super.key,
    required this.onAddToCart,
    required this.isDark,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Running', 'Basketball', 'Casual', 'Training', 'Lifestyle'];

  final List<Map<String, dynamic>> shoes = [
    {
      'name': 'Air Max 270',
      'brand': 'Nike',
      'price': 8999,
      'category': 'Running',
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
      'description': 'Experience ultimate comfort with the Air Max 270. Featuring Nike\'s biggest heel Air unit yet for incredible cushioning and a sleek, modern design.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Black', 'White', 'Red', 'Blue', 'Grey'],
      'rating': 4.8,
      'reviews': 2847,
      'features': ['Air cushioning', 'Breathable mesh', 'Rubber sole'],
      'weight': '308g',
      'material': 'Mesh/Synthetic',
    },
    {
      'name': 'Ultra Boost 21',
      'brand': 'Adidas',
      'price': 9499,
      'category': 'Running',
      'image': 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=600',
      'description': 'Premium comfort and energy return in every stride. Responsive Boost midsole and Primeknit upper for adaptive fit.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['White', 'Black', 'Grey', 'Navy'],
      'rating': 4.9,
      'reviews': 3421,
      'features': ['Boost cushioning', 'Primeknit upper', 'Continental rubber'],
      'weight': '310g',
      'material': 'Primeknit/Rubber',
    },
    {
      'name': 'Air Motif',
      'brand': 'Nike',
      'price': 11999,
      'category': 'Basketball',
      'image': 'https://sneakernews.com/wp-content/uploads/2022/02/Nike-Air-Max-Motif-DH9388-400-8.jpg?w=1140?w=800&h=800&fit=crop',
      'description': 'Dominate the court with LeBron\'s signature shoe. Features a 360-degree zonal cabling system and Air Zoom cushioning.',
      'sizes': [8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13],
      'colors': ['Purple', 'Gold', 'Black', 'White'],
      'rating': 4.7,
      'reviews': 1893,
      'features': ['Air Zoom', 'Zonal cabling', 'High traction'],
      'weight': '425g',
      'material': 'Synthetic/Rubber',
    },
    {
      'name': 'Court Vision',
      'brand': 'Nike',
      'price': 4999,
      'category': 'Casual',
      'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=600',
      'description': 'Classic style meets modern comfort. Inspired by retro basketball shoes with a clean, timeless design.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['White', 'Black', 'Navy', 'Red'],
      'rating': 4.6,
      'reviews': 4521,
      'features': ['Classic design', 'Padded collar', 'Durable leather'],
      'weight': '345g',
      'material': 'Leather/Synthetic',
    },
    {
      'name': 'Metcon 8',
      'brand': 'Nike',
      'price': 7999,
      'category': 'Sneakers',
      'image': 'https://images.stockx.com/images/Nike-Metcon-8-Team-Red.jpg?fit=fill&bg=FFFFFF&w=480&h=320&q=60&dpr=1&trim=color&updated_at=1680918163?w=600',
      'description': 'Built for the toughest workouts. Features a wide, flat heel for stability during heavy lifts and rope-ready traction.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Black', 'Red', 'Grey', 'Blue'],
      'rating': 4.8,
      'reviews': 2156,
      'features': ['Stable platform', 'Rope-ready', 'React foam'],
      'weight': '385g',
      'material': 'Mesh/Rubber',
    },
    {
      'name': 'Superstar',
      'brand': 'Adidas',
      'price': 5499,
      'category': 'Casual',
      'image': 'https://images.unsplash.com/photo-1758665630748-08141996c144?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGFkaWRhcyUyMHN1cGVyc3RhcnxlbnwwfHwwfHx8MA%3D%3D?w=600',
      'description': 'Iconic shell-toe design that never goes out of style. A streetwear legend since 1970 with premium leather upper.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['White', 'Black', 'Navy'],
      'rating': 4.9,
      'reviews': 8934,
      'features': ['Shell toe', 'Leather upper', 'Rubber sole'],
      'weight': '368g',
      'material': 'Leather/Rubber',
    },
    {
      'name': 'Air Jordan 1 Mid',
      'brand': 'Nike',
      'price': 7299,
      'category': 'Casual',
      'image': 'https://i8.amplience.net/i/jpl/jd_752654_a?w=600',
      'description': 'Inspired by the original AJ1, this mid-top sneaker features premium materials and iconic Jordan details.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13],
      'colors': ['Black/Red', 'White/Black', 'Grey', 'Navy'],
      'rating': 4.8,
      'reviews': 5632,
      'features': ['Premium leather', 'Air-Sole unit', 'Padded collar'],
      'weight': '395g',
      'material': 'Leather/Synthetic',
    },
    {
      'name': 'React Infinity Run',
      'brand': 'Nike',
      'price': 8499,
      'category': 'Running',
      'image': 'https://images.unsplash.com/photo-1551107696-a4b0c5a0d9a2?w=600',
      'description': 'Designed to help reduce injury with soft, smooth Nike React foam and wider base for stability.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Black', 'White', 'Pink', 'Blue'],
      'rating': 4.7,
      'reviews': 2943,
      'features': ['React foam', 'Flyknit upper', 'Wide base'],
      'weight': '295g',
      'material': 'Flyknit/React',
    },
    {
      'name': 'NMD_R1',
      'brand': 'Adidas',
      'price': 6999,
      'category': 'Lifestyle',
      'image': 'https://slamdunk.shop/wp-content/uploads/2020/01/adidas-NMD-R1-V2-Black-White-1.jpg?w=600',
      'description': 'Modern nomad design with Boost cushioning. Perfect blend of style and comfort for urban exploration.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Black', 'White', 'Red', 'Blue'],
      'rating': 4.6,
      'reviews': 4123,
      'features': ['Boost midsole', 'Primeknit', 'EVA inserts'],
      'weight': '340g',
      'material': 'Primeknit/Boost',
    },
    {
      'name': 'Air Force 1 \'07',
      'brand': 'Nike',
      'price': 5999,
      'category': 'Casual',
      'image': 'https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?w=600',
      'description': 'The iconic AF1 with a modern twist. Timeless basketball design that\'s been a street staple since 1982.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13],
      'colors': ['White', 'Black', 'Red', 'Navy', 'Grey'],
      'rating': 4.9,
      'reviews': 9821,
      'features': ['Air-Sole unit', 'Leather upper', 'Pivot points'],
      'weight': '380g',
      'material': 'Leather/Rubber',
    },
    {
      'name': 'Kyrie 8',
      'brand': 'Nike',
      'price': 9999,
      'category': 'Basketball',
      'image': 'https://cdn.flightclub.com/TEMPLATE/342414/1.jpg?w=600',
      'description': 'Built for quick cuts and explosive movements. Kyrie Irving\'s signature shoe with superior grip.',
      'sizes': [8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13],
      'colors': ['Black', 'White', 'Blue', 'Green'],
      'rating': 4.8,
      'reviews': 2234,
      'features': ['Traction pattern', 'Flywire cables', 'Zoom Air'],
      'weight': '398g',
      'material': 'Synthetic/Rubber',
    },
    {
      'name': 'Air Jordan 2 low',
      'brand': 'Nike',
      'price': 13999,
      'category': 'Casual',
      'image': 'https://www.bimstoreph.com/cdn/shop/products/1_19_a661ad4d-20ca-4061-a8fc-6093ba20b307.jpg?v=1658362673?w=600',
      'description': 'Elite racing shoe with carbon fiber plate. Designed for marathon runners seeking record times.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Pink', 'Green', 'Blue', 'Orange'],
      'rating': 4.9,
      'reviews': 1567,
      'features': ['ZoomX foam', 'Carbon plate', 'Lightweight'],
      'weight': '184g',
      'material': 'ZoomX/Flyknit',
    },
    {
      'name': 'KD 15',
      'brand': 'Nike',
      'price': 10999,
      'category': 'Basketball',
      'image': 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F12%2Fkevin-durant-nike-kd-15-b-a-d-FJ1216-500-spring-2023-release-info-000.jpg?',
      'description': 'Kevin Durant\'s signature shoe built for elite scorers. Lightweight feel with excellent court control and responsiveness.',
      'sizes': [8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13],
      'colors': ['Black', 'White', 'Purple', 'Green'],
      'rating': 4.7,
      'reviews': 1984,
      'features': ['Zoom Air Strobel', 'Supportive cage', 'Multi-directional traction'],
      'weight': '390g',
      'material': 'Mesh/Synthetic',
    },
    {
      'name': 'Curry 10',
      'brand': 'Under Armour',
      'price': 10499,
      'category': 'Basketball',
      'image': 'https://cdn.flightclub.com/TEMPLATE/388347/1.jpg?',
      'description': 'Designed for sharp shooters. Stephen Curry\'s signature shoe delivers elite grip, stability, and fast court feel.',
      'sizes': [7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Black', 'White', 'Blue', 'Yellow'],
      'rating': 4.8,
      'reviews': 1762,
      'features': ['Flow cushioning', 'Superior traction', 'Lightweight build'],
      'weight': '365g',
      'material': 'Engineered Mesh/Rubber',
    },
    {
      'name': 'Zoom Freak 2',
      'brand': 'Nike',
      'price': 10499,
      'category': 'Basketball',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEwhuYQHT-Dtg7GtscpJj59u0--9qawmfakg&s',
      'description': 'Giannis Antetokounmpo\'s second signature shoe. Built for power, speed, and control with responsive Zoom cushioning and aggressive traction.',
      'sizes': [8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13],
      'colors': ['Black', 'White', 'Green', 'Purple'],
      'rating': 4.7,
      'reviews': 2048,
      'features': ['Zoom Air', 'Forefoot strap', 'Multi-directional traction'],
      'weight': '405g',
      'material': 'Mesh/Synthetic',
    },
    {
      'name': 'Pegasus 40',
      'brand': 'Nike',
      'price': 7499,
      'category': 'Running',
      'image': 'https://i.ebayimg.com/images/g/klcAAeSwKVloYQfh/s-l400.jpg',
      'description': 'A trusted daily trainer with a responsive ride. The Pegasus 40 offers balanced cushioning and durability for everyday runs.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Black', 'White', 'Blue', 'Grey'],
      'rating': 4.7,
      'reviews': 3128,
      'features': ['React foam', 'Zoom Air units', 'Breathable mesh'],
      'weight': '285g',
      'material': 'Mesh/Synthetic',
    },
    {
      'name': 'Gel-Kayano 29',
      'brand': 'ASICS',
      'price': 8999,
      'category': 'Running',
      'image': 'https://cdn.fleetfeet.com/productFull/products/1011B440_403_SR_RT_GLB_PNG_Original-JPG.jpg',
      'description': 'Stability-focused running shoe built for long-distance comfort. Features adaptive support and plush cushioning.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['Black', 'White', 'Navy', 'Red'],
      'rating': 4.8,
      'reviews': 2674,
      'features': ['GEL cushioning', 'Stability support', 'Engineered knit'],
      'weight': '299g',
      'material': 'Engineered Mesh/Rubber',
    },
    {
      'name': 'Fresh Foam X 1080',
      'brand': 'New Balance',
      'price': 8799,
      'category': 'Running',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8gPzfvTpzMIIzVsMd1Gc9ot_DBQpXtJExJg&s',
      'description': 'Soft and smooth ride for daily miles. Designed with Fresh Foam X cushioning for premium comfort.',
      'sizes': [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12],
      'colors': ['White', 'Black', 'Grey', 'Blue'],
      'rating': 4.9,
      'reviews': 2219,
      'features': ['Fresh Foam X', 'Hypoknit upper', 'Blown rubber outsole'],
      'weight': '290g',
      'material': 'Knit/Mesh',
    },




  ];

  List<Map<String, dynamic>> get filteredShoes {
    if (selectedCategory == 'All') {
      return shoes;
    }
    return shoes.where((shoe) => shoe['category'] == selectedCategory).toList();
  }

  void _showSizeChart() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'SIZE CHART',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildSizeTable(),
                      SizedBox(height: 20),
                      Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(CupertinoIcons.info_circle, size: 20, color: Color(0xFF007AFF)),
                                SizedBox(width: 8),
                                Text(
                                  'HOW TO MEASURE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              '1. Place your heel against a wall\n2. Mark the longest toe on paper\n3. Measure from wall to mark\n4. Add 0.5cm for comfort\n5. Check size chart for your size',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.6,
                                color: widget.isDark ? Color(0xFFAAAAAA) : Color(0xFF666666),
                              ),
                            ),
                          ],
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

  Widget _buildSizeTable() {
    final sizes = [
      {'us': '7', 'uk': '6', 'eu': '40', 'cm': '25'},
      {'us': '7.5', 'uk': '6.5', 'eu': '40.5', 'cm': '25.5'},
      {'us': '8', 'uk': '7', 'eu': '41', 'cm': '26'},
      {'us': '8.5', 'uk': '7.5', 'eu': '42', 'cm': '26.5'},
      {'us': '9', 'uk': '8', 'eu': '42.5', 'cm': '27'},
      {'us': '9.5', 'uk': '8.5', 'eu': '43', 'cm': '27.5'},
      {'us': '10', 'uk': '9', 'eu': '44', 'cm': '28'},
      {'us': '10.5', 'uk': '9.5', 'eu': '44.5', 'cm': '28.5'},
      {'us': '11', 'uk': '10', 'eu': '45', 'cm': '29'},
      {'us': '11.5', 'uk': '10.5', 'eu': '45.5', 'cm': '29.5'},
      {'us': '12', 'uk': '11', 'eu': '46', 'cm': '30'},
    ];

    return Container(
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isDark
                    ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                    : [CupertinoColors.black, Color(0xFF333333)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(child: _buildTableHeader('US')),
                Expanded(child: _buildTableHeader('UK')),
                Expanded(child: _buildTableHeader('EU')),
                Expanded(child: _buildTableHeader('CM')),
              ],
            ),
          ),
          ...sizes.map((size) => Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.isDark
                      ? Color(0xFF3C3C3E)
                      : CupertinoColors.systemGrey5,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(child: _buildTableCell(size['us']!)),
                Expanded(child: _buildTableCell(size['uk']!)),
                Expanded(child: _buildTableCell(size['eu']!)),
                Expanded(child: _buildTableCell(size['cm']!)),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
      ),
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
        child: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Header with REALE$T branding
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Color(0xFF000000),
                                Color(0xFF555555),
                                Color(0xFFAAAAAA),
                                CupertinoColors.white,
                              ],
                              stops: [0.0, 0.3, 0.7, 1.0],
                            ).createShader(bounds),
                            child: Text(
                              'REALE\$T',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                                color: CupertinoColors.white,
                                letterSpacing: 3,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${shoes.length} Premium Kicks Available',
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Categories
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory == category;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(
                                  colors: widget.isDark
                                      ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                                      : [CupertinoColors.black, Color(0xFF333333)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                    : null,
                                color: isSelected
                                    ? null
                                    : (widget.isDark ? Color(0xFF1C1C1E) : CupertinoColors.systemGrey6),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: isSelected && widget.isDark
                                    ? [
                                  BoxShadow(
                                    color: CupertinoColors.white.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  )
                                ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? (widget.isDark ? CupertinoColors.black : CupertinoColors.white)
                                        : CupertinoColors.systemGrey,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Shoes Grid
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.68,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final shoe = filteredShoes[index];
                          return _buildShoeCard(shoe);
                        },
                        childCount: filteredShoes.length,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              ),

              // Floating Size Chart Button
              Positioned(
                right: 20,
                bottom: 20,
                child: GestureDetector(
                  onTap: _showSizeChart,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: widget.isDark
                            ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                            : [CupertinoColors.black, Color(0xFF333333)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: widget.isDark
                              ? CupertinoColors.white.withOpacity(0.4)
                              : CupertinoColors.black.withOpacity(0.4),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.textformat_size,
                          color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                          size: 24,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'SIZE',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShoeCard(Map<String, dynamic> shoe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ShoeDetailPage(
              shoe: shoe,
              onAddToCart: widget.onAddToCart,
              isDark: widget.isDark,
            ),
          ),
        );
      },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container - Fixed height for consistency
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: widget.isDark
                    ? LinearGradient(
                  colors: [
                    Color(0xFF2C2C2E),
                    Color(0xFF3C3C3E),
                  ],
                )
                    : null,
                color: widget.isDark ? null : CupertinoColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Image.network(
                  shoe['image'],
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      CupertinoIcons.photo,
                      size: 60,
                      color: CupertinoColors.systemGrey,
                    );
                  },
                ),
              ),
            ),

            // Info
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shoe['brand'].toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: CupertinoColors.systemGrey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    shoe['name'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        size: 12,
                        color: Color(0xFFFFCC00),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${shoe['rating']} (${shoe['reviews']})',
                        style: TextStyle(
                          fontSize: 11,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₱${shoe['price']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
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
                          color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}