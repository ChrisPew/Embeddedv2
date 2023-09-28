import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String depositBtn = 'Deposit';
  static String withdrawBtn = 'Withdraw';
  static String showBtn = 'Show Details';
  static int balance = 0;
  static int currentIndex = 0;

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
          backgroundColor: Colors.lightBlue,
          title: const Text('PMCB'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 70),
                child: Column(
                  children: [
                    const Text('Current Balance:',
                        style: TextStyle(fontSize: 15)),
                    Text(MyApp.balance.toString(),
                        style: const TextStyle(fontSize: 30)),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.lightBlueAccent),
                        ),
                        onPressed: () {
                          showClicked();
                        },
                        child: Text(MyApp.showBtn.toString()),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
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
                        const EdgeInsets.symmetric(
                            horizontal: 21.5, vertical: 15)),
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.orange),
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
          currentIndex: MyApp.currentIndex,
          onTap: (int index) {
            setState(() {
              MyApp.currentIndex = index;
            });
          },
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

  showClicked() {
    setState(() {
      MyApp.showBtn = 'Showing...';
    });
  }
}
