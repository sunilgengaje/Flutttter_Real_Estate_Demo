import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/buildlock_theme.dart';
import 'auth_screens.dart';
import 'contractor_screens.dart';

class VideoPresentationScreen extends StatefulWidget {
  const VideoPresentationScreen({super.key});

  @override
  State<VideoPresentationScreen> createState() => _VideoPresentationScreenState();
}

class _VideoPresentationScreenState extends State<VideoPresentationScreen> {
  int _currentSceneIndex = 0;
  bool _isPlaying = true;
  Timer? _timer;

  final List<Map<String, dynamic>> _scenes = [
    {
      'title': '1. Splash & Brand Vision',
      'duration': '0:12',
      'voiceover': 'In construction, every minute delayed costs real money. Welcome to BuildLock — India’s premier B2B marketplace that ensures your job site never stops due to material shortages.',
      'builder': () => const SplashScreen(),
    },
    {
      'title': '2. Welcome & Role Selection',
      'duration': '0:12',
      'voiceover': 'Whether you are a Site Contractor looking for ready stock or a Verified Material Supplier expanding your local reach, BuildLock seamlessly connects both worlds in real time.',
      'builder': () => const WelcomeScreen(),
    },
    {
      'title': '3. Contractor Home Dashboard',
      'duration': '0:15',
      'voiceover': 'Meet Rohan, a site contractor in Pune. From his home dashboard, Rohan can manage multiple active project sites, check site inventory pulse, or initiate rapid procurement in seconds.',
      'builder': () => const ContractorShell(),
    },
    {
      'title': '4. Material Specification',
      'duration': '0:12',
      'voiceover': 'Rohan selects Manufactured Sand, inputs 20 Tons, selects Standard Grade, and specifies his required 3-to-5 PM delivery slot today.',
      'builder': () => const MaterialSpecificationScreen(),
    },
    {
      'title': '5. Supplier List & Interactive Map',
      'duration': '0:15',
      'voiceover': 'Instantly, BuildLock scans all verified stock yards within a 10-kilometer radius. Rohan can toggle between a clear price list and an interactive pin map showing distance, ratings, and live ready stock.',
      'builder': () => const SupplierListScreen(),
    },
    {
      'title': '6. Broadcast & Negotiable Counter-Quotes',
      'duration': '0:15',
      'voiceover': 'Nearby suppliers submit competitive, negotiable counter-quotes. Rohan reviews the final price breakdown — including base material, transport, and 18% GST.',
      'builder': () => const SupplierResponsesScreen(),
    },
    {
      'title': '7. Digital Agreement & Finger Signature',
      'duration': '0:12',
      'voiceover': 'Before payment, BuildLock secures digital consent. Rohan accepts non-cancellation terms and signs directly on the touch screen, locking the price and supplier commitment.',
      'builder': () => const OrderAgreementScreen(),
    },
    {
      'title': '8. Protected Escrow Payment',
      'duration': '0:12',
      'voiceover': 'Payment is deposited into BuildLock Protected Escrow. Funds remain safely locked until material is delivered and verified at site via a unique 4-digit Delivery OTP.',
      'builder': () => const PaymentScreen(),
    },
    {
      'title': '9. Location & OTP Order Lock',
      'duration': '0:12',
      'voiceover': 'Site GPS location is verified and a unique Delivery OTP 4829 is generated to share with the driver upon arrival.',
      'builder': () => const LocationOtpConfirmationScreen(),
    },
    {
      'title': '10. Supplier Dispatch & Live Tracking',
      'duration': '0:15',
      'voiceover': 'At the yard, the supplier loads the vehicle and assigns driver Rajesh Kumar. Instantly, both contractor and supplier track the truck in real time on the live map.',
      'builder': () => const LiveOrderTrackingScreen(),
    },
    {
      'title': '11. Site Verification & Auto Settlement',
      'duration': '0:15',
      'voiceover': 'Upon arrival, Rohan verifies quantity, enters the delivery OTP, and confirms Proof of Delivery. Escrow funds are automatically released to the supplier, and tax invoices are generated instantly.',
      'builder': () => const DeliveryVerificationScreen(),
    },
    {
      'title': '12. Order Completed & Admin Overview',
      'duration': '0:12',
      'voiceover': 'BuildLock: Zero delays. Full trust. Guaranteed delivery. Build faster with BuildLock.',
      'builder': () => const OrderCompletedScreen(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    if (_isPlaying) {
      _timer = Timer.periodic(const Duration(seconds: 10), (t) {
        if (mounted) {
          setState(() {
            if (_currentSceneIndex < _scenes.length - 1) {
              _currentSceneIndex++;
            } else {
              _currentSceneIndex = 0;
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentScene = _scenes[_currentSceneIndex];
    final Widget Function() screenBuilder = currentScene['builder'];

    return Scaffold(
      backgroundColor: BuildLockTheme.navy,
      appBar: AppBar(
        backgroundColor: BuildLockTheme.navy,
        foregroundColor: Colors.white,
        title: const Text('BuildLock Client Journey Video Presentation', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16)),
        actions: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, color: BuildLockTheme.orange, size: 28),
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
                _startTimer();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Scene Progress Bar
          LinearProgressIndicator(
            value: (_currentSceneIndex + 1) / _scenes.length,
            backgroundColor: Colors.white12,
            color: BuildLockTheme.orange,
            minHeight: 4,
          ),

          // Main Screen Preview Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: BuildLockTheme.orange, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 12)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: screenBuilder(),
              ),
            ),
          ),

          // English Voiceover Script & Subtitle Control Box
          Container(
            padding: const EdgeInsets.all(20),
            color: BuildLockTheme.navyLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: BuildLockTheme.orange, borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'SCENE ${_currentSceneIndex + 1} OF ${_scenes.length}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        currentScene['title'] as String,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // English Voiceover Audio Subtitle
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.record_voice_over, color: BuildLockTheme.orange, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '"${currentScene['voiceover']}"',
                        style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Controls Row (Prev, Play/Pause, Next)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white38)),
                      onPressed: () {
                        setState(() {
                          if (_currentSceneIndex > 0) _currentSceneIndex--;
                        });
                      },
                      icon: const Icon(Icons.skip_previous, size: 18),
                      label: const Text('Previous'),
                    ),
                    IconButton(
                      icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle, color: BuildLockTheme.orange, size: 36),
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                          _startTimer();
                        });
                      },
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: BuildLockTheme.orange),
                      onPressed: () {
                        setState(() {
                          if (_currentSceneIndex < _scenes.length - 1) _currentSceneIndex++;
                        });
                      },
                      icon: const Icon(Icons.skip_next, size: 18, color: Colors.white),
                      label: const Text('Next Scene', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
