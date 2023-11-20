import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import './bluetoothController/bluetoothController.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  static String deposited = "";
  StreamSubscription<Uint8List>? dataListener;
  BluetoothConnection? connection = BluetoothManager.connection;

  @override
  void initState() {
    super.initState();
    readData();
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
              Text('Total Amount deposited: ${deposited.toString()}'),
              ElevatedButton(
                  onPressed: () => {writeData('r'), print(deposited)},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.amber.shade700),
                  ),
                  child: const Text('Read')),
              Text(connection?.input != null
                  ? ('connected already')
                  : ('connection input is empty')),
            ],
          ),
        ),
      ),
    );
  }

  writeData(data) async {
    if (connection != null && connection?.isConnected == true) {
      try {
        connection?.output.add(Uint8List.fromList(data.codeUnits));
        await connection?.output.allSent;
        print('Data sent: $data');
      } catch (e) {
        print('Error sending data: $e');
      }
    } else {
      print('Not connected. Cannot send data.');
    }
  }

  readData() async {
    try {
      dataListener = connection?.input?.listen(
        (Uint8List data) {
          String receivedData = String.fromCharCodes(data);
          setState(() {
            deposited = receivedData;
          });
          print("nice");
          print("deposited: $deposited");
        },
        onDone: () {
          // Handle when the Bluetooth connection is closed
          print("Bluetooth connection closed");
        },
        onError: (error) {
          // Handle any errors that occur during the listening process
          print("Error listening for data: $error");
        },
      );
    } catch (e) {
      print("Error: $e");
    }

    void dispose() {
      dataListener?.cancel();
      print('disposed');
      super.dispose();
    }
  }
}
