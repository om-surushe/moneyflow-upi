// import 'package:easy_upi_payment/easy_upi_payment.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'QR Code Scanner',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool qrCodeResult = false;

//   // make a controller for dropdown button for expense or income
//   String dropdownValue = 'Expense';

//   // make a texteditingcontroller for the upi id
//   TextEditingController upiIdController = TextEditingController();

//   // make a texteditingcontroller for the name
//   TextEditingController nameController = TextEditingController();

//   // create a texteditingcontroller for the amount
//   final TextEditingController amountController = TextEditingController();
//   // create a texteditingcontroller for the note
//   final TextEditingController noteController = TextEditingController();

//   // create a setstate for the qrCodeResult
//   void _qrCallback(String code) {
//     // output: upi://pay?pn=Yess&pa=no@ybl&am=&tid=&tr=&tn=&url=
//     // output: upi://pay?pa=om.surushe@paytm&pn=PaytmUser&mc=0000&mode=02&purpose=00&orgid=159761
//     setState(() {
//       String upiId = '';
//       String name = '';

//       // write a regex to get the pa and pn from the qr code
//       upiId = RegExp(r'pa=(.*?)&').stringMatch(code)!;
//       name = RegExp(r'pn=(.*?)&').stringMatch(code)!;

//       // remove the pa=, pn= , & and %20 from the string
//       upiId = upiId.replaceAll('pa=', '');
//       upiId = upiId.replaceAll('&', '');

//       upiIdController = TextEditingController(text: upiId);

//       name = name.replaceAll('pn=', '');
//       name = name.replaceAll('&', '');
//       name = name.replaceAll('%20', ' ');

//       nameController = TextEditingController(text: name);

//       // set the qrCodeResult to true
//       qrCodeResult = true;
//     });
//   }

//   MobileScannerController cameraController = MobileScannerController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Mobile Scanner'),
//         ),
//         // if the qrCodeResult is null then show the camera view
//         body: !qrCodeResult
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     color: Colors.grey,
//                     // heigh 90% of the screen
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     // width 90% of the screen
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     child: MobileScanner(
//                       controller: cameraController,
//                       onDetect: (capture) {
//                         final List<Barcode> barcodes = capture.barcodes;
//                         for (final barcode in barcodes) {
//                           _qrCallback(barcode.rawValue.toString());
//                           debugPrint('Barcode found! ${barcode.rawValue}');
//                         }
//                       },
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             cameraController.switchCamera();
//                           },
//                           child: const Icon(Icons.camera_rear),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             cameraController.toggleTorch();
//                           },
//                           child: const Icon(Icons.flash_on),
//                         ),
//                         // create a button to add the upi id manually
//                         ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 qrCodeResult = true;
//                               });
//                             },
//                             child: const Icon(Icons.add)),
//                       ])
//                 ],
//               )
//             : Column(
//                 // make 1 input field for amount and 1 button to send the amount
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // make a text input field for the upi id
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextField(
//                       controller: upiIdController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'UPI ID',
//                       ),
//                     ),
//                   ),
//                   // make a text input field for the name
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextField(
//                       controller: nameController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Name',
//                       ),
//                     ),
//                   ),
//                   // make an integer input field
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       controller: amountController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Amount',
//                       ),
//                     ),
//                   ),
//                   // make a input field for expense or income with a dropdown button
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: DropdownButton<String>(
//                       value: dropdownValue,
//                       icon: const Icon(Icons.arrow_downward),
//                       iconSize: 24,
//                       elevation: 16,
//                       style: const TextStyle(color: Colors.deepPurple),
//                       underline: Container(
//                         height: 2,
//                         color: Colors.deepPurpleAccent,
//                       ),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           dropdownValue = newValue!;
//                         });
//                       },
//                       items: <String>['Expense', 'Income']
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   // make a text input field for the note
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextField(
//                       controller: noteController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Note',
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           final res = await EasyUpiPaymentPlatform.instance
//                               .startPayment(
//                             EasyUpiPaymentModel(
//                               payeeVpa: upiIdController.text,
//                               payeeName: nameController.text,
//                               // get the amount from the input field
//                               amount: double.parse(amountController.text),
//                               description: noteController.text,
//                             ),
//                           );
//                           // ignore: avoid_print
//                           print(res);
//                         },
//                         child: const Text('Send'),
//                       ),
//                       // create a button to cancel the payment
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             qrCodeResult = false;
//                           });
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       // create a button to save cash entry
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             qrCodeResult = false;
//                           });
//                         },
//                         child: const Text('Save'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ));
//   }
// }
