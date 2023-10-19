import 'package:flutter/material.dart';
import './DiscoveryPage.dart';
import './SelectBondedDevicePage.dart';
import './ChatPage.dart';
import './ConnectedDevices.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 17)),
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectBondedDevicePage()));
                });
              },
              child: Text('Connect to Device'),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 17)),
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.red.shade600),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Instructions',
                      ),
                      content: const Text(
                          'Step 1: Turn on the PMCB device.\nStep 2: Turn on Bluetooth from your phone.\nStep 3: Click Connect Device in the Dashboard and find the device to connect.\nStep 4:\nTo Deposit, click on deposit button and wait until you successfully droped all your coins.\nTo Withdraw, click on withdraw button and enter an integer amount.'),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                'Instructions',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.all(30),
            width: 330,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.amber.shade100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Contact Us',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Divider(
                  height: 40,
                ),
                Text(
                  'Email: christopherespenida@gmail.com\n\nPhone: 09274478615',
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
