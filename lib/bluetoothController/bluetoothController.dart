import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../main.dart';

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

  @override
  void initState() {
    super.initState();
    _getBondedDevices();
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      })
                    },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.amber.shade700),
                ),
                child: const Text('Back')),
            Text(
              BluetoothManager.connection?.isConnected == true
                  ? 'Connected : ${BluetoothManager._device?.name}'
                  : 'Not Connected',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                _getBondedDevices();
              },
              child: const Text('Show Available Devices'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Connect to Device'),
            ),
            ElevatedButton(
              onPressed: () {
                writeData('1');
              },
              child: Text('Turn On LED'),
            ),
            ElevatedButton(
              onPressed: () {
                writeData('0');
              },
              child: Text('Turn Off LED'),
            ),
            Text(
              'List of Bonded Devices:',
              style: TextStyle(fontSize: 20),
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
}

class BluetoothManager {
  static BluetoothConnection? connection;
  static BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  static BluetoothDevice? _device;

  static Future<void> connectToDevice(BluetoothDevice device) async {
    if (connection != null && connection?.isConnected == true) {
      await connection?.finish();
    }
    connection = await BluetoothConnection.toAddress(device.address);
    _device = device;
  }
}
