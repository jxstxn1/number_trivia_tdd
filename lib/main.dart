import 'package:flutter/material.dart';
import 'package:number_trivia_tdd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as dependency_injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
