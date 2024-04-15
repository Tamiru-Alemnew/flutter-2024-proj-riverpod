import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Cash manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 78, 75, 82),
          title: Text("Family Cash manager", selectionColor: Color(0xFFFFFFFF),),
        ),

        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: const Color.fromARGB(255, 63, 61, 61)),
              children: [

                TableRow(children: [
                  Text('Cell 1'),
                  Text('Cell 2'),
                  Text('Cell 3'),
                ]),
                TableRow(children: [
                  Text('Cell 4'),
                  Text('Cell 5'),
                  Text('Cell 6'),
                ]),
                 TableRow(children: [
                  Text('Cell 4'),
                  Text('Cell 5'),
                  Text('Cell 6'),
                ]),
                 TableRow(children: [
                  Text('Cell 4'),
                  Text('Cell 5'),
                  Text('Cell 6'),
                ]),
                 TableRow(children: [
                  Text('Cell 4'),
                  Text('Cell 5'),
                  Text('Cell 6'),
                ]),
                 TableRow(children: [
                  Text('Cell 4'),
                  Text('Cell 5'),
                  Text('Cell 6'),
                ]),
                 TableRow(children: [
                  Text('Cell 4'),
                  Text('Cell 5'),
                  Text('Cell 6'),
                ]),
                 TableRow(children: [
                  Text('Cell 4'),
                  Text('Cell 5'),
                  Text('Cell 6'),
                ]),
              ],
            ),
          )),
    );
  }
}
