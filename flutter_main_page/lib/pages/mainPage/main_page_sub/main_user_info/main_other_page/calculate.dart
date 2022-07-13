import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final _gradeList1 = ['A+', 'A', 'B+', 'B', 'C+', 'C', 'D+', 'D', 'F', 'P'];
  final _gradeList2 = ['A+', 'A', 'B+', 'B', 'C+', 'C', 'D+', 'D', 'F', 'P'];
  final _gradeList3 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _gradeList4 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _gradeList5 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _gradeList6 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _gradeList7 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _gradeList8 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _gradeList9 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _gradeList10 = [
    '등급',
    'A+',
    'A',
    'B+',
    'B',
    'C+',
    'C',
    'D+',
    'D',
    'F',
    'P'
  ];
  final _pointList1 = ['학점', '1', '2', '3', '4'];
  final _pointList2 = ['학점', '1', '2', '3', '4'];
  final _pointList3 = ['학점', '1', '2', '3', '4'];
  final _pointList4 = ['학점', '1', '2', '3', '4'];
  final _pointList5 = ['학점', '1', '2', '3', '4'];
  final _pointList6 = ['학점', '1', '2', '3', '4'];
  final _pointList7 = ['학점', '1', '2', '3', '4'];
  final _pointList8 = ['학점', '1', '2', '3', '4'];
  final _pointList9 = ['학점', '1', '2', '3', '4'];
  final _pointList10 = ['학점', '1', '2', '3', '4'];

  var _selectedGrade1 = '등급';
  var _selectedPoint1 = '학점';
  var _selectedGrade2 = '등급';
  var _selectedPoint2 = '학점';
  var _selectedGrade3 = '등급';
  var _selectedPoint3 = '학점';
  var _selectedGrade4 = '등급';
  var _selectedPoint4 = '학점';
  var _selectedGrade5 = '등급';
  var _selectedPoint5 = '학점';
  var _selectedGrade6 = '등급';
  var _selectedPoint6 = '학점';
  var _selectedGrade7 = '등급';
  var _selectedPoint7 = '학점';
  var _selectedGrade8 = '등급';
  var _selectedPoint8 = '학점';
  var _selectedGrade9 = '등급';
  var _selectedPoint9 = '학점';
  var _selectedGrade10 = '등급';
  var _selectedPoint10 = '학점';

  final myPoint_subject1 = TextEditingController();
  final myPoint_subject2 = TextEditingController();
  final myPoint_subject3 = TextEditingController();
  final myPoint_subject4 = TextEditingController();
  final myPoint_subject5 = TextEditingController();
  final myPoint_subject6 = TextEditingController();
  final myPoint_subject7 = TextEditingController();
  final myPoint_subject8 = TextEditingController();
  final myPoint_subject9 = TextEditingController();
  final myPoint_subject10 = TextEditingController();

//받은 학점

  @override
  void dispose() {
    myPoint_subject1.dispose();
    myPoint_subject2.dispose();
    myPoint_subject3.dispose();
    myPoint_subject4.dispose();
    myPoint_subject5.dispose();
    myPoint_subject6.dispose();
    myPoint_subject7.dispose();
    myPoint_subject8.dispose();
    myPoint_subject9.dispose();
    myPoint_subject10.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.check))
          ],
          backgroundColor: Colors.blue,
          title: const Text(
            "Calculator",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: _buildCalculate()));
  }

  Widget _buildCalculate() {
    return ListView(
      children: [
        Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 3)),
            child: Column(
              children: [
                const Text(
                  '학점계산기',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                _listIndex1(1, _pointList1, _gradeList1, myPoint_subject1),
                
                _buildResult(),
              ],
            )),
      ],
    );
  }

  Widget _listIndex1(
    int number,
    List point,
    List grade,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '과목$number :',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: _selectedPoint1,
                  items: point.map((value) {
                    return DropdownMenuItem(
                      child: Text(value.toString()),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPoint1 = value.toString();
                    });
                  },
                )),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: _selectedGrade1,
                  items: grade.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGrade1 = value.toString();
                    });
                  },
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                controller: controller,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    hintText: "점수",
                    hintStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '백분위 : ',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '평점평균 : ',
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
