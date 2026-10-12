import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import 'contractor_screens.dart';
import 'supplier_screens.dart';
import 'admin_screens.dart';

// 1. Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: BuildLockTheme.navy,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: BuildLockTheme.orange,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: BuildLockTheme.orange.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: const Icon(Icons.construction, size: 52, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                'BuildLock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Construction Materials On Demand',
                style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              const Text(
                'Material नाही? काम थांबवू नका.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 48),
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: BuildLockTheme.orange,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      );
}

// 2. Welcome Screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'BuildLock',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: BuildLockTheme.navy),
                  ),
                ),
                const Center(
                  child: Text(
                    'Construction Materials On Demand',
                    style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),

                // Construction Graphic Illustration Container
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: BuildLockTheme.bg,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.apartment, size: 160, color: BuildLockTheme.navy.withValues(alpha: 0.08)),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: BuildLockTheme.orange,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.precision_manufacturing, size: 52, color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Material On Demand',
                            style: TextStyle(
                              color: BuildLockTheme.navy,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                primaryButton(
                  'Get Started',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RoleScreen()),
                  ),
                ),
                const SizedBox(height: 12),
                outlineButton(
                  'Login',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Find • Compare • Order • Deliver',
                    style: TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// 3. Role Selection Screen
class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Who are you?', back: true),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              RoleCard(
                icon: Icons.engineering,
                title: 'Contractor',
                subtitle: 'I need materials for my projects',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Contractor')),
                ),
              ),
              const SizedBox(height: 16),
              RoleCard(
                icon: Icons.storefront,
                title: 'Supplier',
                subtitle: 'I supply construction materials',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen(role: 'Supplier')),
                ),
              ),
              const SizedBox(height: 24),
              RoleCard(
                icon: Icons.admin_panel_settings,
                title: 'Admin Operations',
                subtitle: 'Monitor live marketplace orders & platform',
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
                ),
              ),
            ],
          ),
        ),
      );
}

class RoleCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => BLCard(
        onTap: onTap,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: BuildLockTheme.orangeSoft,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: BuildLockTheme.orange, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: BuildLockTheme.navy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
          ],
        ),
      );
}

// 4. Login & OTP Screen
class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({super.key, this.role = 'Contractor'});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '98765 43210');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Login'),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Enter your mobile number',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              decoration: const InputDecoration(
                prefixText: '+91  ',
                prefixStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: BuildLockTheme.navy),
              ),
            ),
            const SizedBox(height: 18),
            primaryButton(
              'Continue',
              () {},
            ),
            const SizedBox(height: 32),
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: BuildLockTheme.navy,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'We have sent a 6-digit code',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 46,
                  height: 52,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: BuildLockTheme.border, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Resend OTP (00:28)', style: TextStyle(color: BuildLockTheme.orange, fontWeight: FontWeight.w800)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Change Number', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            primaryButton(
              'Verify & Enter App',
              () {
                if (widget.role == 'Supplier') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SupplierShell()),
                    (r) => false,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const ContractorShell()),
                    (r) => false,
                  );
                }
              },
            ),
          ],
        ),
      );
}
