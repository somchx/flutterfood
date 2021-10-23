import 'dart:ui';
import 'package:flutter_food/services/api.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:flutter/material.dart';

class Hw14 extends StatefulWidget {
  static const routeName = '/HW';

  const Hw14({Key? key}) : super(key: key);

  @override
  _Hw14State createState() => _Hw14State();
}

class _Hw14State extends State<Hw14> {
  final TextEditingController _controller = TextEditingController();
  String? _guessNumber;
  int _year = 0;
  int _month = 0;
  var _correct = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GUESS THEACHER'S AGE"),
      ),
      body: Container(
        color: Colors.amber.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text(
                  'อายุอาจารย์',
                  style: TextStyle(fontSize: 36.0),
                )),
            !_correct? Container(
              height: 270,
              width: 170,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SpinBox(
                      decoration: InputDecoration(labelText: 'ปี'),
                      textStyle: TextStyle(fontSize: 30),
                      min: 1,
                      max: 100,
                      value: 0,
                      onChanged: (value) {
                        _year = value as int;
                      },
                    ),
                    SpinBox(
                      decoration: InputDecoration(
                        labelText: 'เดือน',
                      ),
                      textStyle: TextStyle(fontSize: 30),
                      min: 1,
                      max: 12,
                      value: 0,
                      onChanged: (value) {
                        _month = value as int;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SizedBox(
                        width: 90,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _handleClickButton(_year, _month);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text(
                            'ทาย',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ):Container(
              child: Column(
                children: [
                  Text('46 ปี 10 เดือน',style: TextStyle(fontSize: 28.0),),
                  Icon(Icons.check, size: 80.0, color: Colors.green,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleClickButton(year,month) async {
    print('$year $month');
    var answer = await _guessAge(year, month);
    if (answer == null) return;
    var text = answer['text'];
    var val = answer['value'];
    if(val==true){
      _correct=true;
    }
    else{
      _showMaterialDialog('ผลการทาย', text);
    }
  }

  Future<Map<String,dynamic>?> _guessAge(year,month) async {
    try {
      var answer = (await Api().submit(
          'guess_teacher_age', {'year': year, 'month': month}))
      as Map<String,dynamic>;
      //print('LOGIN: $answer');
      return answer;
    } catch (e) {
      print(e);
      _showMaterialDialog('ผลการทาย', e.toString());
      return null;
    } finally {
      setState(() {});
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
