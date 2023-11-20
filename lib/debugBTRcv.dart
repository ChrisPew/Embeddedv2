import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:app1/withdraw.dart';
import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';

class DebugRcv extends StatefulWidget {
  const DebugRcv({super.key});

  @override
  State<DebugRcv> createState() => _DebugRcvState();
}

class _DebugRcvState extends State<DebugRcv> {
  static String deposited = "";
  StreamSubscription<Uint8List>? dataListener;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      _listenToArduino();
    });
  }

  _listenToArduino() {
    if (BluetoothManager.connection != null &&
        BluetoothManager.connection?.isConnected == true) {
      try {
        // if (dataListener == null) {
        //   dataListener =
        BluetoothManager.connection!.input!.listen((Uint8List data) {
          String message = String.fromCharCodes(data);
          print("Received: $message");
          // if (message != null) {
          setState(() {
            deposited = ascii.decode(data);
          });
          print('deposited mo: $deposited');
          // } else
          //   print('data null');
        });
        // } else
        //   dataListener?.cancel();
      } catch (e) {
        print("Error: $e");
      }
    } else
      print('Not Connected to bluetooth');
  }

  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
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
                    startTimer();
                  },
                  child: Text('ON')),
              ElevatedButton(
                  onPressed: () {
                    stopTimer();
                    writeData('0');
                  },
                  child: Text('OFF')),
              Text("Data received: $deposited"),
            ]),
          ),
        ));
  }
}
