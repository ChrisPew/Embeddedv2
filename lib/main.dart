import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String depositBtn = 'Deposit';
  static String withdrawBtn = 'Withdraw';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF800000),
          title: const Text('PMCB'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.amber),
                ),
                onPressed: () {
                  depositClicked();
                },
                child: Text(MyApp.depositBtn,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12.0),
                child: ElevatedButton(
                  onPressed: () {
                    withdrawClicked();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20)),
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.amber),
                  ),
                  child: Text(MyApp.withdrawBtn,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Dashboard',
              icon: Icon(Icons.dashboard),
            ),
            BottomNavigationBarItem(
              label: 'History',
              icon: Icon(Icons.history),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }

  depositClicked() {
    setState(() {
      MyApp.depositBtn = 'Depositing...';
    });
  }

  withdrawClicked() {
    setState(() {
      MyApp.withdrawBtn = 'Withdrawing...';
    });
  }

  btnStyleDashboard() {}
}
