import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import '../widgets/map_widget.dart';
import 'auth_screens.dart';
import 'contractor_screens.dart';

// Supplier Shell Container
class SupplierShell extends StatefulWidget {
  const SupplierShell({super.key});

  @override
  State<SupplierShell> createState() => _SupplierShellState();
}

class _SupplierShellState extends State<SupplierShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    SupplierHome(),
    SupplierRequestsScreen(),
    SupplierOrdersScreen(),
    SupplierInventoryScreen(),
    SupplierProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BLBottomNav(
          index: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      );
}

// 1. Supplier App Home Screen
class SupplierHome extends StatelessWidget {
  const SupplierHome({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning,', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
                      Text('ABC Construction 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: BuildLockTheme.greenSoft, borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, color: BuildLockTheme.green, size: 14),
                      SizedBox(width: 4),
                      Text('VERIFIED SUPPLIER', style: TextStyle(color: BuildLockTheme.green, fontSize: 10, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 4 Metric Stat Cards
            const Row(
              children: [
                Expanded(child: BLStat(value: '12', label: 'Requests', icon: Icons.notifications_none)),
                SizedBox(width: 10),
                Expanded(child: BLStat(value: '5', label: 'Quotes', icon: Icons.request_quote_outlined)),
                SizedBox(width: 10),
                Expanded(child: BLStat(value: '8', label: 'Orders', icon: Icons.inventory_2_outlined)),
              ],
            ),
            const SizedBox(height: 14),

            // Today's Sales Earnings Card
            BLCard(
              color: BuildLockTheme.navy,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today's Sales Earnings", style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text('₹1,82,500', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
                  const SizedBox(height: 12),
                  primaryButton(
                    'View Earnings & Settlements',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SupplierEarningsScreen()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Confirmed Order Action Banner for Supplier
            const BLSectionTitle('Confirmed Orders Pending Dispatch'),
            const SizedBox(height: 10),
            BLCard(
              color: BuildLockTheme.greenSoft,
              border: Border.all(color: BuildLockTheme.green.withValues(alpha: 0.3)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupplierConfirmedOrderScreen()),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      BLBadge('🔐 CONFIRMED & PAID #BL001245', color: BuildLockTheme.green, icon: Icons.check_circle),
                      Spacer(),
                      Text('Today 3–5 PM', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w900, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('M-Sand • 20 Ton', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const SizedBox(height: 2),
                  const Text('Contractor: Rohan Patil • ₹57,230 (Escrow Locked)', style: TextStyle(color: Colors.black54, fontSize: 13)),
                  const SizedBox(height: 12),
                  primaryButton(
                    'Open Confirmed Order Details',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SupplierConfirmedOrderScreen()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const BLSectionTitle('Nearby Urgent Requests'),
            const SizedBox(height: 10),
            BLCard(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupplierRequestDetailScreen()),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BLBadge('NEW REQUEST', color: BuildLockTheme.orange),
                  const SizedBox(height: 8),
                  const Text('M-Sand • 20 Ton', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const SizedBox(height: 2),
                  const Text('Moshi, Pune • 2.1 km • Delivery Today, 3–5 PM', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  const SizedBox(height: 12),
                  primaryButton(
                    'Send Negotiable Counter-Quote',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SendQuoteScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

// 2. Supplier Requests Screen
class SupplierRequestsScreen extends StatelessWidget {
  const SupplierRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Requests', back: false),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: BuildLockTheme.orange, borderRadius: BorderRadius.circular(12)),
                  child: const Text('New (12)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                const Text('Quoted', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(width: 12),
                const Text('Accepted', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 14),
            _buildReqCard(context, name: 'M-Sand • 20 Ton', detail: 'Moshi, Pune • 2.1 km • Today, 3–5 PM'),
            _buildReqCard(context, name: 'TMT Steel • 5 Ton', detail: 'Khinjawadi • 6.3 km • Tomorrow'),
            _buildReqCard(context, name: 'Bricks • 10,000 Nos', detail: 'Baner, Pune • 4.1 km • Today'),
          ],
        ),
      );

  Widget _buildReqCard(BuildContext context, {required String name, required String detail}) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: BLCard(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SendQuoteScreen()),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: BuildLockTheme.orangeSoft, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.inventory_2_outlined, color: BuildLockTheme.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy, fontSize: 15)),
                    Text(detail, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                  ],
                ),
              ),
              SizedBox(
                width: 90,
                height: 38,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: BuildLockTheme.orange, padding: EdgeInsets.zero),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SendQuoteScreen()),
                  ),
                  child: const Text('Send Quote', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
      );
}

class SupplierRequestDetailScreen extends StatelessWidget {
  const SupplierRequestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Request Details', back: true),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const BLBadge('NEW REQUEST', color: BuildLockTheme.orange),
            const SizedBox(height: 12),
            const Text('M-Sand • 20 Ton', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
            const Text('📍 Moshi, Pune • 2.1 km • Delivery Today 3–5 PM', style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Inventory Status', style: TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.navy)),
                  SizedBox(height: 6),
                  Text('120 Ton Available in Ready Stock', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.green)),
                  SizedBox(height: 4),
                  Text('Contractor: Rohan Patil (Verified)', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            primaryButton(
              'Send Negotiable Counter-Quote',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SendQuoteScreen()),
              ),
            ),
          ],
        ),
      );
}

// 3. Send Quote (Supplier Negotiable Counter-Quote with OTP & Signature)
class SendQuoteScreen extends StatefulWidget {
  const SendQuoteScreen({super.key});

  @override
  State<SendQuoteScreen> createState() => _SendQuoteScreenState();
}

class _SendQuoteScreenState extends State<SendQuoteScreen> {
  final TextEditingController _priceController = TextEditingController(text: '2350');
  final TextEditingController _deliveryController = TextEditingController(text: '1500');
  final TextEditingController _otpController = TextEditingController(text: '4829');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Send Counter-Quote', back: true),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('M-Sand • 20 Ton', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
            const Text('Contractor Budget: ₹2,500/Ton • Moshi Site', style: TextStyle(color: Colors.black54, fontSize: 13)),
            const SizedBox(height: 20),

            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Negotiated Price per Ton', prefixText: '₹ '),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _deliveryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Delivery & Transport Charge', prefixText: '₹ '),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: 'Today 3–5 PM',
              items: const [
                DropdownMenuItem(value: 'Today 3–5 PM', child: Text('Today 3–5 PM Slot')),
                DropdownMenuItem(value: 'Today 5–7 PM', child: Text('Today 5–7 PM Slot')),
              ],
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'Committed Delivery Slot'),
            ),
            const SizedBox(height: 20),

            const Text('Supplier Digital Signature Consent', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: BuildLockTheme.navy)),
            const SizedBox(height: 6),
            const SignaturePad(),
            const SizedBox(height: 16),

            // Supplier Digital Consent OTP Verification
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: BuildLockTheme.orangeSoft,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: BuildLockTheme.orange),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('4-Digit Supplier Digital Consent OTP', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4),
                    decoration: const InputDecoration(
                      labelText: 'Supplier Consent OTP',
                      prefixIcon: Icon(Icons.lock, color: BuildLockTheme.orange),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            primaryButton(
              'Verify OTP & Submit Counter-Quote',
              () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP Verified! Counter-quote & digital signature submitted to contractor ✓')));
              },
            ),
          ],
        ),
      );
}

// 4. Supplier Confirmed Order Screen
class SupplierConfirmedOrderScreen extends StatelessWidget {
  const SupplierConfirmedOrderScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Confirmed Order #BL001245', back: true),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            BLCard(
              color: BuildLockTheme.greenSoft,
              border: Border.all(color: BuildLockTheme.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      BLBadge('🔐 ORDER CONFIRMED & PAID', color: BuildLockTheme.green, icon: Icons.check_circle),
                      Spacer(),
                      Text('Today, 3–5 PM', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.green)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('M-Sand • 20 Ton', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const SizedBox(height: 4),
                  const Text('Total Amount: ₹57,230 (Held in Escrow Protection)', style: TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.navy)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contractor & Delivery Site Info Card
            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Site Details', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
                  SizedBox(height: 10),
                  Row(children: [Icon(Icons.location_on, color: BuildLockTheme.orange, size: 18), SizedBox(width: 8), Text('Moshi Project Site, Sector 4, Pune', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 8),
                  Row(children: [Icon(Icons.person, color: Colors.black45, size: 18), SizedBox(width: 8), Text('Contractor: Rohan Patil (+91 98765 43210)')]),
                  SizedBox(height: 8),
                  Row(children: [Icon(Icons.verified_user, color: BuildLockTheme.green, size: 18), SizedBox(width: 8), Text('Requires Delivery OTP Verification at Site')]),
                ],
              ),
            ),
            const SizedBox(height: 24),

            primaryButton(
              'Prepare Order & Assign Vehicle',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupplierOrderPrepScreen()),
              ),
              icon: Icons.inventory_2,
            ),
            const SizedBox(height: 12),
            outlineButton('Contact Contractor', () {}),
          ],
        ),
      );
}

// 5. Supplier Confirmed Orders List Screen
class SupplierOrdersScreen extends StatelessWidget {
  const SupplierOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Confirmed Orders', back: false),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BLCard(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupplierConfirmedOrderScreen()),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BLBadge('CONFIRMED ORDER #BL001245', color: BuildLockTheme.green),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 14, color: BuildLockTheme.orange),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('M-Sand • 20 Ton', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const SizedBox(height: 2),
                  const Text('Contractor: Rohan Patil • Moshi Site, Pune', style: TextStyle(color: Colors.black54, fontSize: 13)),
                  const SizedBox(height: 6),
                  const Text('Total: ₹57,230 (Escrow Locked) • Today 3–5 PM', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w800, fontSize: 13)),
                  const SizedBox(height: 12),
                  primaryButton(
                    'Open Confirmed Order Details',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SupplierConfirmedOrderScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

// 6. Supplier Order Preparation Screen
class SupplierOrderPrepScreen extends StatelessWidget {
  const SupplierOrderPrepScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Order Preparation', back: true),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BLBadge('ORDER #BL001245 DETAILS'),
                  SizedBox(height: 10),
                  Text('Material: 20 Ton M-Sand', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  SizedBox(height: 4),
                  Text('Delivery Address: Sector 4, Moshi Project Site, Pune'),
                  Text('Target Delivery Window: Today, 3–5 PM'),
                  Text('Delivery Verification OTP: Required at site'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text('Preparation Checklist', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
            const SizedBox(height: 10),
            const BLCard(
              child: Column(
                children: [
                  Row(children: [Icon(Icons.check_circle, color: BuildLockTheme.green), SizedBox(width: 10), Text('Material Picked from Yard', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 10),
                  Row(children: [Icon(Icons.check_circle, color: BuildLockTheme.green), SizedBox(width: 10), Text('Vehicle & Driver Assigned', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 10),
                  Row(children: [Icon(Icons.check_circle, color: BuildLockTheme.green), SizedBox(width: 10), Text('Weighbridge Slip Uploaded', style: TextStyle(fontWeight: FontWeight.w800))]),
                ],
              ),
            ),
            const SizedBox(height: 24),

            primaryButton(
              'Assign Vehicle & Driver',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DispatchScreen()),
              ),
            ),
          ],
        ),
      );
}

// 7. Dispatch & Driver Assignment Screen
class DispatchScreen extends StatefulWidget {
  const DispatchScreen({super.key});

  @override
  State<DispatchScreen> createState() => _DispatchScreenState();
}

class _DispatchScreenState extends State<DispatchScreen> {
  final TextEditingController _vehicleController = TextEditingController(text: 'MH12AB1234');
  final TextEditingController _driverNameController = TextEditingController(text: 'Rajesh Kumar');
  final TextEditingController _driverPhoneController = TextEditingController(text: '+91 98765 00000');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Ready to Dispatch', back: true),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(child: Icon(Icons.local_shipping, size: 70, color: BuildLockTheme.orange)),
            const SizedBox(height: 16),

            TextField(
              controller: _vehicleController,
              decoration: const InputDecoration(labelText: 'Vehicle Number', prefixIcon: Icon(Icons.local_shipping)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _driverNameController,
              decoration: const InputDecoration(labelText: 'Driver Full Name', prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _driverPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Driver Mobile Number', prefixIcon: Icon(Icons.phone)),
            ),
            const SizedBox(height: 24),

            primaryButton(
              '🚚 Dispatch Vehicle to Site',
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SupplierLiveTrackingScreen()),
                );
              },
            ),
          ],
        ),
      );
}

// 8. Supplier Shared Live Tracking Screen
class SupplierLiveTrackingScreen extends StatelessWidget {
  const SupplierLiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Order #BL001245 Live Tracking', back: true),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BLBadge('VEHICLE DISPATCHED 🚚', color: BuildLockTheme.green),
                  SizedBox(height: 10),
                  Text('Driver: Rajesh Kumar (+91 98765 00000)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                  Text('Vehicle: MH12AB1234 • ETA: 32 minutes'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Container(
              height: 220,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: const InteractiveMapView(showRoute: true),
              ),
            ),
            const SizedBox(height: 20),

            outlineButton('Call Driver Rajesh', () {}),
            const SizedBox(height: 12),
            primaryButton(
              'View Site Delivery Verification',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderCompletedScreen()),
              ),
            ),
          ],
        ),
      );
}

// 9. Supplier Earnings Screen
class SupplierEarningsScreen extends StatelessWidget {
  const SupplierEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Earnings & Settlements', back: true),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("Today's Total Sales", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
            const Text('₹1,82,500', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: BuildLockTheme.green)),
            const SizedBox(height: 16),

            const Row(
              children: [
                Expanded(child: BLStat(value: '₹74,200', label: 'Pending Settlement', icon: Icons.schedule, color: BuildLockTheme.amber)),
                SizedBox(width: 10),
                Expanded(child: BLStat(value: '₹1,08,300', label: 'Bank Released', icon: Icons.check_circle, color: BuildLockTheme.green)),
              ],
            ),
            const SizedBox(height: 20),

            const BLSectionTitle('Recent Order Settlements'),
            const SizedBox(height: 10),
            BLCard(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('#BL001245 • M-Sand 20 Ton', style: TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: const Text('₹57,230 • Auto-Settled via Site POD OTP'),
                    trailing: const BLBadge('Released', color: BuildLockTheme.green),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('#BL001244 • TMT Steel 5 Ton', style: TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: const Text('₹1,25,000 • In Escrow'),
                    trailing: const BLBadge('Pending', color: BuildLockTheme.amber),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class SupplierInventoryScreen extends StatelessWidget {
  const SupplierInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Inventory Catalog', back: false),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...['M-Sand • 120 Ton in stock', 'OPC 53 Cement • 850 Bags in stock', 'TMT Steel • 12 Ton in stock'].map(
              (x) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BLCard(
                  child: Row(
                    children: [
                      Text(x, style: const TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                      const Spacer(),
                      const Icon(Icons.edit, size: 18, color: BuildLockTheme.orange),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class SupplierProfileScreen extends StatelessWidget {
  const SupplierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Profile', back: false),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(child: CircleAvatar(radius: 42, child: Icon(Icons.storefront, size: 42))),
            const SizedBox(height: 10),
            const Center(child: Text('ABC Construction', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: BuildLockTheme.navy))),
            const Center(child: BLBadge('VERIFIED SUPPLIER')),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: BLStat(value: '96/100', label: 'Trust Score', icon: Icons.shield)),
                SizedBox(width: 10),
                Expanded(child: BLStat(value: '4.8 ⭐', label: 'Rating', icon: Icons.star)),
              ],
            ),
            const SizedBox(height: 28),

            // Logout & Role Switch Button
            outlineButton(
              'Logout & Switch Role',
              () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const RoleScreen()),
                  (r) => false,
                );
              },
              icon: Icons.logout,
              color: BuildLockTheme.red,
            ),
          ],
        ),
      );
}
