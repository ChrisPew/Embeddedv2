import 'dart:typed_data';

import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';
import './dbHelper.dart';
import './deposit.dart';
import './help.dart';
import './history.dart';
import './withdraw.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static int currentIndex = 0;
  static bool depositing = false;

  Widget build(BuildContext context) {
    return MaterialApp(home: _MyHome().widget);
  }

  @override
  State<MyApp> createState() => _MyHome();
}

class _MyHome extends State<MyApp> {
  List<Map<String, dynamic>> retrievedData = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();
  String deposited = "";
  int onePeso = 0;
  int fivePeso = 0;
  int tenPeso = 0;
  int twentyPeso = 0;
  int balance = 0;

  @override
  void initState() {
    super.initState();

    initializeData();
  }

  Future<void> initializeData() async {
    // Check if John Doe already exists in the database
    final List<Map<String, dynamic>> data = await databaseHelper.getData();
    setState(() {
      retrievedData = data;
      balance = retrievedData[0]["p1"] +
          retrievedData[0]["p5"] +
          retrievedData[0]["p10"] +
          retrievedData[0]["p20"];
    });

    if (data.isEmpty) {
      await databaseHelper.insertData({
        'p1': 0,
        'p5': 0,
        'p10': 0,
        'p20': 0,
      });
      print('data initialized');
    }
    print('data: ${data.toString()}');
  }

  Future<void> fetchData() async {
    await databaseHelper.updateData(onePeso, fivePeso, tenPeso, twentyPeso);

    final data = await databaseHelper.getData();
    setState(() {
      retrievedData = data;
    });
    setState(() {
      onePeso = 0;
      fivePeso = 0;
      tenPeso = 0;
      twentyPeso = 0;
    });
  }

  _listenToArduino() {
    if (BluetoothManager.connection != null &&
        BluetoothManager.connection?.isConnected == true) {
      try {
        BluetoothManager.connection!.input!.listen((Uint8List data) {
          if (String.fromCharCodes(data).contains('1')) {
            setState(() {
              deposited = String.fromCharCodes(data);
              onePeso++;
            });
          } else if (String.fromCharCodes(data).contains('2')) {
            setState(() {
              deposited = String.fromCharCodes(data);
              fivePeso++;
            });
          } else if (String.fromCharCodes(data).contains('3')) {
            setState(() {
              deposited = String.fromCharCodes(data);
              tenPeso++;
            });
          } else if (String.fromCharCodes(data).contains('4')) {
            setState(() {
              deposited = String.fromCharCodes(data);
              twentyPeso++;
            });
          }
        });
      } catch (e) {
        print("Error: $e");
      }
    } else
      print('Not Connected to bluetooth');
  }

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
                      Column(
                        children: [
                          const Text('Current Balance:\n',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.redAccent)),
                          Text('₱${balance.toString()}',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red.shade700)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.redAccent),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Coin Details',
                                        style: TextStyle(
                                          color: Colors.amber.shade700,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                        )),
                                    content: Container(
                                      height: 140,
                                      child: Column(
                                        children: [
                                          Text(
                                              '\n1 Pesos: ${retrievedData[0]["p1"]}',
                                              style: TextStyle(
                                                fontSize: 19,
                                                color: retrievedData[0]
                                                            ["p20"] >=
                                                        20
                                                    ? Colors.red.shade900
                                                    : Colors.amber.shade900,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.italic,
                                              )),
                                          const Divider(
                                              height: 10,
                                              indent: 80,
                                              endIndent: 80,
                                              color: Colors.white),
                                          Text(
                                              '5 Pesos: ${retrievedData[0]["p5"]}',
                                              style: TextStyle(
                                                fontSize: 19,
                                                color: retrievedData[0]
                                                            ["p20"] >=
                                                        20
                                                    ? Colors.red.shade800
                                                    : Colors.amber.shade900,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.italic,
                                              )),
                                          const Divider(
                                              height: 10,
                                              indent: 80,
                                              endIndent: 80,
                                              color: Colors.white),
                                          Text(
                                              '10 Pesos: ${retrievedData[0]["p10"]}',
                                              style: TextStyle(
                                                fontSize: 19,
                                                color: retrievedData[0]
                                                            ["p10"] >=
                                                        20
                                                    ? Colors.red.shade800
                                                    : Colors.amber.shade900,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.italic,
                                              )),
                                          const Divider(
                                              height: 10,
                                              indent: 80,
                                              endIndent: 80,
                                              color: Colors.white),
                                          Text(
                                              '20 Pesos: ${retrievedData[0]["p20"]}',
                                              style: TextStyle(
                                                fontSize: 19,
                                                color: retrievedData[0]
                                                            ["p20"] >=
                                                        20
                                                    ? Colors.red.shade800
                                                    : Colors.amber.shade900,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.italic,
                                              )),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: Text('OK',
                                            style: TextStyle(
                                                color: Colors.amberAccent)),
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
                        ],
                      ),
                      const Divider(
                        height: 50,
                        indent: 100,
                        endIndent: 100,
                      ),
                      //-----------------------------------------------------------------------DEPOSIT BUTTON
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15)),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.amberAccent),
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
                                    Colors.orangeAccent),
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
