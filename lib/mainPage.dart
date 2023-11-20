import 'dart:typed_data';

import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';
import './deposit.dart';
import './help.dart';
import './history.dart';
import './withdraw.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static int currentIndex = 0;
  static int onePeso = 4;
  static int fivePeso = 3;
  static int tenPeso = 2;
  static int twentyPeso = 1;
  static int balance = onePeso + fivePeso + tenPeso + twentyPeso;
  static bool depositing = false;

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
          backgroundColor: Colors.red,
          title:
              const Text('PMCB', style: TextStyle(fontWeight: FontWeight.bold)),
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
                                      MaterialStatePropertyAll<Color>(
                                          Colors.red.shade600),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Details'),
                                        content: Text(
                                          '1 peso coin: ' +
                                              MyApp.onePeso.toString() +
                                              '\n5 peso coin: ' +
                                              MyApp.fivePeso.toString() +
                                              '\n10 peso coin: ' +
                                              MyApp.tenPeso.toString() +
                                              '\n20 peso coin: ' +
                                              MyApp.twentyPeso.toString(),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Show Details'),
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
                          writeData('d');
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DepositPage()));
                          });
                        },
                        child: const Text('Deposit',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      //----------------------------------------------------------------------WITHDRAW BUTTON
                      Container(
                        margin: const EdgeInsets.only(top: 12.0),
                        child: ElevatedButton(
                          onPressed: () {
                            writeData('w');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WithdrawPage()));
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 21.5, vertical: 15)),
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.orange),
                          ),
                          child: const Text('Withdraw',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ),
                      ),
                    ],
                  )
                : MyApp.currentIndex == 1
                    ? HistoryPage()
                    : MyApp.currentIndex == 2
                        ? const HelpPage()
                        : const SizedBox()),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
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
              label: 'Help',
              icon: Icon(Icons.help),
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

  writeData(data) async {
    if (BluetoothManager.connection != null &&
        BluetoothManager.connection?.isConnected == true) {
      try {
        BluetoothManager.connection?.output
            .add(Uint8List.fromList(data.codeUnits));
        await BluetoothManager.connection?.output.allSent;
        print('Data sent: $data');
      } catch (e) {
        print('Error sending data: $e');
      }
    } else {
      print('Not connected. Cannot send data.');
    }
  }
}
