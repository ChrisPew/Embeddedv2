import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';
import 'dbHelper.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  List<Map<String, dynamic>> retrievedData = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();
  late StreamSubscription<Uint8List> _streamSubscription;
  String deposited = "";
  int onePeso = 0;
  int fivePeso = 0;
  int tenPeso = 0;
  int twentyPeso = 0;
  static DateTime currentDate = DateTime.now();
  String formattedDate =
      "${currentDate.month}/${currentDate.day}/${currentDate.year}";

  @override
  void initState() {
    super.initState();
    _listenToArduino();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  _listenToArduino() {
    if (BluetoothManager.connection != null &&
        BluetoothManager.connection?.isConnected == true) {
      try {
        _streamSubscription =
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

  Future<void> fetchData() async {
    await databaseHelper.updateData(onePeso, fivePeso, tenPeso, twentyPeso);

    final data = await databaseHelper.getCoinData();
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
              Text(
                  'The Bank is open for deposit. \nYou can now drop coins. \n\nClick done afterwards.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.amber.shade900)),
              const Divider(
                  height: 40, endIndent: 120, indent: 120, color: Colors.amber),
              Text('Date: $formattedDate',
                  style:
                      TextStyle(fontSize: 20, color: Colors.orange.shade900)),
              const Divider(
                  height: 40, endIndent: 120, indent: 120, color: Colors.amber),
              Text('You have deposited:',
                  style: TextStyle(fontSize: 18, color: Colors.amber.shade900)),
              const SizedBox(height: 20),
              Container(
                width: 150,
                height: 140,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber.shade800,
                  borderRadius:
                      BorderRadius.circular(15), // Button border radius
                ),
                child: Text(
                    '1 Peso: ${onePeso.toString()}\n5 Peso: ${fivePeso.toString()}\n10 Peso: ${tenPeso.toString()}\n20 Peso: ${twentyPeso.toString()}',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: Colors.white)),
              ),
              Text(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.amber.shade900),
                  '\nTotal: ₱${(onePeso + (fivePeso * 5) + (tenPeso * 10) + (twentyPeso * 20)).toString()}'),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    onPressed: () async => {
                          await databaseHelper.insertHistoryData({
                            'totalCoins': onePeso +
                                (fivePeso * 5) +
                                (tenPeso * 10) +
                                (twentyPeso * 20),
                            'date': formattedDate,
                          }),
                          await fetchData(),
                          writeData('s'),
                          Navigator.of(context).pop()
                        },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.amber),
                    ),
                    child: const Text('Done')),
              ),
            ],
          ),
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
