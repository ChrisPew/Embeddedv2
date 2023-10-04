import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Text('Transaction History',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            Container(
                margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, //New
                      blurRadius: 5.0,
                      offset: Offset(
                        5,
                        5,
                      ),
                    )
                  ],
                ),
                child: Container(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                child: Text('Amount',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                            Container(
                                child: Text('Date',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                          ]),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('30', style: TextStyle(fontSize: 20)),
                          Text('10/04/23', style: TextStyle(fontSize: 20))
                        ]),
                  ],
                )))
          ])),
    );
  }
}
