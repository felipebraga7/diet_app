import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

const int primaryColorHex = 0xFF2E4257; // Cor principal (#2E4257)

const MaterialColor customSwatch = MaterialColor(
  primaryColorHex,
  {
    50: Color(0xFFE4E8EB),  // Tom mais claro (aproximado)
    100: Color(0xFFBCC5CD), // Baseado em #537288
    200: Color(0xFF91A3AF), // Baseado em #40586D
    300: Color(0xFF667891), // Baseado em #2E4257
    400: Color(0xFF47596F), // Baseado em #1A2D42
    500: Color(primaryColorHex), // Cor principal #2E4257
    600: Color(0xFF283B4E), // Mais escuro que a cor principal
    700: Color(0xFF213243), // Baseado em #1A2D42
    800: Color(0xFF1A2A39), // Baseado em #152637
    900: Color(0xFF121F2A), // Tom mais escuro
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch, // Define a cor primária personalizada
        colorScheme: ColorScheme.fromSwatch(primarySwatch: customSwatch).copyWith(
          secondary: Color(0xFF537288), // Cor secundária
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: customSwatch.shade300,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 30
          ),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          decorationColor: Colors.white
        ),
      ),
      home: const MyHomePage(title: 'Diet App'),
    );
  }
}

