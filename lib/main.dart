import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:async';

// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// final database = () async {
//   return openDatabase(
//     join(await getDatabasesPath(), 'transactions_database.db'),
//     onCreate: (db, version) {
//       return db.execute(
//         "CREATE TABLE transactions(id TEXT PRIMARY KEY, upiId TEXT, name TEXT, amount REAL, type TEXT, tag TEXT, note TEXT, date TEXT)",
//       );
//     },
//     version: 1,
//   );
// };

// // write a function to insert the transaction into the database
// Future<void> insertTransaction(Transaction transaction) async {
//   final Database db = (database) as Database;

//   await db.insert(
//     'transactions',
//     transaction.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }

// // write a function to get all the transactions from the database
// Future<List<Transaction>> transactions() async {
//   final Database db = (database) as Database;

//   final List<Map<String, dynamic>> maps = await db.query('transactions');

//   return List.generate(maps.length, (i) {
//     return Transaction(
//       id: maps[i]['id'],
//       upiId: maps[i]['upiId'],
//       name: maps[i]['name'],
//       amount: maps[i]['amount'],
//       type: maps[i]['type'],
//       tag: maps[i]['tag'],
//       note: maps[i]['note'],
//     );
//   });
// }

// // write a function to delete a transaction from the database
// Future<void> deleteTransaction(String id) async {
//   final Database db = (database) as Database;

//   await db.delete(
//     'transactions',
//     where: "id = ?",
//     whereArgs: [id],
//   );
// }

class Transaction {
  final String id;
  final String upiId;
  final String name;
  final double amount;
  final String type;
  final String tag;
  final String note;
  final String date = DateTime.now().toString();

  // create a constructor for the transaction which takes all the parameters
  Transaction({
    required this.id,
    required this.upiId,
    required this.name,
    required this.amount,
    required this.type,
    required this.tag,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'upiId': upiId,
      'name': name,
      'amount': amount,
      'type': type,
      'tag': tag,
      'note': note,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Transaction{id: $id, upiId: $upiId, name: $name, amount: $amount, type: $type, tag: $tag, note: $note, date: $date}';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String transactionMessage = "Click on the arrow to proceed";

  bool qrCodeResult = false;

  // make a controller for dropdown button for expense or income
  String dropdownValue = 'Expense';

  // make a texteditingcontroller for the upi id
  TextEditingController upiIdController = TextEditingController();

  // make a texteditingcontroller for the name
  TextEditingController nameController = TextEditingController();

  // create a texteditingcontroller for the amount
  final TextEditingController amountController = TextEditingController();

  // create a texteditingcontroller for the tag
  final TextEditingController tagController = TextEditingController();

  // create a texteditingcontroller for the note
  final TextEditingController noteController = TextEditingController();

  // create a setstate for the qrCodeResult
  void _qrCallback(String code) {
    // output: upi://pay?pn=Yess&pa=no@ybl&am=&tid=&tr=&tn=&url=
    // output: upi://pay?pa=om.surushe@paytm&pn=PaytmUser&mc=0000&mode=02&purpose=00&orgid=159761
    setState(() {
      String upiId = '';
      String name = '';

      // write a regex to get the pa and pn from the qr code
      upiId = RegExp(r'pa=(.*?)&').stringMatch(code)!;
      name = RegExp(r'pn=(.*?)&').stringMatch(code)!;

      // remove the pa=, pn= , & and %20 from the string
      upiId = upiId.replaceAll('pa=', '');
      upiId = upiId.replaceAll('&', '');

      upiIdController = TextEditingController(text: upiId);

      name = name.replaceAll('pn=', '');
      name = name.replaceAll('&', '');
      name = name.replaceAll('%20', ' ');

      nameController = TextEditingController(text: name);

      // set the qrCodeResult to true
      qrCodeResult = true;
    });
  }

  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
      ),
      // if the qrCodeResult is null then show the camera view
      body: !qrCodeResult
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey,
                  // heigh 90% of the screen
                  height: MediaQuery.of(context).size.height * 0.4,
                  // width 90% of the screen
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MobileScanner(
                    controller: cameraController,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      for (final barcode in barcodes) {
                        _qrCallback(barcode.rawValue.toString());
                        debugPrint('Barcode found! ${barcode.rawValue}');
                      }
                    },
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cameraController.switchCamera();
                        },
                        child: const Icon(Icons.camera_rear),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cameraController.toggleTorch();
                        },
                        child: const Icon(Icons.flash_on),
                      ),
                      // create a button to add the upi id manually
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              qrCodeResult = true;
                            });
                          },
                          child: const Icon(Icons.add)),
                    ])
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: TextField(
                    controller: upiIdController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      labelText: "UPI ID",
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      hintText: "UPI ID",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      filled: true,
                      fillColor: const Color(0xfff2f2f3),
                      isDense: false,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      prefixIcon: const Icon(Icons.credit_card,
                          color: Color(0xff212435), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: TextField(
                    controller: nameController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      labelText: "Name",
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      hintText: "Name",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      filled: true,
                      fillColor: const Color(0xfff2f2f3),
                      isDense: false,
                      contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      prefixIcon: const Icon(Icons.person,
                          color: Color(0xff212435), size: 24),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            labelText: "Amout",
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            hintText: "Amount",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: const Color(0xfff2f2f3),
                            isDense: false,
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Container(
                        width: 130,
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: DropdownButton(
                          value: dropdownValue,
                          items: ["Expense", "Income"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          elevation: 8,
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: TextField(
                    controller: tagController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      labelText: "Tag",
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      hintText: "Tag",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      filled: true,
                      fillColor: const Color(0xfff2f2f3),
                      isDense: false,
                      contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      prefixIcon: const Icon(Icons.info_outline,
                          color: Color(0xff212435), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: TextField(
                    controller: noteController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      labelText: "Note",
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      hintText: "Note",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      filled: true,
                      fillColor: const Color(0xfff2f2f3),
                      isDense: false,
                      contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      prefixIcon: const Icon(Icons.message,
                          color: Color(0xff212435), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          // // create a new transaction
                          // Transaction newTransaction = Transaction(
                          //     id: DateTime.now().toString(),
                          //     upiId: upiIdController.text,
                          //     name: nameController.text,
                          //     amount: double.parse(amountController.text),
                          //     tag: tagController.text,
                          //     note: noteController.text,
                          //     type: dropdownValue,
                          // );

                          // // add the transaction to the database
                          // await insertTransaction(newTransaction);

                          // // print all the transactions
                          // print(await transactions());

                          print("Add");
                        },
                        color: const Color(0xff212435),
                        iconSize: 24,
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          print("Cancel");
                          // clear all the text fields
                          upiIdController.clear();
                          nameController.clear();
                          amountController.clear();
                          tagController.clear();
                          noteController.clear();

                          // set the dropdown value to Expense
                          dropdownValue = "Expense";

                          setState(() {
                            // update the state
                            qrCodeResult = false;
                          });
                        },
                        color: const Color(0xff212435),
                        iconSize: 24,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () async {
                          print("Next");
                          final res = await EasyUpiPaymentPlatform.instance
                              .startPayment(
                            EasyUpiPaymentModel(
                              payeeVpa: upiIdController.text,
                              payeeName: nameController.text,
                              // get the amount from the input field
                              amount: double.parse(amountController.text),
                              description: noteController.text,
                            ),
                          );
                          // ignore: avoid_print
                          print(res);
                          setState(() {
                            transactionMessage = res.toString();
                          });
                        },
                        color: const Color(0xff212435),
                        iconSize: 24,
                      ),
                    ],
                  ),
                ),
                Text(transactionMessage),
              ],
            ),
    );
  }
}
