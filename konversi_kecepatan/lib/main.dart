import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'convert.dart';
import 'history.dart';
import 'input.dart';
import 'result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  double _inputUser = 0;
  double _meterDetik = 0;
  double _kmDetik = 0;
  double _kmJam = 0;
  double _result = 0;

  Color warna1 = Color(0xFF212936);

  final inputController = TextEditingController();
  var listItem = ["Meter/Detik", "Km/Jam", "Km/Detik"];
  String newValueInput = "Km/Detik";
  String newValueOutput = "Km/Jam";

  // ignore: deprecated_member_use
  List<String> listViewItem = List<String>();

  void konversiKecepatan() {
    setState(() {
      _inputUser = double.parse(inputController.text);
      if (newValueInput == "Km/Detik" && newValueOutput == "Km/Jam")
        _result = _inputUser * 3600;
      else if (newValueInput == "Km/Detik" && newValueOutput == "Meter/Detik")
        _result = _inputUser * 1000;
      else if (newValueInput == "Km/Jam" && newValueOutput == "Km/Detik")
        _result = _inputUser * 0.000278;
      else if (newValueInput == "Km/Jam" && newValueOutput == "Meter/Detik")
        _result = _inputUser * 0.28;
      else if (newValueInput == "Meter/Detik" && newValueOutput == "Km/Jam")
        _result = _inputUser * 3.6;
      else if (newValueInput == "Meter/Detik" && newValueOutput == "Km/Detik")
        _result = _inputUser * 0.001;

      listViewItem.add("$newValueInput : $_result");
    });
  }

  DropdownButton<String> dropdownInput() {
    return DropdownButton<String>(
        style: TextStyle(color: Colors.white),
        items: listItem.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        dropdownColor: Colors.deepOrange,
        value: newValueInput,
        onChanged: (String change) {
          setState(() {
            newValueInput = change;
            konversiKecepatan();
          });
        });
  }

  DropdownButton<String> dropdownOutput() {
    return DropdownButton<String>(
        style: TextStyle(color: Colors.white),
        items: listItem.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        dropdownColor: Colors.deepOrange,
        value: newValueOutput,
        onChanged: (String change) {
          setState(() {
            newValueOutput = change;
            konversiKecepatan();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konverter Kecepatan',
      theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: warna1,
          title: Text(
            //mengatur text header dan style
            "Konverter Kecepatan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 100.0), //membuat padding di body
            color: warna1, //mengatur warna body
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Input(inputController: inputController),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dropdownInput(),
                    FloatingActionButton(
                      onPressed: () {
                        String temp = newValueInput;
                        setState(() {
                          newValueInput = newValueOutput;
                          newValueOutput = temp;
                        });
                      },
                      child: Icon(Icons.swap_horiz_outlined),
                      elevation: 0.0,
                      backgroundColor: Colors.green.shade200,
                    ),
                    dropdownOutput(),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Convert(konvertHandler: konversiKecepatan),
                SizedBox(
                  height: 50.0,
                ),
                Result(result: _result),
              ],
            )),
      ),
    );
  }
}
