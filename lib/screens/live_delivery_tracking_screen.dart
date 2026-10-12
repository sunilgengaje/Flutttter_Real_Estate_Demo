import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import '../widgets/map_widget.dart';

class LiveDeliveryTrackingScreen extends StatefulWidget {
  const LiveDeliveryTrackingScreen({super.key});

  @override
  State<LiveDeliveryTrackingScreen> createState() => _LiveDeliveryTrackingScreenState();
}

class _LiveDeliveryTrackingScreenState extends State<LiveDeliveryTrackingScreen> {
  bool _isDriverView = false;
  final TextEditingController _driverOtpInputController = TextEditingController(text: '4829');

  void _openDriverOtpKeypadModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: BuildLockTheme.greenSoft, shape: BoxShape.circle),
                  child: const Icon(Icons.verified_user, color: BuildLockTheme.green, size: 24),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Driver OTP Handover Keypad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                    Text('Enter 4-digit OTP provided by contractor after unloading', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _driverOtpInputController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 8),
              decoration: const InputDecoration(
                labelText: 'Delivery Verification OTP Code',
                prefixIcon: Icon(Icons.key, color: BuildLockTheme.orange),
              ),
            ),
            const SizedBox(height: 24),

            primaryButton(
              'Verify OTP & Complete Delivery (Release Escrow)',
              () {
                Navigator.pop(context);
                _showSuccessCompletionDialog();
              },
              icon: Icons.check_circle,
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Column(
          children: [
            Icon(Icons.check_circle, size: 70, color: BuildLockTheme.green),
            SizedBox(height: 12),
            Text('Delivery Completed & Settled! ✓', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: BuildLockTheme.navy)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Order #BL001245 • 20 Ton M-Sand', style: TextStyle(fontWeight: FontWeight.w800)),
            SizedBox(height: 6),
            Text('₹57,730 Escrow Funds successfully released to Shree Sai Materials Bank Account.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 13)),
          ],
        ),
        actions: [
          primaryButton('Download Tax Invoice & Signed PO', () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tax Invoice & Signed PO downloaded PDF')));
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BLTopBar(
          title: 'Live Delivery #BL001245',
          actions: [
            TextButton.icon(
              onPressed: () => setState(() => _isDriverView = !_isDriverView),
              icon: Icon(_isDriverView ? Icons.engineering : Icons.directions_car, color: BuildLockTheme.orange, size: 18),
              label: Text(_isDriverView ? 'Contractor View' : 'Driver View', style: const TextStyle(color: BuildLockTheme.orange, fontWeight: FontWeight.w900, fontSize: 12)),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Stepper Timeline: [Placed] -> [Loaded] -> [In Transit] -> [Arrived] -> [Delivered]
            BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BLBadge(_isDriverView ? 'DRIVER NAVIGATION MODE' : 'IN TRANSIT TO SITE 🚚', color: BuildLockTheme.green),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Placed ✓', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: BuildLockTheme.green)),
                      Text('Loaded ✓', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: BuildLockTheme.green)),
                      Text('In Transit 🚚', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: BuildLockTheme.orange)),
                      Text('Arrived', style: TextStyle(fontSize: 10, color: Colors.black38)),
                      Text('Delivered', style: TextStyle(fontSize: 10, color: Colors.black38)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Live Map Route Card
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: const InteractiveMapView(showRoute: true),
              ),
            ),
            const SizedBox(height: 16),

            // Driver Info Card with Direct Call & WhatsApp Shortcuts
            BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Driver: Rajesh Kumar', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
                          Text('Vehicle: MH12AB1234 (Tata Ace) • Loader: Suresh', style: TextStyle(color: Colors.black54, fontSize: 12)),
                        ],
                      ),
                      Spacer(),
                      BLBadge('ETA 32 min', color: BuildLockTheme.green),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: outlineButton('Call Driver', () {}, icon: Icons.phone),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: outlineButton('WhatsApp', () {}, icon: Icons.chat),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contractor View: Prominent Secure OTP Display Card
            if (!_isDriverView)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: BuildLockTheme.navy,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: const Column(
                  children: [
                    Text('SECURE SITE DELIVERY OTP HANDOVER', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    SizedBox(height: 8),
                    Text('4  8  2  9', style: TextStyle(color: BuildLockTheme.orange, fontSize: 38, fontWeight: FontWeight.w900, letterSpacing: 10)),
                    SizedBox(height: 6),
                    Text('Share this OTP with driver only after material is fully unloaded and verified on site.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),

            // Driver View: Unloading Complete & OTP Verification Keypad Modal
            if (_isDriverView)
              Column(
                children: [
                  BLCard(
                    color: BuildLockTheme.orangeSoft,
                    border: Border.all(color: BuildLockTheme.orange),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('DRIVER NAVIGATION MODE', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                        SizedBox(height: 4),
                        Text('1. Arrive at Moshi Site GPS Coordinates\n2. Unload 20 Ton M-Sand\n3. Collect 4-Digit Delivery OTP from Contractor'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  primaryButton(
                    '🔑 Enter Delivery OTP & Complete Delivery',
                    _openDriverOtpKeypadModal,
                    icon: Icons.key,
                  ),
                ],
              ),
            const SizedBox(height: 20),

            if (!_isDriverView)
              primaryButton(
                'Verify Unloaded Material & Enter OTP',
                _openDriverOtpKeypadModal,
                icon: Icons.verified_user,
              ),
          ],
        ),
      );
}
