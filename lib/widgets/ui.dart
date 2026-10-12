import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import 'screen_switcher.dart';

class BLCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? color;
  final Border? border;

  const BLCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: color ?? BuildLockTheme.card,
          borderRadius: BorderRadius.circular(20),
          border: border ?? Border.all(color: BuildLockTheme.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      );
}

class BLBadge extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const BLBadge(
    this.text, {
    super.key,
    this.color = BuildLockTheme.green,
    this.icon,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: color),
              const SizedBox(width: 4),
            ],
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );
}

// AI Match Badge Widget with Indigo/Violet Gradient (#6366F1 to #8B5CF6)
class AiBadge extends StatelessWidget {
  final String scoreText;
  final String? subtitle;

  const AiBadge({
    super.key,
    required this.scoreText,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: BuildLockTheme.aiGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: BuildLockTheme.aiStart.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome, size: 14, color: Colors.white),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  scoreText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.3,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
}

class BLSectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const BLSectionTitle(
    this.title, {
    super.key,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: BuildLockTheme.navy,
            ),
          ),
          if (action != null)
            InkWell(
              onTap: onAction,
              child: Text(
                action!,
                style: const TextStyle(
                  color: BuildLockTheme.orange,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      );
}

class BLStat extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color? color;

  const BLStat({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) => BLCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (color ?? BuildLockTheme.orange).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color ?? BuildLockTheme.orange, size: 22),
            ),
            const SizedBox(height: 12),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: BuildLockTheme.navy,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}

class BLBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;

  const BLBottomNav({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: BuildLockTheme.border, width: 1)),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: onTap,
          backgroundColor: Colors.white,
          indicatorColor: BuildLockTheme.orangeSoft,
          elevation: 0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: BuildLockTheme.orange),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search, color: BuildLockTheme.orange),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.campaign_outlined),
              selectedIcon: Icon(Icons.campaign, color: BuildLockTheme.orange),
              label: 'Broadcast',
            ),
            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2, color: BuildLockTheme.orange),
              label: 'Orders',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: BuildLockTheme.orange),
              label: 'Profile',
            ),
          ],
        ),
      );
}

class BLTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool back;
  final List<Widget>? actions;
  final Widget? leading;

  const BLTopBar({
    super.key,
    required this.title,
    this.back = true,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        leading: leading ??
            (back
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () => Navigator.pop(context),
                  )
                : null),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            tooltip: '104 Screens Catalog',
            icon: const Icon(Icons.grid_view, color: BuildLockTheme.orange),
            onPressed: () => ScreenSwitcherButton.openCatalog(context),
          ),
          if (actions != null) ...actions!,
        ],
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Widget primaryButton(String text, VoidCallback onTap, {IconData? icon, Color? color}) =>
    SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? BuildLockTheme.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

Widget outlineButton(String text, VoidCallback onTap, {IconData? icon, Color? color}) =>
    SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color ?? BuildLockTheme.border, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: color ?? BuildLockTheme.navy),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: color ?? BuildLockTheme.navy,
              ),
            ),
          ],
        ),
      ),
    );

// Slide to Confirm Action Bar Widget
class SlideToConfirmBar extends StatefulWidget {
  final String text;
  final VoidCallback onConfirmed;

  const SlideToConfirmBar({
    super.key,
    required this.text,
    required this.onConfirmed,
  });

  @override
  State<SlideToConfirmBar> createState() => _SlideToConfirmBarState();
}

class _SlideToConfirmBarState extends State<SlideToConfirmBar> {
  double _dragValue = 0.0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final maxDrag = constraints.maxWidth - 58;
          return Container(
            height: 58,
            decoration: BoxDecoration(
              color: BuildLockTheme.navy,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
                Positioned(
                  left: _dragValue,
                  top: 4,
                  bottom: 4,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _dragValue = (_dragValue + details.delta.dx)
                            .clamp(0.0, maxDrag);
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      if (_dragValue > maxDrag * 0.8) {
                        setState(() => _dragValue = maxDrag);
                        widget.onConfirmed();
                      } else {
                        setState(() => _dragValue = 0.0);
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: BuildLockTheme.orange,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                      ),
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}

// Interactive Signature Canvas Pad
class SignaturePad extends StatefulWidget {
  final ValueChanged<bool>? onDrawChanged;
  const SignaturePad({super.key, this.onDrawChanged});

  @override
  State<SignaturePad> createState() => SignaturePadState();
}

class SignaturePadState extends State<SignaturePad> {
  List<Offset?> points = [];

  void clear() {
    setState(() {
      points.clear();
    });
    widget.onDrawChanged?.call(false);
  }

  bool get hasSignature => points.any((p) => p != null);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: BuildLockTheme.border, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: GestureDetector(
                onPanUpdate: (details) {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  setState(() {
                    points.add(renderBox.globalToLocal(details.globalPosition));
                  });
                  widget.onDrawChanged?.call(true);
                },
                onPanEnd: (details) {
                  setState(() {
                    points.add(null);
                  });
                },
                child: CustomPaint(
                  painter: SignaturePainter(points: points),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          if (!hasSignature)
            const Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: Text(
                    'SIGN HERE WITH FINGER',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            right: 8,
            top: 8,
            child: TextButton.icon(
              onPressed: clear,
              icon: const Icon(Icons.clear, size: 16, color: BuildLockTheme.red),
              label: const Text('Clear', style: TextStyle(color: BuildLockTheme.red, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      );
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  SignaturePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = BuildLockTheme.navy
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.5;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SignaturePainter oldDelegate) => true;
}
