import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/routes/pages.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});
  static const primaryColor = Color(0xFFF3F5FE);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: _buildTheme(Brightness.light),
      routerConfig: ROUTE().router,
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(
        scaffoldBackgroundColor: primaryColor, brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.kanitTextTheme(baseTheme.textTheme),
    );
  }
}
