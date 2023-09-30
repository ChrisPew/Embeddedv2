import 'package:flutter/material.dart';

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
              Container(
                margin: const EdgeInsets.all(30),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: myController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter an integer amount',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
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
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.orange),
                    ),
                    child: const Text('Enter')),
              ),
              ElevatedButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.orange.shade900),
                  ),
                  child: const Text('Back')),
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
