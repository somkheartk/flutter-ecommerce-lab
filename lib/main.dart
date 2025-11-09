import 'package:ecom1/providers/auth_provider.dart';
import 'package:ecom1/providers/product_provider.dart';
import 'package:ecom1/providers/cart_provider.dart';
import 'package:ecom1/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter E-Commerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pinkAccent,
            primary: Colors.pink,
            secondary: Colors.purple,
          ),
          fontFamily: 'Kanit',
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            labelStyle: const TextStyle(fontFamily: 'Kanit'),
            hintStyle: const TextStyle(fontFamily: 'Kanit'),
          ),
        ),
        home: const LoginScreen(title: 'Flutter E-Commerce'),
      ),
    );
  }
}
