import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import '../widgets/map_widget.dart';
import 'broadcast_bidding_sheet.dart';

class MaterialHomeScreen extends StatefulWidget {
  const MaterialHomeScreen({super.key});

  @override
  State<MaterialHomeScreen> createState() => _MaterialHomeScreenState();
}

class _MaterialHomeScreenState extends State<MaterialHomeScreen> {
  final String _pickupLocation = 'Broadcast to Nearby Suppliers (15 km)';
  final String _dropLocation = 'Moshi Project Site, Sector 4, Pune';
  String _selectedCategory = 'Sand';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Cement', 'icon': Icons.water_drop_outlined},
    {'name': 'Steel/TMT', 'icon': Icons.view_in_ar},
    {'name': 'Sand', 'icon': Icons.terrain},
    {'name': 'Bricks', 'icon': Icons.grid_4x4},
    {'name': 'Plumbing', 'icon': Icons.plumbing},
    {'name': 'Electrical', 'icon': Icons.electrical_services},
  ];

  void _openMaterialConfiguratorModal(String categoryName) {
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
                  decoration: BoxDecoration(color: BuildLockTheme.orangeSoft, borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.tune, color: BuildLockTheme.orange),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Configure $categoryName Request', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                    const Text('Select quantity, grade & special handling tags', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantity', hintText: '20'),
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
                      DropdownMenuItem(value: 'Units', child: Text('Units')),
                    ],
                    onChanged: (v) {},
                    decoration: const InputDecoration(labelText: 'Unit'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              initialValue: 'Standard Quality',
              items: const [
                DropdownMenuItem(value: 'Standard Quality', child: Text('Standard Construction Grade')),
                DropdownMenuItem(value: 'Premium Grade', child: Text('Premium Heavy Duty Grade')),
              ],
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'Grade / Specification'),
            ),
            const SizedBox(height: 16),

            const Text('Special Handling Requirements', style: TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.navy, fontSize: 13)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(label: const Text('🏗️ Crane Needed'), selected: true, onSelected: (v) {}),
                FilterChip(label: const Text('👷 Unloading Labour Required'), selected: true, onSelected: (v) {}),
                FilterChip(label: const Text('⚡ Same-Day Delivery'), selected: true, onSelected: (v) {}),
              ],
            ),
            const SizedBox(height: 24),

            primaryButton(
              '🚀 Broadcast Rapido Request for Bids',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BroadcastBiddingSheet()),
                );
              },
              icon: Icons.radar,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Rapido Material Discovery'),
        body: Stack(
          children: [
            // Full Screen Interactive Map Canvas View
            const InteractiveMapView(showRoute: false),

            // Draggable Bottom Sheet for Rapido Pickup / Drop-off & Material Categories
            DraggableScrollableSheet(
              initialChildSize: 0.45,
              minChildSize: 0.25,
              maxChildSize: 0.85,
              builder: (context, scrollController) => Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 16)],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                      ),
                    ),

                    // Pickup & Drop Location Cards (Rapido Style)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: BuildLockTheme.bg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: BuildLockTheme.border),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.my_location, color: BuildLockTheme.orange, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _pickupLocation,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: BuildLockTheme.navy),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: BuildLockTheme.green, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _dropLocation,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: BuildLockTheme.navy),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Horizontal Material Category Selector
                    const BLSectionTitle('Select Material Category'),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, i) {
                          final cat = _categories[i];
                          final isSel = _selectedCategory == cat['name'];
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 10),
                            child: BLCard(
                              color: isSel ? BuildLockTheme.orangeSoft : Colors.white,
                              border: Border.all(color: isSel ? BuildLockTheme.orange : BuildLockTheme.border, width: isSel ? 2 : 1),
                              padding: const EdgeInsets.all(8),
                              onTap: () {
                                setState(() => _selectedCategory = cat['name'] as String);
                                _openMaterialConfiguratorModal(cat['name'] as String);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(cat['icon'] as IconData, color: isSel ? BuildLockTheme.orange : BuildLockTheme.navy, size: 28),
                                  const SizedBox(height: 6),
                                  Text(
                                    cat['name'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isSel ? FontWeight.w900 : FontWeight.w700,
                                      color: isSel ? BuildLockTheme.orange : BuildLockTheme.navy,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    primaryButton(
                      '⚡ Configure & Broadcast Request',
                      () => _openMaterialConfiguratorModal(_selectedCategory),
                      icon: Icons.tune,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
