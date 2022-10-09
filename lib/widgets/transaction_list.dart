// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  const TransactionList(
      {required this.userTransactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      'No transactions added yet!',
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: userTransactions.map((tx) {
              return TransactionItem(
                key: ValueKey(tx.id),
                userTransaction: tx,
                deleteTransaction: deleteTransaction,
              );
            }).toList(),
          );
  }
}
