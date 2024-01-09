import 'package:flutter/material.dart';

import './bluetoothController/bluetoothController.dart';

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
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BluetoothControl()));
                });
              },
              child: const Text('Connect to Device'),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.redAccent),
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
                          'Step 1: Turn on the PMCB device.\nStep 2: Turn on Bluetooth from your phone and pair the PMCB device.\nStep 3: Click "Connect to Device" and find the paired device to connect.\nStep 4:\nTo Deposit, click on deposit button and wait until you successfully finished dropping all your coins.\nTo Withdraw, click on withdraw button and enter the amount.'),
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
              color: Colors.red.shade50,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Contact Us',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Divider(
                  height: 40,
                ),
                Text(
                  'Email: TeamGroup2.noreply@gmail.com\n\nPhone: 09921234567',
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
