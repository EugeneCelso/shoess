import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'about_page.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ProfilePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final box = Hive.box("shoestore_db");
  final LocalAuthentication auth = LocalAuthentication();

  String get username => box.get("username", defaultValue: "Guest");
  String get email => box.get("email", defaultValue: "guest@reale\$t.ph");
  String get fullName => box.get("fullName", defaultValue: "Guest User");
  bool get biometricsEnabled => box.get("biometrics", defaultValue: false);

  void _toggleBiometrics(bool value) async {
    setState(() {
      box.put("biometrics", value);
      print("Biometrics toggled: $value");
    });

    if (value) {
      // Show success message when enabled
      _showAlert('Biometrics Enabled ✓',
          'You can now use fingerprint or Face ID to login to your account.');
    } else {
      // Show disabled message
      _showAlert('Biometrics Disabled',
          'Biometric login has been turned off. Use your password to login.');
    }
  }

  void _showAlert(String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _logout() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Sign Out'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget tiles(IconData icon, String title, dynamic trailing, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 1),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.isDark ? Color(0xFF1C1C1E) : CupertinoColors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 18,
                color: CupertinoColors.white,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                ),
              ),
            ),
            trailing is Widget ? trailing : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget settingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isDark ? Color(0xFF1C1C1E) : CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: children,
      ),
    );
  }

  String _getAccountAge() {
    final created = box.get("accountCreated");
    if (created == null) return "New Account";

    final createdDate = DateTime.parse(created);
    final diff = DateTime.now().difference(createdDate);

    if (diff.inDays > 365) {
      return "Member for ${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? 'year' : 'years'}";
    } else if (diff.inDays > 30) {
      return "Member for ${(diff.inDays / 30).floor()} months";
    } else if (diff.inDays > 0) {
      return "Member for ${diff.inDays} days";
    } else {
      return "Member since today";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: widget.isDark ? Color(0xFF000000) : CupertinoColors.white,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 10),

            // Profile Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.isDark ? Color(0xFF1C1C1E) : CupertinoColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: widget.isDark
                            ? [CupertinoColors.white, Color(0xFFDDDDDD)]
                            : [CupertinoColors.black, Color(0xFF333333)],
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        fullName.isNotEmpty ? fullName[0].toUpperCase() : '?',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: widget.isDark ? CupertinoColors.black : CupertinoColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    fullName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: widget.isDark ? CupertinoColors.white : CupertinoColors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '@$username',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF34C759).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getAccountAge(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF34C759),
                      ),
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
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 8),

            settingsGroup([
              tiles(
                CupertinoIcons.moon_fill,
                'Dark Mode',
                CupertinoSwitch(
                  value: widget.isDark,
                  onChanged: (value) => widget.onToggleTheme(),
                  activeColor: Color(0xFF34C759),
                ),
                Color(0xFF5E5CE6),
                null,
              ),
            ]),

            SizedBox(height: 30),

            // Security Section
            Text(
              'SECURITY',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 8),

            settingsGroup([
              tiles(
                CupertinoIcons.lock_shield_fill,
                'Biometric Login',
                CupertinoSwitch(
                  value: biometricsEnabled,
                  onChanged: _toggleBiometrics,
                  activeColor: Color(0xFF34C759),
                ),
                Color(0xFF5856D6),
                null,
              ),
            ]),

            SizedBox(height: 30),

            // General Section
            Text(
              'GENERAL',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 8),

            settingsGroup([
              tiles(
                CupertinoIcons.info_circle_fill,
                'About',
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoColors.systemGrey3,
                  size: 20,
                ),
                Color(0xFF007AFF),
                    () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AboutPage(isDark: widget.isDark),
                    ),
                  );
                },
              ),
              tiles(
                CupertinoIcons.bell_fill,
                'Notifications',
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoColors.systemGrey3,
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
                  color: CupertinoColors.systemGrey3,
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
                CupertinoIcons.creditcard_fill,
                'Payment Methods',
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoColors.systemGrey3,
                  size: 20,
                ),
                Color(0xFF32ADE6),
                    () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text('Payment Methods'),
                      content: Text('Secure payment via Xendit\n\nSupported: Credit Card, Debit Card, GCash, PayMaya'),
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
            ]),

            SizedBox(height: 30),

            // Support Section
            Text(
              'SUPPORT',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 8),

            settingsGroup([
              tiles(
                CupertinoIcons.chat_bubble_fill,
                'Help & Support',
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoColors.systemGrey3,
                  size: 20,
                ),
                Color(0xFF32ADE6),
                    () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text('Help & Support'),
                      content: Text('Contact us at:\nsupport@realest.ph\n+63 961 605 7988'),
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
            ]),

            SizedBox(height: 30),

            // Account Actions
            Text(
              'ACCOUNT',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 8),

            settingsGroup([
              tiles(
                CupertinoIcons.square_arrow_right,
                'Sign Out',
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoColors.systemGrey3,
                  size: 20,
                ),
                Color(0xFFFF3B30),
                _logout,
              ),
            ]),

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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}