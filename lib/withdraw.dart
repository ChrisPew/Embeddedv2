import 'package:flutter/material.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final myController = TextEditingController(); // Define the text controller

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
          backgroundColor: Colors.lightBlue,
          title: const Text('PMCB'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Withdraw Amount:'),
              TextField(
                keyboardType: TextInputType.number,
                controller: myController, //
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter an integer amount',
                ),
              ),
              ElevatedButton(
                  // When the user presses the button, show an alert dialog containing
                  // the text that the user has entered into the text field.
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text(myController.text),
                        );
                      },
                    );
                  },
                  child: const Text('Enter')),
            ],
          ),
        ),
      ),
    );
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
