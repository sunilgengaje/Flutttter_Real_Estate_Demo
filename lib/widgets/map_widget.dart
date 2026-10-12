import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';

class InteractiveMapView extends StatelessWidget {
  final bool showRoute;
  final String? activePrice;
  final VoidCallback? onPinTap;

  const InteractiveMapView({
    super.key,
    this.showRoute = false,
    this.activePrice,
    this.onPinTap,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CustomPaint(
            painter: MapPainter(showRoute: showRoute),
            size: Size.infinite,
          ),

          // Map Pin 1: Shree Sai Materials
          Positioned(
            top: 100,
            left: 60,
            child: _buildMapPin(
              context,
              price: '₹2,350',
              name: '2.1 km',
              isSelected: true,
              onTap: onPinTap,
            ),
          ),

          // Map Pin 2: AB Construction
          Positioned(
            top: 160,
            right: 80,
            child: _buildMapPin(
              context,
              price: '₹2,300',
              name: '3.4 km',
              isSelected: false,
              onTap: onPinTap,
            ),
          ),

          // Map Pin 3: Morya Suppliers
          Positioned(
            bottom: 240,
            left: 120,
            child: _buildMapPin(
              context,
              price: '₹2,420',
              name: '4.8 km',
              isSelected: false,
              onTap: onPinTap,
            ),
          ),

          // Project Site Pin
          Positioned(
            top: 280,
            left: 200,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: BuildLockTheme.navy,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, color: BuildLockTheme.orange, size: 14),
                      SizedBox(width: 4),
                      Text('Project Site', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: BuildLockTheme.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                ),
              ],
            ),
          ),

          if (showRoute)
            Positioned(
              top: 220,
              left: 140,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: BuildLockTheme.orange,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8)],
                ),
                child: const Icon(Icons.local_shipping, color: Colors.white, size: 20),
              ),
            ),
        ],
      );

  Widget _buildMapPin(
    BuildContext context, {
    required String price,
    required String name,
    required bool isSelected,
    VoidCallback? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? BuildLockTheme.orange : BuildLockTheme.navy,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
              ),
              child: Column(
                children: [
                  Text(price, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
                  Text(name, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: isSelected ? BuildLockTheme.orange : BuildLockTheme.navy,
              size: 20,
            ),
          ],
        ),
      );
}

class MapPainter extends CustomPainter {
  final bool showRoute;
  MapPainter({this.showRoute = false});

  @override
  void paint(Canvas canvas, Size size) {
    // Map Background
    Paint bgPaint = Paint()..color = const Color(0xFFE8F1EC);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Green parks / terrain
    Paint parkPaint = Paint()..color = const Color(0xFFD4E8DC);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(20, 40, 140, 100), const Radius.circular(30)), parkPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width - 150, 180, 120, 160), const Radius.circular(20)), parkPaint);

    // River / Water body
    Paint waterPaint = Paint()
      ..color = const Color(0xFFC4E0F4)
      ..strokeWidth = 24
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path riverPath = Path();
    riverPath.moveTo(0, size.height * 0.7);
    riverPath.cubicTo(size.width * 0.3, size.height * 0.6, size.width * 0.6, size.height * 0.85, size.width, size.height * 0.75);
    canvas.drawPath(riverPath, waterPaint);

    // Main Roads
    Paint roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint borderRoadPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path roadPath1 = Path();
    roadPath1.moveTo(0, 120);
    roadPath1.cubicTo(size.width * 0.4, 120, size.width * 0.5, 300, size.width, 320);

    Path roadPath2 = Path();
    roadPath2.moveTo(size.width * 0.5, 0);
    roadPath2.lineTo(size.width * 0.5, size.height);

    canvas.drawPath(roadPath1, borderRoadPaint);
    canvas.drawPath(roadPath1, roadPaint);
    canvas.drawPath(roadPath2, borderRoadPaint);
    canvas.drawPath(roadPath2, roadPaint);

    // Delivery Route line
    if (showRoute) {
      Paint routePaint = Paint()
        ..color = BuildLockTheme.orange
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      Path routePath = Path();
      routePath.moveTo(80, 120);
      routePath.lineTo(180, 220);
      routePath.lineTo(210, 290);
      canvas.drawPath(routePath, routePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
