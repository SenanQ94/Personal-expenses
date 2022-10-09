// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            autofocus: true,
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title:',
            ),
            textInputAction: TextInputAction.next,
            //onSubmitted: (_) => submitData(),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount:',
            ),
            //textInputAction: TextInputAction.next,
            onSubmitted: (_) => submitData(),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Text(_selectedDate == null
                    ? 'No Choosen Date!'
                    : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}'),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text('Choose Date'),
                )
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: submitData,
              child: Text(
                'Add Transaction',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
