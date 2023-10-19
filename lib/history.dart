import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> entries = <String>['3', '4', '1', '7', '8', '4', '5'];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        child: const Text('Transaction History',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
      ),
      const Divider(
        height: 30,
      ),
      Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              VerticalDivider(),
              const Text('Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ]),
      ),
      const Divider(
        height: 30,
      ),
      Expanded(
          child: ListView.separated(
        padding: const EdgeInsets.only(left: 30, right: 30),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 40,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('₱ ${entries[index]}', style: TextStyle(fontSize: 20)),
                  const VerticalDivider(),
                  Text('Date', style: TextStyle(fontSize: 15)),
                ]),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ))
    ]);
  }
}
