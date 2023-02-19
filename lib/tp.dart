///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
              controller: TextEditingController(),
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                labelText: "UPI ID",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                hintText: "UPI ID",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xfff2f2f3),
                isDense: false,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                prefixIcon:
                    Icon(Icons.credit_card, color: Color(0xff212435), size: 24),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: TextField(
              controller: TextEditingController(),
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                labelText: "Name",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                hintText: "Name",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xfff2f2f3),
                isDense: false,
                contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                prefixIcon:
                    Icon(Icons.person, color: Color(0xff212435), size: 24),
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
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: TextField(
                    controller: TextEditingController(),
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      labelText: "Amout",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      hintText: "Amount",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      filled: true,
                      fillColor: Color(0xfff2f2f3),
                      isDense: false,
                      contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Container(
                  width: 130,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: DropdownButton(
                    value: "Expense",
                    items: ["Expense", "Income"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    onChanged: (value) {},
                    elevation: 8,
                    isExpanded: true,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
              controller: TextEditingController(),
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                labelText: "Tag",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                hintText: "Tag",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xfff2f2f3),
                isDense: false,
                contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                prefixIcon: Icon(Icons.info_outline,
                    color: Color(0xff212435), size: 24),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: TextField(
              controller: TextEditingController(),
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Color(0xff000000), width: 1),
                ),
                labelText: "Note",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                hintText: "Note",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xfff2f2f3),
                isDense: false,
                contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                prefixIcon:
                    Icon(Icons.message, color: Color(0xff212435), size: 24),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: Color(0xff212435),
                  iconSize: 24,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {},
                  color: Color(0xff212435),
                  iconSize: 24,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {},
                  color: Color(0xff212435),
                  iconSize: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
