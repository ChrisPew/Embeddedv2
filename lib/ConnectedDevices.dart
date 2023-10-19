import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceScanner extends StatefulWidget {
  @override
  _DeviceScannerState createState() => _DeviceScannerState();
}

class _DeviceScannerState extends State<DeviceScanner> {
  List<BluetoothDevice> _devicesList = [];

  void _scanDevices() async {
    try {
      List<BluetoothDevice> devices =
          await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        _devicesList = devices;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: _scanDevices,
          child: Text('Scan for Devices'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _devicesList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_devicesList[index].name.toString()),
                subtitle: Text(_devicesList[index].address),
              );
            },
          ),
        ),
      ],
    );
  }
}
