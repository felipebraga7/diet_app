import 'package:diet_app/widgets/add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/calendar_selector.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('mybox');
  DateTime _selectedDate = DateTime.now();

  // Callback to handle date selection
  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onAddPress() {
    showDialog(
      context: context, 
      builder: (context) {
        return AddDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _onAddPress,
        child: Icon(Icons.add),  
      ),
      body: Column(
        children: [
          // Calendar Selector
          CalendarSelector(
            onDateSelected: _onDateSelected,
            initialSelectedDate: _selectedDate,
          ),          // Buttons Row
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');
  runApp(MaterialApp(
    home: MyHomePage(title: 'Dieta App'),
  ));
}
