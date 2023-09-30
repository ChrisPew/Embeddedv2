import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text('Help')),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.red.shade600),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Instructions'),
                      content: const Text(
                          'Step 1: Turn on the PMCB device.\nStep 2: Turn on Bluetooth from your phone.\nStep 3: Click Connect Device in the Dashboard and find the device to connect.\nStep 4:\nTo Deposit, click on deposit button and wait until you successfully droped all your coins.\nTo Withdraw, click on withdraw button and enter an integer amount. Centavos are not counted.'),
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
              child: const Text('Instructions')),
        ],
      ),
    );
  }
}
