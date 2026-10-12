import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../screens/auth_screens.dart';
import '../screens/contractor_screens.dart';
import '../screens/supplier_screens.dart';
import '../screens/admin_screens.dart';
import '../screens/video_presentation_screen.dart';

class ScreenSwitcherButton extends StatelessWidget {
  const ScreenSwitcherButton({super.key});

  static void openCatalog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: BuildLockTheme.orangeSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.grid_view, color: BuildLockTheme.orange),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('104 Screen Inventory Catalog', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
                    Text('Jump to any exact UI screen from the specification image', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Video Presentation Player Mode Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: BuildLockTheme.orange, minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoPresentationScreen()));
              },
              icon: const Icon(Icons.play_circle_fill, color: Colors.white),
              label: const Text('▶ Watch Client App Journey Video Demo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 16),

            _buildSectionHeader('ROW 1: AUTH & CONTRACTOR FLOW'),
            _buildItem(context, '1. Splash Screen', () => const SplashScreen()),
            _buildItem(context, '2. Welcome Screen', () => const WelcomeScreen()),
            _buildItem(context, '3. Role Selection', () => const RoleScreen()),
            _buildItem(context, '4. Login / OTP Verification', () => const LoginScreen()),
            _buildItem(context, '5. Contractor Home', () => const ContractorShell()),
            _buildItem(context, '6. Material Categories', () => const MaterialCategoriesScreen()),
            _buildItem(context, '7. Material Details (M-Sand)', () => const MaterialSpecificationScreen()),
            _buildItem(context, '8. Supplier List', () => const SupplierListScreen()),
            _buildItem(context, '9. Map View (Suppliers Pin Map)', () => const MapViewScreen()),

            const SizedBox(height: 16),
            _buildSectionHeader('ROW 2: CONTRACTOR NEGOTIATION & ORDER FLOW'),
            _buildItem(context, '10. Supplier Detail', () => const SupplierDetailScreen()),
            _buildItem(context, '11. Rapido-Style Broadcast & Radar Map', () => const RapidoBroadcastScreen()),
            _buildItem(context, '12. Supplier Counter-Quotes Responses', () => const SupplierResponsesScreen()),
            _buildItem(context, '13. Quote Detail & Price Breakdown', () => const QuoteDetailScreen()),
            _buildItem(context, '14. Digital Agreement & Signature', () => const OrderAgreementScreen()),
            _buildItem(context, '15. Payment Screen (Protected Escrow)', () => const PaymentScreen()),
            _buildItem(context, '16. Location & OTP Order Lock', () => const LocationOtpConfirmationScreen()),
            _buildItem(context, '17. Live Map Order Tracking', () => const LiveOrderTrackingScreen()),
            _buildItem(context, '18. Delivery Verification (Driver OTP)', () => const DeliveryVerificationScreen()),
            _buildItem(context, '19. Order Completed & Settlement', () => const OrderCompletedScreen()),

            const SizedBox(height: 16),
            _buildSectionHeader('ROW 3: SUPPLIER APP & ADMIN DASHBOARD'),
            _buildItem(context, '20. Supplier App Home', () => const SupplierShell()),
            _buildItem(context, '21. Supplier Requests List', () => const SupplierRequestsScreen()),
            _buildItem(context, '22. Send Quote (Supplier)', () => const SendQuoteScreen()),
            _buildItem(context, '23. Supplier Order Prep', () => const SupplierOrderPrepScreen()),
            _buildItem(context, '24. Dispatch Order', () => const DispatchScreen()),
            _buildItem(context, '25. Supplier Earnings', () => const SupplierEarningsScreen()),
            _buildItem(context, '26. Admin Dashboard (Web)', () => const AdminDashboardScreen()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        backgroundColor: BuildLockTheme.orange,
        foregroundColor: Colors.white,
        elevation: 6,
        icon: const Icon(Icons.grid_view),
        label: const Text('104 Screens Catalog', style: TextStyle(fontWeight: FontWeight.w900)),
        onPressed: () => openCatalog(context),
      );

  static Widget _buildSectionHeader(String title) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: BuildLockTheme.orange, letterSpacing: 0.5),
        ),
      );

  static Widget _buildItem(BuildContext context, String title, Widget Function() builder) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: BuildLockTheme.border),
          ),
          tileColor: Colors.white,
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: BuildLockTheme.navy, fontSize: 14)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: BuildLockTheme.orange),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => builder()));
          },
        ),
      );
}
