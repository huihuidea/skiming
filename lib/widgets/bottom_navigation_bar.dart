import 'package:flutter/material.dart';
import '../pages/cart.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color _activeColor = Color(0xFFFF5A5F);
  static const Color _inactiveColor = Color(0xFF9EA4B2);
  static const Color _borderColor = Color(0xFFE7EAF0);

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).padding.bottom;
    const double barHeight = 68;
    const double bumpRadius = 32;

    return SizedBox(
      height: barHeight + bumpRadius + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _NavigationBarPainter(
                backgroundColor: Colors.white,
                borderColor: _borderColor,
              ),
            ),
          ),
          Positioned(
            top: 6,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      fullscreenDialog: true,
                      builder: (_) => const CartPage(),
                    ),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _activeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: _activeColor.withAlpha(64),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomInset,
            child: SizedBox(
              height: barHeight,
              child: Row(
                children: [
                  Expanded(
                    child: _NavigationItem(
                      label: 'Home',
                      iconAsset: 'assets/images/tab2.png',
                      isSelected: currentIndex == 0,
                      activeColor: _activeColor,
                      inactiveColor: _inactiveColor,
                      onTap: () => onTap(0),
                    ),
                  ),
                  Expanded(
                    child: _NavigationItem(
                      label: 'Community',
                      iconAsset: 'assets/images/tab3.png',
                      isSelected: currentIndex == 1,
                      activeColor: _activeColor,
                      inactiveColor: _inactiveColor,
                      onTap: () => onTap(1),
                    ),
                  ),
                  const SizedBox(width: 72),
                  Expanded(
                    child: _NavigationItem(
                      label: 'Shop',
                      iconAsset: 'assets/images/tab4.png',
                      isSelected: currentIndex == 3,
                      activeColor: _activeColor,
                      inactiveColor: _inactiveColor,
                      onTap: () => onTap(3),
                    ),
                  ),
                  Expanded(
                    child: _NavigationItem(
                      label: 'Profile',
                      iconAsset: 'assets/images/tab5.png',
                      isSelected: currentIndex == 4,
                      activeColor: _activeColor,
                      inactiveColor: _inactiveColor,
                      onTap: () => onTap(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final String label;
  final String iconAsset;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.label,
    required this.iconAsset,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color itemColor = isSelected ? activeColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconAsset,
              width: 24,
              height: 24,
              color: itemColor,
              colorBlendMode: BlendMode.srcIn,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: itemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationBarPainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;

  const _NavigationBarPainter({
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 34;
    const double topInset = 34;
    const double cornerRadius = 24;

    final double centerX = size.width / 2;
    final Path path = Path()
      ..moveTo(0, topInset + cornerRadius)
      ..quadraticBezierTo(0, topInset, cornerRadius, topInset)
      ..lineTo(centerX - radius - 18, topInset)
      ..quadraticBezierTo(
        centerX - radius - 6,
        topInset,
        centerX - radius,
        topInset + 10,
      )
      ..arcToPoint(
        Offset(centerX + radius, topInset + 10),
        radius: const Radius.circular(radius),
        clockwise: false,
      )
      ..quadraticBezierTo(
        centerX + radius + 6,
        topInset,
        centerX + radius + 18,
        topInset,
      )
      ..lineTo(size.width - cornerRadius, topInset)
      ..quadraticBezierTo(
        size.width,
        topInset,
        size.width,
        topInset + cornerRadius,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final Paint fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawShadow(path, Colors.black.withAlpha(18), 10, false);
    canvas.drawPath(path, fillPaint);

    final Paint strokePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _NavigationBarPainter oldDelegate) {
    return backgroundColor != oldDelegate.backgroundColor ||
        borderColor != oldDelegate.borderColor;
  }
}
