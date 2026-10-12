import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import '../widgets/map_widget.dart';

// 25. Admin Operations Dashboard (Clean, Overflow-Free Mobile & Desktop Layout)
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedNavIndex = 0;
  String _activeMapFilter = 'All';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: BuildLockTheme.navy,
          foregroundColor: Colors.white,
          title: const Row(
            children: [
              Icon(Icons.admin_panel_settings, color: BuildLockTheme.orange, size: 20),
              SizedBox(width: 8),
              Text('BuildLock Admin Operations', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16)),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Exit Admin',
              icon: const Icon(Icons.logout, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Operational Navigation Chips (Horizontal Scrollable)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildNavChip(0, Icons.dashboard_outlined, 'Dashboard'),
                  _buildNavChip(1, Icons.storefront_outlined, 'Suppliers & KYC'),
                  _buildNavChip(2, Icons.engineering_outlined, 'Contractors'),
                  _buildNavChip(3, Icons.inventory_2_outlined, 'Orders (1,284)'),
                  _buildNavChip(4, Icons.campaign_outlined, 'Broadcasts (3,820)'),
                  _buildNavChip(5, Icons.account_balance_wallet_outlined, 'Escrow (₹42.3L)'),
                  _buildNavChip(6, Icons.report_problem_outlined, 'Disputes (18)'),
                  _buildNavChip(7, Icons.history_edu, 'Audit Trail'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            IndexedStack(
              index: _selectedNavIndex,
              children: [
                _buildOverviewSection(),
                _buildSupplierKycSection(),
                _buildContractorSection(),
                _buildOrdersSection(),
                _buildBroadcastsSection(),
                _buildEscrowSection(),
                _buildDisputesSection(),
                _buildAuditTrailSection(),
              ],
            ),
          ],
        ),
      );

  Widget _buildNavChip(int index, IconData icon, String label) {
    final isSelected = _selectedNavIndex == index;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: FilterChip(
        avatar: Icon(icon, size: 14, color: isSelected ? Colors.white : BuildLockTheme.navy),
        label: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: isSelected ? Colors.white : BuildLockTheme.navy)),
        selected: isSelected,
        selectedColor: BuildLockTheme.navy,
        backgroundColor: Colors.white,
        onSelected: (v) => setState(() => _selectedNavIndex = index),
      ),
    );
  }

  // 1. Dashboard Overview Section
  Widget _buildOverviewSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2x2 Metric Cards Grid (Prevents vertical text wrapping)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.6,
            children: const [
              _AdminStatCard(value: '1,284', label: 'Active Orders', icon: Icons.inventory_2_outlined, color: BuildLockTheme.orange),
              _AdminStatCard(value: '3,820', label: 'Requests', icon: Icons.campaign_outlined, color: BuildLockTheme.orange),
              _AdminStatCard(value: '1,042', label: 'Deliveries', icon: Icons.local_shipping_outlined, color: BuildLockTheme.green),
              _AdminStatCard(value: '₹42.3L', label: 'Payments', icon: Icons.payments_outlined, color: BuildLockTheme.orange),
            ],
          ),
          const SizedBox(height: 16),

          // Map Filter Chips Bar (Horizontal Scrollable to prevent overflow)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Text('Map Filters: ', style: TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.navy, fontSize: 12)),
                _buildMapFilterChip('All'),
                _buildMapFilterChip('Delayed'),
                _buildMapFilterChip('High Value'),
                _buildMapFilterChip('Dispute'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Live Operations Map Monitor Canvas
          const BLSectionTitle('Live Operations Map Monitor'),
          const SizedBox(height: 10),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: BuildLockTheme.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const InteractiveMapView(showRoute: true),
            ),
          ),
          const SizedBox(height: 20),

          // Live Orders Feed Panel (Clean, overflow-free)
          const BLSectionTitle('Live Orders Feed'),
          const SizedBox(height: 10),
          BLCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildOrderFeedItem('#BL001245', 'M-Sand 20 Ton', 'Shree Sai -> Moshi Site', 'Out for Delivery', BuildLockTheme.green),
                const Divider(height: 16),
                _buildOrderFeedItem('#BL001244', 'TMT Steel 5 Ton', 'AB Construction -> Baner', 'Loading', BuildLockTheme.orange),
                const Divider(height: 16),
                _buildOrderFeedItem('#BL001243', 'OPC Cement 500 Bags', 'Morya -> Pune Site', 'Delivered', BuildLockTheme.green),
                const Divider(height: 16),
                _buildOrderFeedItem('#BL001242', 'Bricks 10,000 Nos', 'Sai Bricks -> Panvel', 'Delayed', BuildLockTheme.red),
              ],
            ),
          ),
        ],
      );

  Widget _buildMapFilterChip(String label) {
    final isSel = _activeMapFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: FilterChip(
        label: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: isSel ? Colors.white : BuildLockTheme.navy)),
        selected: isSel,
        selectedColor: BuildLockTheme.navy,
        backgroundColor: Colors.white,
        onSelected: (v) => setState(() => _activeMapFilter = label),
      ),
    );
  }

  Widget _buildOrderFeedItem(String id, String title, String route, String badge, Color color) => Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.local_shipping_outlined, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$id • $title', style: const TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(route, style: const TextStyle(color: Colors.black54, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 6),
          BLBadge(badge, color: color),
        ],
      );

  // 2. Supplier KYC Verification Section
  Widget _buildSupplierKycSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BLSectionTitle('Supplier Verification & KYC'),
          const SizedBox(height: 12),
          _buildKycCard('Shree Sai Materials', 'GSTIN: 27AABCU9603R1ZM', 'Moshi Yard, Sector 4, Pune', 'VERIFIED', BuildLockTheme.green),
          const SizedBox(height: 10),
          _buildKycCard('Jagdamba Transport', 'GSTIN: 27AXYZU1234P1Z2', 'Panvel Yard, Sector 12, Mumbai', 'PENDING APPROVAL', BuildLockTheme.amber),
        ],
      );

  Widget _buildKycCard(String name, String gstin, String address, String status, Color color) => BLCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: BuildLockTheme.navy), maxLines: 1, overflow: TextOverflow.ellipsis)),
                BLBadge(status, color: color),
              ],
            ),
            const SizedBox(height: 6),
            Text(gstin, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            Text(address, style: const TextStyle(color: Colors.black54, fontSize: 11)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: BuildLockTheme.green),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name KYC Approved ✓')));
                      },
                      child: const Text('Approve KYC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Request Info', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  // 3. Contractor Section
  Widget _buildContractorSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BLSectionTitle('Registered Contractors'),
          const SizedBox(height: 12),
          const BLCard(
            child: ListTile(
              title: Text('Rohan Patil • Moshi Site', style: TextStyle(fontWeight: FontWeight.w900)),
              subtitle: Text('Verified Contractor • 42 Orders'),
              trailing: BLBadge('ACTIVE', color: BuildLockTheme.green),
            ),
          ),
        ],
      );

  // 4. Orders Section
  Widget _buildOrdersSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BLSectionTitle('Active Orders (1,284)'),
          const SizedBox(height: 12),
          const BLCard(
            child: ListTile(
              title: Text('#BL001245 • M-Sand 20 Ton', style: TextStyle(fontWeight: FontWeight.w900)),
              subtitle: Text('Shree Sai Materials -> Moshi Site'),
              trailing: BLBadge('Out for Delivery', color: BuildLockTheme.green),
            ),
          ),
        ],
      );

  // 5. Broadcasts Section
  Widget _buildBroadcastsSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BLSectionTitle('Broadcast Requirements (3,820)'),
          const SizedBox(height: 12),
          const BLCard(
            child: ListTile(
              title: Text('M-Sand 20 Ton • Moshi Site', style: TextStyle(fontWeight: FontWeight.w900)),
              subtitle: Text('24 suppliers notified • 6 counter-quotes'),
              trailing: BLBadge('Active', color: BuildLockTheme.orange),
            ),
          ),
        ],
      );

  // 6. Escrow Section
  Widget _buildEscrowSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BLSectionTitle('Protected Escrow (₹42.3L)'),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: BLStat(value: '₹31.8L', label: 'Released', icon: Icons.check_circle, color: BuildLockTheme.green)),
              SizedBox(width: 8),
              Expanded(child: BLStat(value: '₹8.2L', label: 'Held in Escrow', icon: Icons.lock, color: BuildLockTheme.orange)),
            ],
          ),
        ],
      );

  // 7. Disputes Section
  Widget _buildDisputesSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BLSectionTitle('Disputes (18 Open)'),
          const SizedBox(height: 12),
          BLCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    BLBadge('DISPUTE #D1023', color: BuildLockTheme.red),
                    Spacer(),
                    Text('#BL001245', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Quantity Mismatch (Expected 20 Ton, Received 18 Ton)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                const SizedBox(height: 12),
                primaryButton('Auto-Pro-Rate Refund ₹4,700', () {}),
              ],
            ),
          ),
        ],
      );

  // 8. Audit Trail Section
  Widget _buildAuditTrailSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BLSectionTitle('System Audit Trail (#BL001245)'),
          const SizedBox(height: 12),
          const BLCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('10:32 AM • Contractor created broadcast requirement', style: TextStyle(fontSize: 12)),
                Divider(height: 16),
                Text('10:38 AM • Supplier Shree Sai Materials sent counter-quote ₹2,350/Ton', style: TextStyle(fontSize: 12)),
                Divider(height: 16),
                Text('10:41 AM • Contractor signed digital agreement & paid ₹57,230', style: TextStyle(fontSize: 12)),
                Divider(height: 16),
                Text('04:18 PM • Site arrival, GPS location & OTP 4829 verified', style: TextStyle(fontSize: 12)),
                Divider(height: 16),
                Text('04:22 PM • ₹57,230 Escrow released to Supplier account', style: TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.green, fontSize: 12)),
              ],
            ),
          ),
        ],
      );
}

// Compact Admin Metric Stat Card (FittedBox prevents vertical text wrapping!)
class _AdminStatCard extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color;

  const _AdminStatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: BuildLockTheme.border),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 6),
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
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
