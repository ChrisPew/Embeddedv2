import 'dart:typed_data';

import 'package:app1/withdraw.dart';
import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';
import './dbHelper.dart';

class DebugRcv extends StatefulWidget {
  const DebugRcv({super.key});

  @override
  State<DebugRcv> createState() => _DebugRcvState();
}

class _DebugRcvState extends State<DebugRcv> {
  static String deposited = "";
  int onePeso = 0;
  int fivePeso = 0;
  int tenPeso = 0;
  int twentyPeso = 0;
  List<Map<String, dynamic>> retrievedData = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    initializeData();
  }

  Future<void> initializeData() async {
    // Check if John Doe already exists in the database
    final List<Map<String, dynamic>> data = await databaseHelper.getData();

    if (data.isEmpty) {
      await databaseHelper.insertData({
        'p1': 0,
        'p5': 0,
        'p10': 0,
        'p20': 0,
      });
    }
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
            title: const Text('PMCB',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BluetoothController()));
                  },
                  child: Text('Bluetooth connect')),
              ElevatedButton(
                  onPressed: () {
                    writeData('1');
                    _listenToArduino();
                  },
                  child: Text('ON')),
              ElevatedButton(
                  onPressed: () {
                    writeData('0');
                  },
                  child: Text('OFF')),
              Text(
                  '1 Peso: ${onePeso.toString()}\n5 Peso: ${fivePeso.toString()}\n10 Peso: ${tenPeso.toString()}\n20 Peso: ${twentyPeso.toString()}\n'),
              ElevatedButton(
                onPressed: fetchData,
                child: Text('Fetch Data'),
              ),
              SizedBox(height: 20),
              if (retrievedData.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: retrievedData.length,
                    itemBuilder: (context, index) {
                      final item = retrievedData[index];
                      return ListTile(
                        title: Text('Coins Deposited:'),
                        subtitle: Text(
                            '1 Pesos: ${item['p1']} \n5 Pesos: ${item['p5']} \n10 Pesos: ${item['p10']} \n20 Pesos: ${item['p20']}'),
                      );
                    },
                  ),
                ),
            ]),
          ),
        ));
  }
}
