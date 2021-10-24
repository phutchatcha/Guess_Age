import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:guess_age/api.dart';

class guessAge extends StatefulWidget {
  const guessAge({Key? key}) : super(key: key);

  @override
  _guessAgeState createState() => _guessAgeState();
}

class _guessAgeState extends State<guessAge> {
  int years = 0;
  int months = 0;
  bool checkAge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GUESS TEACHER'S AGE"),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'อายุอาจารย์',
              style: Theme.of(context).textTheme.headline1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black26,
                    width: 8.0,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  children: [
                    Padding(
                      child: SpinBox(
                        min: 1,
                        max: 150,
                        value: 1,
                        decoration: InputDecoration(labelText: 'ปี',labelStyle: Theme.of(context).textTheme.headline2,),
                        onChanged: (year) {
                          setState(() {
                            print(year);
                            years = year as int;
                          });
                        },
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                    Padding(
                      child: SpinBox(
                          min: 1,
                          max: 12,
                          value: 1,
                          readOnly: true,
                          decoration: InputDecoration(labelText: 'เดือน',labelStyle: Theme.of(context).textTheme.headline2,),
                          onChanged: (month) {
                            setState(() {
                              print(month);
                              months = month as int;
                            });
                          }),
                      padding: const EdgeInsets.all(16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _guess();
                        },
                        child: Text('ทาย',style: TextStyle(
                          fontSize: 24.0, color: Colors.white
                        )
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 50),
                            primary: Colors.deepPurple),
                      ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog(String str, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(str),
          content: Text(text, style: Theme.of(context).textTheme.headline3),
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

  _guess() async {
    var data = (await Api()
            .submit("guess_teacher_age", {'year': years, 'month': months}))
        as Map<String, dynamic>;
    if (data == null) {
      return;
    } else {
      String text = data['text'];
      bool value = data['value'];
      if (value) {
        setState(() {
          checkAge = true;
        });
        _showMaterialDialog("ผลการทาย", text);
      } else {
        _showMaterialDialog("ผลการทาย", text);
      }
    }
  }
}
