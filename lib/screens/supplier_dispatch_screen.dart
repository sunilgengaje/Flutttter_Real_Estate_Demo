import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import 'live_delivery_tracking_screen.dart';

class SupplierDispatchScreen extends StatefulWidget {
  const SupplierDispatchScreen({super.key});

  @override
  State<SupplierDispatchScreen> createState() => _SupplierDispatchScreenState();
}

class _SupplierDispatchScreenState extends State<SupplierDispatchScreen> {
  String _selectedVehicle = 'Mini Truck (Tata Ace)';
  final TextEditingController _vehicleRegController = TextEditingController(text: 'MH12AB1234');
  final TextEditingController _driverNameController = TextEditingController(text: 'Rajesh Kumar');
  final TextEditingController _driverPhoneController = TextEditingController(text: '+91 98765 00000');
  int _loadersAssigned = 3;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Logistics Dispatch & Loading'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Assign Vehicle & Logistics Crew', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
            const SizedBox(height: 14),

            // Vehicle Selector Dropdown
            DropdownButtonFormField<String>(
              initialValue: _selectedVehicle,
              items: const [
                DropdownMenuItem(value: 'Mini Truck (Tata Ace)', child: Text('Mini Truck (Tata Ace)')),
                DropdownMenuItem(value: '3-Wheeler Pickup', child: Text('3-Wheeler Pickup')),
                DropdownMenuItem(value: '8ft Flatbed Truck', child: Text('8ft Flatbed Truck')),
                DropdownMenuItem(value: '16-Ton Heavy Tipper', child: Text('16-Ton Heavy Tipper')),
              ],
              onChanged: (v) => setState(() => _selectedVehicle = v!),
              decoration: const InputDecoration(
                labelText: 'Vehicle Type',
                prefixIcon: Icon(Icons.local_shipping, color: BuildLockTheme.orange),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _vehicleRegController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Registration Number',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _driverNameController,
                    decoration: const InputDecoration(
                      labelText: 'Driver Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _driverPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Driver Mobile',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Loading Crew Checklist Counter (Clean, overflow-free)
            BLCard(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.groups, color: BuildLockTheme.orange, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Loading Crew Assigned',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: BuildLockTheme.navy),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                    onPressed: () => setState(() { if (_loadersAssigned > 1) _loadersAssigned--; }),
                    icon: const Icon(Icons.remove_circle_outline, color: BuildLockTheme.orange, size: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text('$_loadersAssigned Loaders', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                    onPressed: () => setState(() => _loadersAssigned++),
                    icon: const Icon(Icons.add_circle_outline, color: BuildLockTheme.orange, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Proof of Dispatch 2-Slot Media Uploader Grid
            const Text('Proof of Dispatch Media Capture', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: BuildLockTheme.orange, width: 1.5),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: BuildLockTheme.orange, size: 32),
                        SizedBox(height: 6),
                        Text('Weighbridge Slip Photo', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: BuildLockTheme.navy)),
                        BLBadge('CAPTURED ✓', color: BuildLockTheme.green),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: BuildLockTheme.orange, width: 1.5),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, color: BuildLockTheme.orange, size: 32),
                        SizedBox(height: 6),
                        Text('Loaded Truck Bed Photo', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: BuildLockTheme.navy)),
                        BLBadge('CAPTURED ✓', color: BuildLockTheme.green),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Slide-to-Confirm Action Bar
            SlideToConfirmBar(
              text: 'SLIDE TO DISPATCH MATERIAL 🚚',
              onConfirmed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LiveDeliveryTrackingScreen()),
                );
              },
            ),
          ],
        ),
      );
}
