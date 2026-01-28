import 'package:flutter/cupertino.dart';

class AboutPage extends StatelessWidget {
  final bool isDark;

  const AboutPage({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: isDark ? Color(0xFF000000) : CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDark
            ? Color(0xFF1C1C1E).withOpacity(0.9)
            : CupertinoColors.white.withOpacity(0.9),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? CupertinoColors.white : CupertinoColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          'ABOUT',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: isDark ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
      ),
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
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              SizedBox(height: 20),


              SizedBox(height: 30),

              // App Name
              Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: isDark
                        ? [CupertinoColors.white, Color(0xFFAAAAAA)]
                        : [CupertinoColors.black, Color(0xFF555555)],
                  ).createShader(bounds),
                  child: Text(
                    'REALE\$T',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              Center(
                child: Text(
                  'Premium Footwear Collection',
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),

              SizedBox(height: 8),

              Center(
                child: Text(
                  'Version 2.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey2,
                  ),
                ),
              ),

              SizedBox(height: 50),

              // Description
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? LinearGradient(
                    colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
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
                    Text(
                      'ABOUT US',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Welcome to REALE\$T - your ultimate destination for premium footwear. We bring you the latest and greatest sneakers from top brands like Nike and Adidas.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: isDark ? CupertinoColors.white : CupertinoColors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Our mission is to provide sneaker enthusiasts with authentic, high-quality footwear and an exceptional shopping experience with seamless delivery tracking.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: isDark ? CupertinoColors.white : CupertinoColors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Features
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? LinearGradient(
                    colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
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
                    Text(
                      'FEATURES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFeature('✓', 'Authentic Products from Top Brands'),
                    _buildFeature('✓', 'Fast & Secure Checkout'),
                    _buildFeature('✓', 'Real-time Order Tracking'),
                    _buildFeature('✓', 'Purchase History & Delivery Details'),
                    _buildFeature('✓', 'Free Shipping on Orders Over ₱5000'),
                    _buildFeature('✓', '30-Day Return Policy'),
                    _buildFeature('✓', '24/7 Customer Support'),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Contact Info
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? LinearGradient(
                    colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
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
                    Text(
                      'CONTACT US',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildContactInfo(
                      CupertinoIcons.mail_solid,
                      'Email',
                      'support@realest.ph',
                      Color(0xFF007AFF),
                    ),
                    SizedBox(height: 12),
                    _buildContactInfo(
                      CupertinoIcons.phone_fill,
                      'Phone',
                      '+63 961 605 7988',
                      Color(0xFF34C759),
                    ),
                    SizedBox(height: 12),
                    _buildContactInfo(
                      CupertinoIcons.location_fill,
                      'Address',
                      'San Nicolas, Sta Ana, Pampanga, PH',
                      Color(0xFFFF9500),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Social Media
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? LinearGradient(
                    colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
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
                    Text(
                      'FOLLOW US',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton('📘', 'Facebook'),
                        _buildSocialButton('📷', 'Instagram'),
                        _buildSocialButton('🐦', 'Twitter'),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Copyright
              Center(
                child: Text(
                  '© 2026 REALE\$T. All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey2,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Center(
                child: Text(
                  'Made with ❤️ in the Philippines',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey2,
                  ),
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF34C759), Color(0xFF30D158)],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                icon,
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? CupertinoColors.white : CupertinoColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 18,
            color: CupertinoColors.white,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
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
    );
  }

  Widget _buildSocialButton(String emoji, String platform) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
              colors: [Color(0xFF2C2C2E), Color(0xFF3C3C3E)],
            )
                : null,
            color: isDark ? null : CupertinoColors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: isDark
                ? [
              BoxShadow(
                color: CupertinoColors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ]
                : null,
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          platform,
          style: TextStyle(
            fontSize: 12,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
}