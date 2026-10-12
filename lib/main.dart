import 'package:flutter/material.dart';
import 'theme/buildlock_theme.dart';
import 'screens/auth_screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BuildLockApp());
}

class BuildLockApp extends StatelessWidget {
  const BuildLockApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BuildLock',
        theme: BuildLockTheme.light(),
        home: const SplashScreen(),
      );
}
