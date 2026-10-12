import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import '../widgets/map_widget.dart';
import 'signature_consent_sheet.dart';

class BroadcastBiddingSheet extends StatefulWidget {
  const BroadcastBiddingSheet({super.key});

  @override
  State<BroadcastBiddingSheet> createState() => _BroadcastBiddingSheetState();
}

class _BroadcastBiddingSheetState extends State<BroadcastBiddingSheet> {
  int _secondsRemaining = 300; // 5 Minute Timer (300s)
  Timer? _timer;
  String _selectedFilter = 'AI Best Choice';
  bool _counterOfferSent = false;
  bool _supplierAcceptedWithSignature = false;
  String _targetSupplier = '';
  String _targetPrice = '';

  void _startFiveMinuteTimer() {
    _timer?.cancel();
    _secondsRemaining = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _secondsRemaining = 300;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedFiveMinTimer {
    int m = _secondsRemaining ~/ 60;
    int s = _secondsRemaining % 60;
    String mm = m < 10 ? '0$m' : '$m';
    String ss = s < 10 ? '0$s' : '$s';
    return '$mm:$ss';
  }

  void _openCounterOfferDialog(String supplierName, String currentPrice) {
    final TextEditingController counterPriceController = TextEditingController(text: '2280');
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
                const Icon(Icons.swap_horiz, color: BuildLockTheme.orange),
                const SizedBox(width: 8),
                Text('Counter-Offer to $supplierName', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
              ],
            ),
            const SizedBox(height: 6),
            Text('Current Quote: $currentPrice • Submit target counter-rate:', style: const TextStyle(color: Colors.black54, fontSize: 13)),
            const SizedBox(height: 16),
            TextField(
              controller: counterPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target Counter Rate per Ton',
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 20),
            primaryButton(
              'Start 5-Min Timer & Send Counter-Offer',
              () {
                Navigator.pop(context);
                setState(() {
                  _counterOfferSent = true;
                  _supplierAcceptedWithSignature = false;
                  _targetSupplier = supplierName;
                  _targetPrice = '₹${counterPriceController.text}/Ton';
                  _startFiveMinuteTimer();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('5-Min counter-offer sent to $supplierName. List cleared while awaiting supplier digital signature.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _simulateSupplierAcceptance() {
    setState(() {
      _supplierAcceptedWithSignature = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('⚡ $_targetSupplier accepted counter-offer and signed digital consent ✓')),
    );
  }

  void _openSideBySideComparisonModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.compare_arrows, color: BuildLockTheme.orange),
                SizedBox(width: 8),
                Text('Side-by-Side Top Bids Comparison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
              ],
            ),
            const SizedBox(height: 16),
            BLCard(
              child: DataTable(
                columnSpacing: 12,
                columns: const [
                  DataColumn(label: Text('Feature', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12))),
                  DataColumn(label: Text('Shree Sai', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.green, fontSize: 12))),
                  DataColumn(label: Text('AB Const.', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12))),
                ],
                rows: const [
                  DataRow(cells: [DataCell(Text('Unit Rate', style: TextStyle(fontSize: 11))), DataCell(Text('₹2,350/Ton', style: TextStyle(fontSize: 11))), DataCell(Text('₹2,320/Ton', style: TextStyle(fontSize: 11)))]),
                  DataRow(cells: [DataCell(Text('Transit ETA', style: TextStyle(fontSize: 11))), DataCell(Text('45 Mins ⚡', style: TextStyle(fontSize: 11))), DataCell(Text('90 Mins', style: TextStyle(fontSize: 11)))]),
                  DataRow(cells: [DataCell(Text('Supplier Consent', style: TextStyle(fontSize: 11))), DataCell(Text('Signed ✓', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w900, fontSize: 11))), DataCell(Text('Signed ✓', style: TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w900, fontSize: 11)))]),
                  DataRow(cells: [DataCell(Text('AI Match', style: TextStyle(fontSize: 11))), DataCell(Text('96% Optimal', style: TextStyle(fontWeight: FontWeight.w900, color: BuildLockTheme.green, fontSize: 11))), DataCell(Text('88%', style: TextStyle(fontSize: 11)))]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            primaryButton(
              'Select Shree Sai Materials (96% AI Match)',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignatureConsentSheet()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Finding You the Best Deal'),
        body: Column(
          children: [
            // Live 5-Minute Synchronized Timer Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: BuildLockTheme.navy,
              child: Row(
                children: [
                  const Icon(Icons.timer, color: BuildLockTheme.orange, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_counterOfferSent ? '5-Min Counter-Offer Timer Active' : 'Broadcast Counter-Quotes Window', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
                        Text(_counterOfferSent ? 'Awaiting $_targetSupplier digital signature consent' : 'Suppliers submitting live counter-quotes', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ),
                  Text('⏱ $_formattedFiveMinTimer', style: const TextStyle(color: BuildLockTheme.orange, fontWeight: FontWeight.w900, fontSize: 16)),
                ],
              ),
            ),

            // AI Matchmaking & Smart Sorting Pills Bar (if list visible)
            if (!_counterOfferSent || _supplierAcceptedWithSignature)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('AI Best Choice'),
                      _buildFilterChip('Lowest Price'),
                      _buildFilterChip('Fastest ETA'),
                      _buildFilterChip('Highest Rated'),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.compare_arrows, color: BuildLockTheme.orange, size: 20),
                        tooltip: 'Compare Top Bids',
                        onPressed: _openSideBySideComparisonModal,
                      ),
                    ],
                  ),
                ),
              ),

            // Map Area Canvas View & Dynamic Sheet State
            Expanded(
              child: Stack(
                children: [
                  const InteractiveMapView(showRoute: true),

                  // STATE A: Counter-Offer Sent -> List Removed & Waiting for Supplier Signed Consent (Clean, Overflow-Free)
                  if (_counterOfferSent && !_supplierAcceptedWithSignature)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 16)],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              children: [
                                SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: BuildLockTheme.orange, strokeWidth: 2)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text('Waiting for Supplier Digital Signature...', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: BuildLockTheme.navy)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            BLCard(
                              color: BuildLockTheme.orangeSoft,
                              border: Border.all(color: BuildLockTheme.orange),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Counter-Offer Sent to $_targetSupplier', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: BuildLockTheme.navy)),
                                  const SizedBox(height: 2),
                                  Text('Target Rate: $_targetPrice • 5-Min Timer: ⏱ $_formattedFiveMinTimer', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                  const SizedBox(height: 2),
                                  const Text('Quote list cleared. Waiting for supplier to accept & sign.', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            primaryButton(
                              '⚡ [Demo] Simulate Supplier Signature',
                              _simulateSupplierAcceptance,
                              icon: Icons.check_circle,
                            ),
                            const SizedBox(height: 8),
                            outlineButton('Cancel Counter-Offer', () {
                              setState(() {
                                _counterOfferSent = false;
                              });
                            }),
                          ],
                        ),
                      ),
                    ),

                  // STATE B: Supplier Accepted & Signed OR Initial Quotes List View
                  if (!_counterOfferSent || _supplierAcceptedWithSignature)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: MediaQuery.of(context).size.height * 0.28,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 16)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 36,
                                height: 4,
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Row(
                              children: [
                                BLBadge(_supplierAcceptedWithSignature ? 'SUPPLIER SIGNED ACCEPTANCE RECEIVED ✓' : '3 SUPPLIER SIGNED QUOTES IN', color: BuildLockTheme.green),
                                const Spacer(),
                                const Text('Timer ⏱', style: TextStyle(color: BuildLockTheme.orange, fontWeight: FontWeight.w900, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Scrollable Supplier Quote Cards
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.only(bottom: 20),
                                children: [
                                  if (_supplierAcceptedWithSignature)
                                    _buildSupplierQuoteCard(
                                      context,
                                      supplier: _targetSupplier,
                                      rating: '⭐ 4.9 (128 ratings) • Supplier Signed Consent ✓',
                                      dist: '2.1 km away',
                                      price: 'Target $_targetPrice • Total ₹57,230',
                                      eta: '45 min ETA Today',
                                      aiBadgeText: '🏆 COUNTER ACCEPTED & SIGNED BY SUPPLIER',
                                      isBest: true,
                                    ),
                                  if (!_supplierAcceptedWithSignature) ...[
                                    _buildSupplierQuoteCard(
                                      context,
                                      supplier: 'Shree Sai Materials Yard',
                                      rating: '⭐ 4.9 (128 ratings) • Supplier Signed Consent ✓',
                                      dist: '2.1 km away',
                                      price: '₹2,350 / Ton • Total ₹57,230',
                                      eta: '45 min ETA Today',
                                      aiBadgeText: '🏆 96% AI BEST MATCH',
                                      isBest: true,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildSupplierQuoteCard(
                                      context,
                                      supplier: 'AB Construction Yard',
                                      rating: '⭐ 4.6 (96 ratings) • Supplier Signed Consent ✓',
                                      dist: '3.4 km away',
                                      price: '₹2,320 / Ton • Total ₹58,400',
                                      eta: '90 min ETA Today',
                                      aiBadgeText: '💰 LOWEST PRICE',
                                      isBest: false,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildSupplierQuoteCard(
                                      context,
                                      supplier: 'Morya Suppliers Yard',
                                      rating: '⭐ 4.5 (82 ratings) • Supplier Signed Consent ✓',
                                      dist: '4.8 km away',
                                      price: '₹2,400 / Ton • Total ₹59,600',
                                      eta: '60 min ETA Today',
                                      aiBadgeText: '🛡️ HIGHEST RATED',
                                      isBest: false,
                                    ),
                                  ],
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

  Widget _buildFilterChip(String label) {
    final isSel = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: FilterChip(
        label: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: isSel ? Colors.white : BuildLockTheme.navy)),
        selected: isSel,
        selectedColor: BuildLockTheme.navy,
        backgroundColor: BuildLockTheme.bg,
        onSelected: (v) => setState(() => _selectedFilter = label),
      ),
    );
  }

  Widget _buildSupplierQuoteCard(
    BuildContext context, {
    required String supplier,
    required String rating,
    required String dist,
    required String price,
    required String eta,
    required String aiBadgeText,
    required bool isBest,
  }) =>
      BLCard(
        color: isBest ? BuildLockTheme.greenSoft : Colors.white,
        border: Border.all(color: isBest ? BuildLockTheme.green : BuildLockTheme.border, width: isBest ? 1.5 : 1),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BLBadge(aiBadgeText, color: isBest ? BuildLockTheme.green : BuildLockTheme.navy),
                const Spacer(),
                Text(dist, style: const TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text(supplier, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
            Text(rating, style: const TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w700, fontSize: 11)),
            const SizedBox(height: 8),
            Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: BuildLockTheme.navy)),
            Text('🚚 $eta', style: const TextStyle(color: BuildLockTheme.green, fontWeight: FontWeight.w800, fontSize: 11)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: BuildLockTheme.orange),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => _openCounterOfferDialog(supplier, price),
                    child: const Text('Counter Offer', style: TextStyle(color: BuildLockTheme.orange, fontWeight: FontWeight.w900, fontSize: 11)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: BuildLockTheme.orange, padding: EdgeInsets.zero),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignatureConsentSheet()),
                    ),
                    child: const Text('Accept & Sign PO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
