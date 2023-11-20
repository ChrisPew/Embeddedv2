import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothControl(),
    );
  }
}

class BluetoothControl extends StatefulWidget {
  @override
  _BluetoothControlState createState() => _BluetoothControlState();
}

class _BluetoothControlState extends State<BluetoothControl> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  bool _isConnected = false;
  List<BluetoothDevice> _devicesList = [];
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  static String deposited = "";
  StreamSubscription<Uint8List>? dataListener;

  @override
  void initState() {
    super.initState();
    _getBondedDevices();

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
    enableBluetooth();
  }

  // Request Bluetooth permission from the user
  Future<void> enableBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      FlutterBluetoothSerial.instance.requestEnable();
    }
  }

  void _getBondedDevices() async {
    try {
      await FlutterBluetoothSerial.instance.getBondedDevices().then((devices) {
        setState(() {
          _devicesList = devices;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Connection'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              BluetoothManager.connection?.isConnected == true
                  ? 'Connected : ${BluetoothManager._device?.name}'
                  : 'Status: Not Connected',
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.red.shade800),
            ),

            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.amber),
                ),
                onPressed: () {
                  if (_bluetoothState == BluetoothState.STATE_ON) {
                    _getBondedDevices();
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Please turn on your bluetooth.'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
                child: const Text('Show Paired Devices'),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     writeData('1');
            //   },
            //   child: Text('Turn On LED'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     writeData('0');
            //   },
            //   child: Text('Turn Off LED'),
            // ),
            Text(
              (_bluetoothState == BluetoothState.STATE_ON)
                  ? 'List of Bonded Devices:'
                  : '',
              style: TextStyle(fontSize: 17),
            ),
            Column(
              children: _devicesList.map((device) {
                return ListTile(
                  title: Text(device.name.toString()),
                  subtitle: Text(device.address),
                  onTap: () {
                    BluetoothManager.connectToDevice(
                        device); // Connect to the tapped device
                  },
                );
              }).toList(),
            ),
          ],
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
        if (dataListener == null) {
          dataListener = BluetoothManager.connection?.input?.listen(
            (Uint8List data) {
              print('Data incoming: ${ascii.decode(data)}');
              String message = String.fromCharCodes(data);
              print("Received: $message");
              setState(() {
                deposited = message;
              });
              print(deposited);
            },
            onError: (dynamic error) {
              // Handle errors, if any
              print('Error: $error');
            },
            onDone: () {
              // Handle when the stream is closed (no more data)
              print('Stream closed');
              // Perform any cleanup or actions needed when the stream ends
            },
          );
          print('Listening for data');
        } else {
          print('Data listener is already set up');
        }
      } catch (e) {
        print('Error listening data: $e');
        print(deposited);
        print(dataListener.toString());
      }
    } else {
      print('Not connected. Cannot send data.');
    }
  }

  void dispose() {
    dataListener?.cancel();
    print('disposed');
    super.dispose();
  }
}

class BluetoothManager {
  static BluetoothConnection? connection;
  static BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  static BluetoothDevice? _device;
  static String receivedData = "";

  static Future<void> connectToDevice(BluetoothDevice device) async {
    if (connection != null && connection?.isConnected == true) {
      await connection?.finish();
    }
    connection = await BluetoothConnection.toAddress(device.address);
    _device = device;
  }
}
