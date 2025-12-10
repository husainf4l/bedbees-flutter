import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/locator.dart';
import 'core/theme/bedbees_theme.dart';
import 'routers/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await setupLocator();

  runApp(const ProviderScope(child: BedbessApp()));
}

class BedbessApp extends StatelessWidget {
  const BedbessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bedbees - Travel Super-App',
      debugShowCheckedModeBanner: false,
      theme: BedbeesTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
