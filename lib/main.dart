import 'package:flutter/material.dart';
import 'pages/homePage.dart';  // Import your existing HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),  // Show Splash Screen first
      debugShowCheckedModeBanner: false,
    );
  }
}

// Splash Screen Widget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _simulateLoading();  // Simulate loading (e.g., fetching data, initializing)
  }

  // Simulate loading with a delay
  Future<void> _simulateLoading() async {
    await Future.delayed(Duration(seconds: 3));  // 3 seconds for splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),  // Navigate to Homepage after loading
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF04284E), // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 100, color: Colors.white),  // Your logo or icon
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),  // Loading spinner
            SizedBox(height: 20),
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white, fontSize: 18),  // Splash text
            ),
          ],
        ),
      ),
    );
  }
}
