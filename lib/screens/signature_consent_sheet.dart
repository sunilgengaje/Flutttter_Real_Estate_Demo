import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import '../widgets/ui.dart';
import 'contractor_screens.dart';

class SignatureConsentSheet extends StatefulWidget {
  const SignatureConsentSheet({super.key});

  @override
  State<SignatureConsentSheet> createState() => _SignatureConsentSheetState();
}

class _SignatureConsentSheetState extends State<SignatureConsentSheet> {
  bool _agreedToTerms = true;
  final TextEditingController _otpConsentController = TextEditingController(text: '4829');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BLTopBar(title: 'Mutual Consent & Signature'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Commercial Summary Breakdown Card
            const BLCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BLBadge('COMMERCIAL SUMMARY #BL001245', color: BuildLockTheme.orange, icon: Icons.receipt_long),
                  SizedBox(height: 14),
                  Row(children: [Text('Material (20 Ton M-Sand)'), Spacer(), Text('₹47,000', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 8),
                  Row(children: [Text('Transport & Delivery Fare'), Spacer(), Text('₹1,500', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 8),
                  Row(children: [Text('GST (18%)'), Spacer(), Text('₹8,730', style: TextStyle(fontWeight: FontWeight.w800))]),
                  SizedBox(height: 8),
                  Row(children: [Text('Platform Escrow Fee'), Spacer(), Text('₹500', style: TextStyle(fontWeight: FontWeight.w800))]),
                  Divider(height: 28),
                  Row(children: [
                    Text('Total Payable Amount', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                    Spacer(),
                    Text('₹57,730', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: BuildLockTheme.navy)),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Mandatory Terms Checkbox
            BLCard(
              color: BuildLockTheme.bg,
              child: Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    activeColor: BuildLockTheme.orange,
                    onChanged: (v) => setState(() => _agreedToTerms = v!),
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to lock pricing, load specification, and site access terms under statutory consent.',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: BuildLockTheme.navy),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Interactive Digital Signature Canvas
            const Text('Draw Digital Signature', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: BuildLockTheme.navy)),
            const SizedBox(height: 8),
            const SignaturePad(),
            const SizedBox(height: 20),

            // OTP Consent Verification Input
            const Text('Enter 4-Digit Digital Consent OTP', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: BuildLockTheme.navy)),
            const SizedBox(height: 8),
            TextField(
              controller: _otpConsentController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4),
              decoration: const InputDecoration(
                labelText: 'Digital Consent OTP',
                prefixIcon: Icon(Icons.lock, color: BuildLockTheme.orange),
              ),
            ),
            const SizedBox(height: 24),

            primaryButton(
              'Sign & Confirm Order (Generate PO)',
              () {
                if (!_agreedToTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please accept statutory terms checkbox')));
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentScreen()),
                );
              },
              icon: Icons.check_circle,
            ),
          ],
        ),
      );
}
