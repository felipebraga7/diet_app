import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _myBox = Hive.box('mybox');

  //write
  void writeData() {
    _myBox.put(1, 'Frango');
  }

  //read
  void readData() {
    print(_myBox.get(1));
  }

  //delete
  void deleteData() {
    _myBox.delete(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: writeData,
              child: Text('Importar Alimento'),
              color: Colors.blue[200],
            ),
            MaterialButton(
              onPressed: readData,
              child: Text('Ver Alimento'),
              color: Colors.blue[200],
            ),
            MaterialButton(
              onPressed: deleteData,
              child: Text('Apagar Alimento'),
              color: Colors.blue[200],
            ),
          ],
        ),
      ),
    );
  }
}