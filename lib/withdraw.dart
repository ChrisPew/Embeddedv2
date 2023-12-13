import 'dart:typed_data';

import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';
import 'dbHelper.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final myController = TextEditingController(); // Define the text controller
  // static int withdrawAmt=int.parse(myController.text);
  int totalAmount = 0;
  int onePeso = 0;
  int fivePeso = 0;
  int tenPeso = 0;
  int twentyPeso = 0;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  static DateTime currentDate = DateTime.now();
  String formattedDate =
      "${currentDate.month}/${currentDate.day}/${currentDate.year}";

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('PMCB'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Withdraw Amount:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.orange),
              ),
              const SizedBox(height: 30),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius:
                            BorderRadius.circular(50), // Button border radius
                      ),
                      child: TextButton(
                        onPressed: () {
                          writeData('z');
                        },
                        child: const Text(
                          '1',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    VerticalDivider(width: 30),
                    InkWell(
                      onTap: () {
                        setState(() {
                          onePeso++;
                          totalAmount =
                              onePeso + fivePeso + tenPeso + twentyPeso;
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      onePeso.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange.shade900),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        if (onePeso > 0) {
                          setState(() {
                            onePeso--;
                            totalAmount =
                                onePeso + fivePeso + tenPeso + twentyPeso;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius:
                            BorderRadius.circular(50), // Button border radius
                      ),
                      child: TextButton(
                        onPressed: () {
                          writeData('x');
                        },
                        child: const Text(
                          '5',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    VerticalDivider(width: 30),
                    InkWell(
                      onTap: () {
                        setState(() {
                          fivePeso++;
                          totalAmount =
                              onePeso + fivePeso + tenPeso + twentyPeso;
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      fivePeso.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange.shade900),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        if (fivePeso > 0) {
                          setState(() {
                            fivePeso--;
                            totalAmount =
                                onePeso + fivePeso + tenPeso + twentyPeso;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius:
                            BorderRadius.circular(50), // Button border radius
                      ),
                      child: TextButton(
                        onPressed: () {
                          writeData('c');
                        },
                        child: const Text(
                          '10',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    VerticalDivider(width: 30),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tenPeso++;
                          totalAmount =
                              onePeso + fivePeso + tenPeso + twentyPeso;
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      tenPeso.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange.shade900),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        if (tenPeso > 0) {
                          setState(() {
                            tenPeso--;
                            totalAmount =
                                onePeso + fivePeso + tenPeso + twentyPeso;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius:
                            BorderRadius.circular(50), // Button border radius
                      ),
                      child: TextButton(
                        onPressed: () {
                          writeData('v');
                        },
                        child: const Text(
                          '20',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    VerticalDivider(width: 30),
                    InkWell(
                      onTap: () {
                        setState(() {
                          twentyPeso++;
                          totalAmount =
                              onePeso + fivePeso + tenPeso + twentyPeso;
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      twentyPeso.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange.shade900),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        if (twentyPeso > 0) {
                          setState(() {
                            twentyPeso--;
                            totalAmount =
                                onePeso + fivePeso + tenPeso + twentyPeso;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                  ]),
              const SizedBox(height: 30),
              Text(
                'Total amount: $totalAmount',
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.orange.shade900),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.orange)),
                  onPressed: () async => {
                        await databaseHelper.insertHistoryData({
                          'totalCoins': -totalAmount,
                          'date': formattedDate,
                        }),
                        await databaseHelper.updateData(
                            -onePeso, -fivePeso, -tenPeso, -twentyPeso),
                        writeData('s'),
                        Navigator.of(context).pop()
                      },
                  child: const Text(
                    'Withdraw',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.orangeAccent)),
                  onPressed: () =>
                      {writeData('s'), Navigator.of(context).pop()},
                  child: const Text('Back')),
            ],
          ),
        ),
      ),
    );
  }
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

//---------------------------------------------------------------------TEXT FIELD
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
    );
  }
}
