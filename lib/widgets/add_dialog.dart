import 'package:diet_app/main.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: customSwatch.shade300,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            DropdownMenu(
              label: Text("Alimento"),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.white),
                suffixIconColor: Colors.white,
              ),
              expandedInsets: EdgeInsets.all(0),
              initialSelection: dropdownValue,
              onSelected: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            TextField(
              
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Row(
              
              children: [
                Expanded(
                  child: Text('Cal.: 100', textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('Prot.: 10', textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('Gord.: 10', textAlign: TextAlign.center),
                ),
              ],
            ),
            ElevatedButton.icon(
              label: Text("Adicionar"),
              onPressed: () {},
              icon: Icon(Icons.add),
              
            )
          ],
        ),
      ),
    );
  }
}