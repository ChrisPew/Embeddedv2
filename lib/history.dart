import 'package:flutter/material.dart';

import 'dbHelper.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> retrievedData = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    final data = await databaseHelper.getHistoryData();
    setState(() {
      retrievedData = data;
    });
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'Transaction History',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
        ),
        Divider(
          height: 50,
          thickness: 5,
          indent: 70,
          endIndent: 70,
          color: Colors.red.shade700,
        ),
        Container(
          // padding: const EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Amount',
                style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'Date',
                style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Divider(
          height: 50,
          thickness: 5,
          indent: 70,
          endIndent: 70,
          color: Colors.red.shade700,
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     initialize();
        //   },
        //   child: const Text('Initialize'),
        // ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: databaseHelper.getHistoryData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No data found. Insert some coins.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    return Container(
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('₱ ${data['totalCoins']}',
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 20)),
                              // const VerticalDivider(),
                              Text('${data['date']}',
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 18)),
                            ]),
                        Divider(
                          height: 40,
                          indent: 70,
                          endIndent: 70,
                          color: Colors.redAccent.shade100,
                        ),
                      ]),
                    );
                    //   Column(
                    //   children: [
                    //     Text('Total Coins: ${data['totalCoins']}'),
                    //     Text('Date: ${data['date']}'),
                    //     SizedBox(height: 16),
                    //   ],
                    // );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
