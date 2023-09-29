import 'package:flutter/material.dart';
import 'package:pmcb/withdraw.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static String depositBtn = 'Deposit';
  static String withdrawBtn = 'Withdraw';
  static String showBtn = 'Show Details';
  static int balance = 0;
  static int currentIndex = 0;

  Widget build(BuildContext context) {
    return MaterialApp(home: _MyHome().widget);
  }

  @override
  State<MyApp> createState() => _MyHome();
}

class _MyHome extends State<MyApp> {
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
            child: MyApp.currentIndex == 0
                ? Column(
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
                              //---------------------------------------------------------------SHOW DETAILS BUTTON
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.lightBlueAccent),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WithdrawPage()));
                                },
                                child: Text(MyApp.showBtn.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //-----------------------------------------------------------------------DEPOSIT BUTTON
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15)),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.amber),
                        ),
                        onPressed: () {
                          depositClicked();
                        },
                        child: Text(MyApp.depositBtn,
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      //----------------------------------------------------------------------WITHDRAW BUTTON
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
                                const MaterialStatePropertyAll<Color>(
                                    Colors.orange),
                          ),
                          child: Text(MyApp.withdrawBtn,
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ),
                      ),
                    ],
                  )
                : MyApp.currentIndex == 1
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text('Transactions History'),
                          )
                        ],
                      )
                    : MyApp.currentIndex == 2
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: const Text('Settings'),
                              )
                            ],
                          )
                        : SizedBox()),
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
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
