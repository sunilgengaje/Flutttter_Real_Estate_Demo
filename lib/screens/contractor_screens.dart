import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import '../widgets/map_widget.dart';
import 'auth_screens.dart';
import 'material_home_screen.dart';

// Contractor Main Shell Container
class ContractorShell extends StatefulWidget {
  const ContractorShell({super.key});

  @override
  State<ContractorShell> createState() => _ContractorShellState();
}

class _ContractorShellState extends State<ContractorShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MaterialHomeScreen(),
    MaterialCategoriesScreen(),
    RapidoBroadcastScreen(),
    ContractorOrdersScreen(),
    ContractorProfileScreen(),
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

// 1. Contractor Home Screen
class ContractorHome extends StatefulWidget {
  const ContractorHome({super.key});

  @override
  State<ContractorHome> createState() => _ContractorHomeState();
}

class _ContractorHomeState extends State<ContractorHome> {
  String selectedProject = 'Moshi Project Site • Pune';

  void _openProjectSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Project Site Location',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: BuildLockTheme.navy),
            ),
            const SizedBox(height: 16),
            ...[
              'Moshi Project Site • Pune',
              'Pune Commercial Site • Baner',
              'Panvel Residential Project',
            ].map(
              (p) => ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                tileColor: selectedProject == p ? BuildLockTheme.orangeSoft : null,
                leading: Icon(
                  Icons.location_on,
                  color: selectedProject == p ? BuildLockTheme.orange : Colors.black45,
                ),
                title: Text(
                  p,
                  style: TextStyle(
                    fontWeight: selectedProject == p ? FontWeight.w900 : FontWeight.w600,
                    color: selectedProject == p ? BuildLockTheme.orange : BuildLockTheme.navy,
                  ),
                ),
                trailing: selectedProject == p ? const Icon(Icons.check_circle, color: BuildLockTheme.orange) : null,
                onTap: () {
                  setState(() => selectedProject = p);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 12),
            outlineButton('+ Add New Project Site', () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Header Greeting & User Photo
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning,',
                              style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Rohan Patil 👋',
                              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: BuildLockTheme.navy),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: BuildLockTheme.orangeSoft,
                          shape: BoxShape.circle,
                          border: Border.all(color: BuildLockTheme.orange, width: 1.5),
                        ),
                        child: const Icon(Icons.person, color: BuildLockTheme.orange, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location Picker Bar
                  InkWell(
                    onTap: _openProjectSelector,
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, color: BuildLockTheme.orange, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          selectedProject,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: BuildLockTheme.navy),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 20, color: BuildLockTheme.navy),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Search Bar
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MaterialCategoriesScreen()),
                    ),
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: BuildLockTheme.border),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.black45),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'What material do you need?',
                              style: TextStyle(color: Colors.black38, fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: BuildLockTheme.orangeSoft,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.mic, color: BuildLockTheme.orange, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rapido-Style Instant Broadcast Banner
                  BLCard(
                    color: BuildLockTheme.navy,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RapidoBroadcastScreen()),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            BLBadge('🤖 AI SMART BROADCAST RADAR', color: BuildLockTheme.orange, icon: Icons.auto_awesome),
                            Spacer(),
                            Icon(Icons.radar, color: BuildLockTheme.orange, size: 24),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text('Broadcast Requirement & AI Match', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        const Text('AI ranks incoming supplier quotes by Price, Delivery Time, and Rating', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 14),
                        primaryButton(
                          '⚡ Broadcast Requirement Now',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RapidoBroadcastScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🚨 Urgent Requirement Card
                  BLCard(
                    color: const Color(0xFFFFF4ED),
                    border: Border.all(color: BuildLockTheme.orange.withValues(alpha: 0.3), width: 1.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const BLBadge('🚨 URGENT REQUIREMENT', color: BuildLockTheme.red),
                            const Spacer(),
                            Text(
                              'Today • 4 PM',
                              style: TextStyle(color: Colors.black.withValues(alpha: 0.5), fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'M-Sand • 20 Ton',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: BuildLockTheme.navy),
                        ),
                        const SizedBox(height: 2),
                        const Text('6 suppliers replied with negotiable counter-quotes', style: TextStyle(color: Colors.black54, fontSize: 13)),
                        const SizedBox(height: 14),
                        primaryButton(
                          'View AI Ranked Counter-Quotes',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SupplierResponsesScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Active Orders Card
                  const BLSectionTitle('Active Deliveries & Orders'),
                  const SizedBox(height: 10),
                  BLCard(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LiveOrderTrackingScreen()),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: BuildLockTheme.greenSoft,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.local_shipping, color: BuildLockTheme.green, size: 26),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('🚚 M-Sand • 20 Ton', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
                              SizedBox(height: 2),
                              Text('Arriving in 32 min • Order #BL001245', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w800, fontSize: 13)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      );
}

// 2. Exact Rapido Broadcast & AI Match Screen
class RapidoBroadcastScreen extends StatefulWidget {
  const RapidoBroadcastScreen({super.key});

  @override
  State<RapidoBroadcastScreen> createState() => _RapidoBroadcastScreenState();
}

class _RapidoBroadcastScreenState extends State<RapidoBroadcastScreen> {
  bool _isSearching = false;
  bool _quotesReceived = false;
  int _countdown = 30;
  Timer? _timer;
  String selectedMaterial = 'M-Sand • 20 Ton';

  void _startRapidoRadar() {
    setState(() {
      _isSearching = true;
      _quotesReceived = false;
      _countdown = 30;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_countdown > 1) {
        setState(() => _countdown--);
        if (_countdown == 22) {
          setState(() {
            _quotesReceived = true;
          });
        }
      } else {
        _timer?.cancel();
        setState(() => _isSearching = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Rapido Broadcast & AI Match'),
        body: Column(
          children: [
            // Top Request Form Container
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: BuildLockTheme.orangeSoft, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: BuildLockTheme.orange, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AI Smart Broadcast Radar', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
                          Text('Broadcast to nearby shops & auto-rank with AI', style: TextStyle(color: Colors.black54, fontSize: 12)),
                        ],
                      ),
                      const Spacer(),
                      BLBadge(_quotesReceived ? '3 QUOTES IN' : (_isSearching ? 'PINGING SHOPS' : 'READY'), color: _quotesReceived ? BuildLockTheme.green : (_isSearching ? BuildLockTheme.orange : BuildLockTheme.navy)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: selectedMaterial,
                    items: const [
                      DropdownMenuItem(value: 'M-Sand • 20 Ton', child: Text('M-Sand • 20 Ton')),
                      DropdownMenuItem(value: 'OPC 53 Cement • 250 Bags', child: Text('OPC 53 Cement • 250 Bags')),
                      DropdownMenuItem(value: 'TMT Steel • 5 Ton', child: Text('TMT Steel • 5 Ton')),
                    ],
                    onChanged: (v) => setState(() => selectedMaterial = v!),
                    decoration: const InputDecoration(labelText: 'Select Material to Broadcast'),
                  ),
                  const SizedBox(height: 14),
                  primaryButton(
                    _isSearching ? '⚡ Radar Active (00:$_countdown)' : '🚀 BROADCAST TO NEARBY SHOPS',
                    _startRapidoRadar,
                    icon: Icons.radar,
                  ),
                ],
              ),
            ),

            // Live Map View with Radar Animation
            Expanded(
              child: Stack(
                children: [
                  InteractiveMapView(showRoute: _quotesReceived),

                  if (_isSearching && !_quotesReceived)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black12,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: BuildLockTheme.orange.withValues(alpha: 0.25),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: BuildLockTheme.orange, width: 2),
                                ),
                                child: const Center(
                                  child: Icon(Icons.radar, color: BuildLockTheme.orange, size: 54),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: BuildLockTheme.navy,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Pinging 24 nearby stock yards... (00:$_countdown)',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // AI Match Supplier Counter-Quotes Bottom Sheet
                  if (_quotesReceived)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 16)],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                BLBadge('🤖 AI BEST MATCH RECOMMENDATION', color: BuildLockTheme.orange, icon: Icons.auto_awesome),
                                Spacer(),
                                Text('3 Counter-Quotes', style: TextStyle(color: BuildLockTheme.navy, fontWeight: FontWeight.w900, fontSize: 13)),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // AI Top Match Card
                            BLCard(
                              padding: const EdgeInsets.all(12),
                              color: BuildLockTheme.greenSoft,
                              border: Border.all(color: BuildLockTheme.green),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text('Shree Sai Materials Yard', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: BuildLockTheme.navy)),
                                      Spacer(),
                                      BLBadge('⭐ 4.8 TRUST', color: BuildLockTheme.green),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text('🏆 AI Analysis: Best Overall Match (Price + Delivery 45m + 96% Trust)', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w900, fontSize: 12)),
                                  const SizedBox(height: 6),
                                  const Text('Negotiated Price: ₹2,350/Ton • Total ₹57,230', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
                                  const SizedBox(height: 12),
                                  primaryButton(
                                    'Accept Quote with Digital Signature',
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const OrderAgreementScreen()),
                                    ),
                                    icon: Icons.draw,
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
          ],
        ),
      );
}

// 3. Material Categories Screen
class MaterialCategoriesScreen extends StatelessWidget {
  const MaterialCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Cement', 'icon': Icons.water_drop_outlined, 'selected': false},
      {'name': 'Steel', 'icon': Icons.view_in_ar, 'selected': false},
      {'name': 'Sand', 'icon': Icons.terrain, 'selected': true},
      {'name': 'Bricks', 'icon': Icons.grid_4x4, 'selected': false},
      {'name': 'Blocks', 'icon': Icons.widgets_outlined, 'selected': false},
      {'name': 'Aggregate', 'icon': Icons.grain, 'selected': false},
      {'name': 'Tiles', 'icon': Icons.square_foot, 'selected': false},
      {'name': 'Pipes', 'icon': Icons.plumbing, 'selected': false},
      {'name': 'Electrical', 'icon': Icons.electrical_services, 'selected': false},
      {'name': 'Plumbing', 'icon': Icons.sanitizer, 'selected': false},
      {'name': 'Hardware', 'icon': Icons.build_outlined, 'selected': false},
      {'name': 'Other', 'icon': Icons.more_horiz, 'selected': false},
    ];

    return Scaffold(
      appBar: const BLTopBar(title: 'Select Category'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search cement, steel, sand...',
            ),
          ),
          const SizedBox(height: 20),
          const BLSectionTitle('Material Categories'),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, i) {
              final isSel = categories[i]['selected'] as bool;
              return BLCard(
                color: isSel ? BuildLockTheme.orangeSoft : Colors.white,
                border: Border.all(color: isSel ? BuildLockTheme.orange : BuildLockTheme.border, width: isSel ? 2 : 1),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MaterialSpecificationScreen(
                      materialName: categories[i]['name'] as String,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categories[i]['icon'] as IconData, color: isSel ? BuildLockTheme.orange : BuildLockTheme.navy, size: 30),
                    const SizedBox(height: 8),
                    Text(
                      categories[i]['name'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSel ? FontWeight.w900 : FontWeight.w700,
                        color: isSel ? BuildLockTheme.orange : BuildLockTheme.navy,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 4. Material Specification Screen
class MaterialSpecificationScreen extends StatelessWidget {
  final String materialName;
  const MaterialSpecificationScreen({super.key, this.materialName = 'M-Sand'});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BLTopBar(title: materialName),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: BuildLockTheme.navy,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.terrain, size: 140, color: Colors.white.withValues(alpha: 0.1)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.terrain, size: 56, color: BuildLockTheme.orange),
                      const SizedBox(height: 8),
                      Text(
                        materialName,
                        style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 2),
                      const Text('Construction grade manufactured sand', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    initialValue: 'Ton',
                    items: const [
                      DropdownMenuItem(value: 'Ton', child: Text('Ton')),
                      DropdownMenuItem(value: 'Bags', child: Text('Bags')),
                    ],
                    onChanged: (v) {},
                    decoration: const InputDecoration(labelText: 'Unit'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: 'Standard',
              items: const [
                DropdownMenuItem(value: 'Standard', child: Text('Standard Quality')),
                DropdownMenuItem(value: 'Premium', child: Text('Premium Heavy Grade')),
              ],
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'Quality Grade'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: 'Today',
              items: const [
                DropdownMenuItem(value: 'Today', child: Text('Today')),
                DropdownMenuItem(value: 'Tomorrow', child: Text('Tomorrow')),
              ],
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'Required Date'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: '3–5 PM',
              items: const [
                DropdownMenuItem(value: '3–5 PM', child: Text('3–5 PM Delivery Window')),
                DropdownMenuItem(value: '5–7 PM', child: Text('5–7 PM Delivery Window')),
              ],
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'Delivery Time'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: 'Moshi, Pune',
              items: const [
                DropdownMenuItem(value: 'Moshi, Pune', child: Text('Moshi, Pune Site')),
                DropdownMenuItem(value: 'Baner, Pune', child: Text('Baner, Pune Site')),
              ],
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'Project Site Location'),
            ),
            const SizedBox(height: 24),
            primaryButton('Search Suppliers', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupplierListScreen()),
              );
            }),
          ],
        ),
      );
}

// 5. Supplier List Screen
class SupplierListScreen extends StatelessWidget {
  const SupplierListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BLTopBar(
          title: 'M-Sand • 20 Ton | Moshi, Pune',
          actions: [
            IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MapViewScreen()),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: BuildLockTheme.bg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: BuildLockTheme.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text('List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const MapViewScreen()),
                              ),
                              child: const Center(
                                child: Text('Map', style: TextStyle(color: BuildLockTheme.navy, fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text('18 suppliers available', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const Spacer(),
                  const Text('Sort', style: TextStyle(color: BuildLockTheme.navy, fontWeight: FontWeight.w700, fontSize: 13)),
                  const SizedBox(width: 12),
                  const Text('Filter', style: TextStyle(color: BuildLockTheme.orange, fontWeight: FontWeight.w800, fontSize: 13)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSupplierCard(
                    context,
                    name: 'Shree Sai Materials',
                    rating: '⭐ 4.7 (128)',
                    dist: '2.1 km',
                    stock: '80 Ton in stock',
                    price: '₹2,350 / Ton',
                    delivery: 'Today, 3–5 PM',
                  ),
                  _buildSupplierCard(
                    context,
                    name: 'AB Construction',
                    rating: '⭐ 4.6 (96)',
                    dist: '3.4 km',
                    stock: '120 Ton in stock',
                    price: '₹2,320 / Ton',
                    delivery: 'Today, 4–6 PM',
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildSupplierCard(
    BuildContext context, {
    required String name,
    required String rating,
    required String dist,
    required String stock,
    required String price,
    required String delivery,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: BLCard(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SupplierDetailScreen()),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BLBadge('✓ VERIFIED'),
                  const Spacer(),
                  Text(dist, style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
              const SizedBox(height: 2),
              Text(rating, style: const TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.inventory_2_outlined, size: 16, color: BuildLockTheme.green),
                  const SizedBox(width: 4),
                  Text(stock, style: const TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w800, fontSize: 13)),
                  const Spacer(),
                  Text(price, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: BuildLockTheme.navy)),
                ],
              ),
              const SizedBox(height: 4),
              Text('Delivery $delivery', style: const TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 12),
              primaryButton(
                'Request Quote',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DirectRequestScreen()),
                ),
              ),
            ],
          ),
        ),
      );
}

// 6. Map View Screen
class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'M-Sand • 20 Ton | Moshi, Pune'),
        body: Stack(
          children: [
            InteractiveMapView(
              onPinTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupplierDetailScreen()),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('18 suppliers available • 3.3 km', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                    const SizedBox(height: 12),
                    BLCard(
                      padding: const EdgeInsets.all(12),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SupplierDetailScreen()),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Shree Sai Materials', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: BuildLockTheme.navy)),
                                SizedBox(height: 2),
                                Text('₹2,350 / Ton • Today 3–5 PM', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w800, fontSize: 12)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BuildLockTheme.orange,
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SupplierDetailScreen()),
                              ),
                              child: const Text('View', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
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
      );
}

// 7. Supplier Counter-Quotes Screen with AI Match Assistant
class SupplierResponsesScreen extends StatefulWidget {
  const SupplierResponsesScreen({super.key});

  @override
  State<SupplierResponsesScreen> createState() => _SupplierResponsesScreenState();
}

class _SupplierResponsesScreenState extends State<SupplierResponsesScreen> {
  String selectedDate = 'Today (07 Oct)';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'AI Ranked Counter-Quotes'),
        body: Column(
          children: [
            // AI Match Assistant Banner
            Container(
              padding: const EdgeInsets.all(12),
              color: BuildLockTheme.navy,
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: BuildLockTheme.orange, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '🤖 AI Match: Analyzing 6 quotes by Price, 45m Delivery & 96% Supplier Trust Score',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            // Live Timer Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: BuildLockTheme.orangeSoft,
              child: const Row(
                children: [
                  Icon(Icons.timer, color: BuildLockTheme.orange, size: 18),
                  SizedBox(width: 8),
                  Text('Active response period: ', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: BuildLockTheme.navy)),
                  Text('08:42 remaining', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: BuildLockTheme.orange)),
                ],
              ),
            ),

            // Supplier Responses List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildResponseCard(
                    context,
                    supplier: 'Shree Sai Materials',
                    rating: '⭐ 4.8 (128 ratings) • 96% Fulfilment',
                    dist: '2.1 km • Moshi Site',
                    origPrice: '₹2,500/Ton',
                    counterPrice: '₹2,350/Ton',
                    totalPrice: '₹57,230 Total',
                    delivery: 'Today 3–5 PM (45m Arrival)',
                    aiTag: '🏆 AI TOP OVERALL MATCH',
                    tagColor: BuildLockTheme.green,
                  ),
                  _buildResponseCard(
                    context,
                    supplier: 'AB Construction',
                    rating: '⭐ 4.6 (96 ratings) • 94% Fulfilment',
                    dist: '3.4 km • Moshi Site',
                    origPrice: '₹2,500/Ton',
                    counterPrice: '₹2,320/Ton',
                    totalPrice: '₹58,400 Total',
                    delivery: 'Today 4–6 PM',
                    aiTag: '💰 AI LOWEST FARE MATCH',
                    tagColor: BuildLockTheme.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildResponseCard(
    BuildContext context, {
    required String supplier,
    required String rating,
    required String dist,
    required String origPrice,
    required String counterPrice,
    required String totalPrice,
    required String delivery,
    required String aiTag,
    required Color tagColor,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: BLCard(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QuoteDetailScreen()),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BLBadge(aiTag, color: tagColor, icon: Icons.auto_awesome),
                  const Spacer(),
                  Text(dist, style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              Text(supplier, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
              Text(rating, style: const TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: BuildLockTheme.bg, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Original: $origPrice', style: const TextStyle(color: Colors.black45, fontSize: 11, decoration: TextDecoration.lineThrough)),
                        Text('Counter: $counterPrice', style: const TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.green, fontSize: 15)),
                      ],
                    ),
                    const Spacer(),
                    Text(totalPrice, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('🚚 Delivery Window: $delivery', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: BuildLockTheme.navy)),
              const SizedBox(height: 12),
              primaryButton(
                'Accept Quote & Digital Signature',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuoteDetailScreen()),
                ),
                icon: Icons.draw,
              ),
            ],
          ),
        ),
      );
}

// 8. Quote Detail Screen
class QuoteDetailScreen extends StatelessWidget {
  const QuoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Quote Detail'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(color: BuildLockTheme.orangeSoft, shape: BoxShape.circle),
                  child: const Icon(Icons.storefront, color: BuildLockTheme.orange, size: 28),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shree Sai Materials', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                    Text('⭐ 4.8 (128 ratings) • Verified Supplier', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Final Price Breakdown', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
                  SizedBox(height: 12),
                  Row(children: [Text('Material (20 Ton M-Sand)'), Spacer(), Text('₹47,000', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 8),
                  Row(children: [Text('Delivery Charge'), Spacer(), Text('₹1,500', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 8),
                  Row(children: [Text('GST (18%)'), Spacer(), Text('₹8,730', style: TextStyle(fontWeight: FontWeight.w800))]),
                  Divider(height: 28),
                  Row(children: [
                    Text('Total Payable Amount', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                    Spacer(),
                    Text('₹57,230', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: BuildLockTheme.navy)),
                  ]),
                  SizedBox(height: 12),
                  Text('Delivery Slot: Today, 3–5 PM • Moshi Site', style: TextStyle(fontWeight: FontWeight.w700, color: BuildLockTheme.green)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            primaryButton(
              'Proceed to Digital Consent & Signature',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderAgreementScreen()),
              ),
              icon: Icons.draw,
            ),
          ],
        ),
      );
}

// 9. Digital Agreement & OTP Consent Screen (Contractor Mandatory Signature)
class OrderAgreementScreen extends StatefulWidget {
  const OrderAgreementScreen({super.key});

  @override
  State<OrderAgreementScreen> createState() => _OrderAgreementScreenState();
}

class _OrderAgreementScreenState extends State<OrderAgreementScreen> {
  final TextEditingController _otpConsentController = TextEditingController(text: '4829');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Digital Agreement'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BLBadge('MANDATORY CONTRACTOR DIGITAL CONSENT'),
                  SizedBox(height: 14),
                  Text('✓ I agree to the negotiated price, quantity and delivery window.', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                  SizedBox(height: 10),
                  Text('✓ I accept the dispute and non-cancellation policy.', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                  SizedBox(height: 10),
                  Text('✓ I provide my digital signature consent to lock this order.', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text('Contractor Digital Signature', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
            const SizedBox(height: 8),
            const SignaturePad(),
            const SizedBox(height: 20),

            const Text('Enter 4-Digit Consent OTP', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: BuildLockTheme.navy)),
            const SizedBox(height: 8),
            TextField(
              controller: _otpConsentController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4),
              decoration: const InputDecoration(
                labelText: 'Contractor Consent OTP',
                prefixIcon: Icon(Icons.lock, color: BuildLockTheme.orange),
              ),
            ),
            const SizedBox(height: 24),

            primaryButton(
              'Sign & Proceed to Payment',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentScreen()),
              ),
            ),
          ],
        ),
      );
}

// 10. Payment Screen
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Order Payment'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(child: Text('₹57,230', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: BuildLockTheme.navy))),
            const Center(child: Text('Order #BL001245 • M-Sand 20 Ton', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600))),
            const SizedBox(height: 24),

            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
                  SizedBox(height: 14),
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet, color: BuildLockTheme.orange),
                    title: Text('UPI (GPay / PhonePe / Paytm)', style: TextStyle(fontWeight: FontWeight.w800)),
                    trailing: Icon(Icons.check_circle, color: BuildLockTheme.orange),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card, color: Colors.black45),
                    title: Text('Credit / Debit Card'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const BLCard(
              color: BuildLockTheme.greenSoft,
              child: Row(
                children: [
                  Icon(Icons.shield_outlined, color: BuildLockTheme.green, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Protected Escrow. Payment released to supplier only after delivery verification & OTP match at site!',
                      style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w800, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            primaryButton(
              'Pay ₹57,230 & Lock Order',
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LocationOtpConfirmationScreen()),
              ),
              icon: Icons.lock,
            ),
          ],
        ),
      );
}

// 11. Location & OTP Confirmation Screen
class LocationOtpConfirmationScreen extends StatelessWidget {
  const LocationOtpConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Order Confirmed', back: false),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: BuildLockTheme.greenSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, size: 72, color: BuildLockTheme.green),
              ),
            ),
            const SizedBox(height: 16),
            const Center(child: Text('ORDER LOCKED & CONFIRMED ✓', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: BuildLockTheme.navy))),
            const Center(child: Text('Order #BL001245 • M-Sand 20 Ton', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600))),
            const SizedBox(height: 24),

            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BLBadge('LOCATION GPS VERIFIED', color: BuildLockTheme.green, icon: Icons.my_location),
                  SizedBox(height: 8),
                  Text('Site Address:', style: TextStyle(color: Colors.black54, fontSize: 12)),
                  Text('Moshi Project Site, Sector 4, Pune', style: TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.navy)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: BuildLockTheme.navy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Text('DELIVERY VERIFICATION OTP CODE', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
                  SizedBox(height: 8),
                  Text('4  8  2  9', style: TextStyle(color: BuildLockTheme.orange, fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: 10)),
                  SizedBox(height: 4),
                  Text('Share this OTP with driver Rajesh Kumar upon unloading material at site.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 28),

            primaryButton(
              'Track Live Delivery on Map',
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LiveOrderTrackingScreen()),
              ),
              icon: Icons.navigation,
            ),
          ],
        ),
      );
}

// 12. Live Order Tracking Screen
class LiveOrderTrackingScreen extends StatelessWidget {
  const LiveOrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Order #BL001245 Tracking'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BLBadge('Out for Delivery', color: BuildLockTheme.green, icon: Icons.local_shipping),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Confirmed ✓', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: BuildLockTheme.green)),
                      Text('Loading ✓', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: BuildLockTheme.green)),
                      Text('Dispatched 🚚', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: BuildLockTheme.orange)),
                      Text('Delivered', style: TextStyle(fontSize: 10, color: Colors.black38)),
                    ],
                  ),
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
            const SizedBox(height: 16),

            const BLCard(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estimated Arrival', style: TextStyle(color: Colors.black54, fontSize: 12)),
                      Text('32 minutes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Driver: Rajesh Kumar', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                      Text('MH12AB1234 • Loader: Suresh', style: TextStyle(color: Colors.black54, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            primaryButton(
              'Verify Delivery at Site (POD OTP)',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DeliveryVerificationScreen()),
              ),
            ),
          ],
        ),
      );
}

// 13. Delivery Verification Screen
class DeliveryVerificationScreen extends StatelessWidget {
  const DeliveryVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Verify Delivery (POD)'),
        body: const DeliveryVerificationForm(),
      );
}

class DeliveryVerificationForm extends StatefulWidget {
  const DeliveryVerificationForm({super.key});

  @override
  State<DeliveryVerificationForm> createState() => _DeliveryVerificationFormState();
}

class _DeliveryVerificationFormState extends State<DeliveryVerificationForm> {
  int receivedQty = 20;
  final TextEditingController _driverOtpController = TextEditingController(text: '4829');

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Expected Quantity', style: TextStyle(color: Colors.black54)),
          const Text('20 Ton M-Sand', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
          const SizedBox(height: 18),

          BLCard(
            child: Row(
              children: [
                const Text('Received Quantity', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                const Spacer(),
                IconButton(
                  onPressed: () => setState(() { if (receivedQty > 0) receivedQty--; }),
                  icon: const Icon(Icons.remove_circle_outline, color: BuildLockTheme.orange),
                ),
                Text('$receivedQty Ton', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                IconButton(
                  onPressed: () => setState(() => receivedQty++),
                  icon: const Icon(Icons.add_circle_outline, color: BuildLockTheme.orange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

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
                const Text('Enter Driver OTP to Confirm Unloading', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                const SizedBox(height: 6),
                TextField(
                  controller: _driverOtpController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4),
                  decoration: const InputDecoration(
                    labelText: 'Driver Delivery OTP',
                    prefixIcon: Icon(Icons.verified_user, color: BuildLockTheme.orange),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          primaryButton(
            'Confirm OTP & Release Escrow Funds',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrderCompletedScreen()),
            ),
            icon: Icons.check_circle,
          ),
        ],
      );
}

// 14. Order Completed Screen
class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: BuildLockTheme.greenSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle, size: 80, color: BuildLockTheme.green),
                ),
                const SizedBox(height: 20),
                const Text('Completed & Settled ✓', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                const SizedBox(height: 4),
                const Text('Order #BL001245 • M-Sand 20 Ton', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                const Text('₹57,230 Released to Supplier', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: BuildLockTheme.green)),
                const SizedBox(height: 4),
                const Text('Delivered 07 Oct 2024 • 4:18 PM • Moshi Site', style: TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(height: 32),
                primaryButton('Rate Supplier Experience', () {}),
                const SizedBox(height: 12),
                outlineButton('Download Tax Invoice & POD PDF', () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invoice & Digital POD downloaded successfully ✓')));
                }),
              ],
            ),
          ),
        ),
      );
}

// Direct Request Screen
class DirectRequestScreen extends StatelessWidget {
  const DirectRequestScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Request Material'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('M-Sand (Manufactured Sand)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
            const SizedBox(height: 18),
            const TextField(decoration: InputDecoration(labelText: 'Quantity', suffixText: 'Ton')),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Delivery Date', hintText: 'Today')),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Delivery Window Slot', hintText: '3–5 PM')),
            const SizedBox(height: 12),
            const TextField(maxLines: 3, decoration: InputDecoration(labelText: 'Special Site Instructions')),
            const SizedBox(height: 24),
            primaryButton('Send Direct Request', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RequestSentScreen()),
              );
            }),
          ],
        ),
      );
}

class RequestSentScreen extends StatelessWidget {
  const RequestSentScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 90, color: BuildLockTheme.green),
                const SizedBox(height: 20),
                const Text('Request Sent ✓', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                const SizedBox(height: 8),
                const Text(
                  'Supplier has been notified. Response expected within 15 minutes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 28),
                primaryButton(
                  'View Supplier Counter-Quotes',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SupplierResponsesScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// Supplier Detail Screen
class SupplierDetailScreen extends StatelessWidget {
  const SupplierDetailScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(color: BuildLockTheme.orangeSoft, borderRadius: BorderRadius.circular(24)),
                child: const Icon(Icons.storefront, size: 44, color: BuildLockTheme.orange),
              ),
            ),
            const SizedBox(height: 12),
            const Center(child: Text('Shree Sai Materials', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: BuildLockTheme.navy))),
            const SizedBox(height: 4),
            const Center(child: Text('⭐ 4.8 (128 ratings)', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600))),
            const SizedBox(height: 6),
            const Center(child: BLBadge('✓ VERIFIED SUPPLIER')),
            const SizedBox(height: 20),

            const Row(
              children: [
                Expanded(child: BLStat(value: '96%', label: 'Fulfilment Rate', icon: Icons.verified_outlined, color: BuildLockTheme.green)),
                SizedBox(width: 8),
                Expanded(child: BLStat(value: '94%', label: 'On-time Delivery', icon: Icons.schedule, color: BuildLockTheme.green)),
                SizedBox(width: 8),
                Expanded(child: BLStat(value: '1.2%', label: 'Cancellation', icon: Icons.cancel_outlined, color: BuildLockTheme.red)),
              ],
            ),
            const SizedBox(height: 16),

            BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('M-Sand Ready Stock', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const SizedBox(height: 6),
                  const Text('120 Ton available in stock', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 2),
                  const Text('Stock confirmed 8 minutes ago', style: TextStyle(color: Colors.black45, fontSize: 12)),
                  const Divider(height: 24),
                  const Text('₹2,350 / Ton', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  const SizedBox(height: 4),
                  const Text('Delivery Today, 3–5 PM'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: outlineButton('Call', () {})),
                const SizedBox(width: 10),
                Expanded(child: outlineButton('Chat', () {})),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: primaryButton(
                    'Request Quote',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DirectRequestScreen()),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

// Contractor Orders Screen
class ContractorOrdersScreen extends StatelessWidget {
  const ContractorOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'My Orders & Pipeline', back: false),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const BLSectionTitle('Active Pipeline & Orders'),
            const SizedBox(height: 12),

            _buildOrderStageCard(
              context,
              title: 'Rapido Broadcast & AI Match',
              sub: 'Ping 24 nearby yards & rank counter-quotes with AI',
              badge: '1. AI Broadcast',
              color: BuildLockTheme.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RapidoBroadcastScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'AI Ranked Counter-Quotes',
              sub: 'Ranked by Price, 45m Delivery Time & ⭐ 4.8 Rating',
              badge: '2. AI Counter-Quotes',
              color: BuildLockTheme.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupplierResponsesScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'Quote Detail (Shree Sai Materials)',
              sub: 'Negotiated Total: ₹57,230 • Today 3–5 PM',
              badge: '3. Quote Detail',
              color: BuildLockTheme.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuoteDetailScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'Digital Agreement & Signature (#BL001245)',
              sub: 'Mandatory Contractor Signature & Consent OTP',
              badge: '4. Digital Signature',
              color: BuildLockTheme.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderAgreementScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'Payment & Escrow Lock (₹57,230)',
              sub: 'UPI / Cards • Protected Escrow',
              badge: '5. Escrow Pay',
              color: BuildLockTheme.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'Location & Delivery OTP Confirmation',
              sub: 'GPS Location Verified • Delivery OTP: 4829',
              badge: '6. Order Lock',
              color: BuildLockTheme.green,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LocationOtpConfirmationScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'Order Live Map Tracking (#BL001245)',
              sub: 'Out for Delivery • ETA 32 min • Driver Rajesh',
              badge: '7. Live Tracking',
              color: BuildLockTheme.green,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveOrderTrackingScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'Delivery Verification at Site (POD)',
              sub: 'Verify quantity, site photos & driver OTP',
              badge: '8. Verify POD',
              color: BuildLockTheme.green,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryVerificationScreen())),
            ),

            _buildOrderStageCard(
              context,
              title: 'Order Completed & Settled (#BL001245)',
              sub: 'Delivered 07 Oct • Rate supplier & PDF invoice',
              badge: '9. Completed',
              color: BuildLockTheme.green,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderCompletedScreen())),
            ),
          ],
        ),
      );

  Widget _buildOrderStageCard(
    BuildContext context, {
    required String title,
    required String sub,
    required String badge,
    required Color color,
    required VoidCallback onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: BLCard(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BLBadge(badge, color: color),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: BuildLockTheme.orange),
                ],
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
              const SizedBox(height: 2),
              Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 13)),
            ],
          ),
        ),
      );
}

// Contractor Profile Screen
class ContractorProfileScreen extends StatelessWidget {
  const ContractorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Profile', back: false),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(child: CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42))),
            const SizedBox(height: 10),
            const Center(child: Text('Rohan Patil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: BuildLockTheme.navy))),
            const Center(child: BLBadge('VERIFIED CONTRACTOR')),
            const SizedBox(height: 24),
            ...['My Projects', 'Payments', 'Documents', 'Notifications', 'Settings'].map(
              (x) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BLCard(
                  child: Row(
                    children: [
                      Text(x, style: const TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.navy)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black38),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

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
