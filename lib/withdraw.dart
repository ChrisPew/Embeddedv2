import 'dart:typed_data';

import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final myController = TextEditingController(); // Define the text controller
  // static int withdrawAmt=int.parse(myController.text);

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
              const Text('Withdraw Amount:'),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.circular(50), // Button border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      writeData('z');
                    },
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.circular(50), // Button border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      writeData('x');
                    },
                    child: const Text(
                      '5',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.circular(50), // Button border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      writeData('c');
                    },
                    child: const Text(
                      '10',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.circular(50), // Button border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      writeData('v');
                    },
                    child: const Text(
                      '20',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ]),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.orange.shade900)),
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
