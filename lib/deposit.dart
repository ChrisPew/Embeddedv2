import 'dart:typed_data';

import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  static int amountDeposited = 100;

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
                  'The Bank is open for deposit. \nYou can now drop coins. \n\nClick done afterwards.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    onPressed: () =>
                        {writeData('s'), Navigator.of(context).pop()},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.amber.shade700),
                    ),
                    child: const Text('Done')),
              ),
              Text('Total Amount deposited: ${amountDeposited.toString()}'),
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

  readData() async {
    if (BluetoothManager.connection != null &&
        BluetoothManager.connection?.isConnected == true) {
      try {
        BluetoothManager.connection?.input?.listen((Uint8List data) {
          String message = String.fromCharCodes(data);
          print("Received: $message");
          amountDeposited = int.parse(message);
        });
      } catch (e) {
        print('Error sending data: $e');
      }
    } else {
      print('Not connected. Cannot send data.');
    }
  }
}
