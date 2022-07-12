import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  // List<TextField> _subjects = []; //과목명
  // List<TextField> _points = []; //학점
  // List<TextField> _grades = []; //받은 백분위
  // List<TextField> _myPoints = []; //받은 학점
  // List<TextEditingController> _subjectsController = []; //과목명
  // List<TextEditingController> _pointsController = []; //학점
  // List<TextEditingController> _gradesController = []; //받은 백분위
  // List<TextEditingController> _myPointsController = []; //받은 학점
  // int _count = 1;

  // @override
  // void dispose() {
  //   for (final subjectcontroller in _subjectsController) {
  //     subjectcontroller.dispose();
  //   }
  //   for (final pointController in _pointsController) {
  //     pointController.dispose();
  //   }
  //   for (final gradecontroller in _gradesController) {
  //     gradecontroller.dispose();
  //   }
  //   for (final myPointController in _myPointsController) {
  //     myPointController.dispose();
  //   }
  //   super.dispose();
  // }

  // void _add() {
  //   final subject = TextEditingController();
  //   final point = TextEditingController();
  //   final grade = TextEditingController();
  //   final myPoint = TextEditingController();

  //   final subjectField = _generateTextField(subject, "과목명 $_count");
  //   final pointField = _generateTextField(point, "학점");
  //   final gradeField = _generateTextField(grade, "받은등급");
  //   final myPointField = _generateTextField(myPoint, "받은점수");

  //   setState(() {
  //     _subjectsController.add(subject);
  //     _pointsController.add(point);
  //     _gradesController.add(grade);
  //     _myPointsController.add(myPoint);
  //     ++_count;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
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
      body: Center(child: Text('학점계산기')),
    );
  }

  // Widget _listView() {
  //   final children = [
  //     for (var i = 0; i < _subjectsController.length; i++) {
  //       Container<Widget>(margin: EdgeInsets.all(5), child: InputDecorator(child: Column(children: [
  //         _subjects[i], _points[i], _grades[i], _myPoints[i],
  //       ],), decoration: InputDecoration(labelText: i.toString(),),))
  //     }
  //   ];
  //   return SingleChildScrollView(
  //     child: Column(children:
  //       children,
  //     ),
  //   );
  // }

  // TextField _generateTextField(TextEditingController controller, String hint) {
  //   return TextField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //       border: const OutlineInputBorder(),
  //       labelText: hint,
  //     ),
  //   );
  // }
}
