
import 'package:material_ui/material_ui.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medinav AI',
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}