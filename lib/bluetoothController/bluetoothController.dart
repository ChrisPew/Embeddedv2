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
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BluetoothDevice? _device;
  bool _isConnected = false;
  BluetoothConnection? connection;
  List<BluetoothDevice> _devicesList = [];

  void _connectToDevice(BluetoothDevice device) async {
    if (_isConnected) {
      // Disconnect from the current device before connecting to a new one if needed.
      await connection?.finish();
      setState(() {
        _isConnected = false;
      });
    }
    try {
      connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        _isConnected = true;
        _device = device;
      });
    } catch (error) {
      print('Connection failed: $error');
    }
  }

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
              _isConnected ? 'Connected' : 'Not Connected',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                _getBondedDevices();
              },
              child: const Text('check bluetooth'),
            ),
            ElevatedButton(
              onPressed: () {
                // _connectToDevice();
              },
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
                    _connectToDevice(device); // Connect to the tappaed device
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
}
