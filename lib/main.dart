import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PMCB'),
        ),
        body: const Center(
            //child: ElevatedButton(
            //onPressed: () {},
            child: Text('Deposit') //)
            ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: 'Dashboard', icon: Icon(Icons.dashboard)),
            BottomNavigationBarItem(
                label: 'History', icon: Icon(Icons.history)),
            BottomNavigationBarItem(
                label: 'Settings', icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
