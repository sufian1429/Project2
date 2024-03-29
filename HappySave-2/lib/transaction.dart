import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formattedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

class MyTransaction extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;
  final String formattedDate;

  final _formKey = GlobalKey<FormState>();

  MyTransaction({
     this.transactionName,
     this.money,
     this.expenseOrIncome,
     this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    // String day1;
    // print(int.parse(day));
    // if (int.parse(day) > 4000) {
    //   DateTime epoch = DateTime(1899, 12, 30);
    //   DateTime currentDate = epoch.add(Duration(days: int.parse(day)));
    //   day1 = DateFormat('yyyy/MM/dd').format(currentDate);
    //   print(currentDate);
    // } else {
    //   day1 = day;
    // }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey[100],
          child: Row(
            key: _formKey,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.yellow[600]),
                    child: Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(transactionName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      )),
                ],
              ),
              Text(
                '  ' +
                    (expenseOrIncome == 'expense' ? '-' : '+') +
                    '\฿' +
                    money +
                    '  ||  ' +
                    formattedDate,
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      expenseOrIncome == 'expense' ? Colors.red : Colors.green,
                ),
              ),
              // MaterialButton(
              //   color: Colors.red[600],
              //   child: Text('ลบ', style: TextStyle(color: Colors.white)),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              // MaterialButton(
              //   color: Colors.red[600],
              //   child: Text('ลบ', style: TextStyle(color: Colors.white)),
              //   onPressed: () {
              //     // if (_formKey.currentState!.validate()) {
              //     //   // _enterTransaction();
              //     Navigator.of(context).pop();
              //     // }
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
