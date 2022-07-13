import 'package:flutter/material.dart';

class userInfoBox extends StatelessWidget {
  String userNumber = '';
  String user = '';
  String userGrade = '';
  String userClass = '';

  userInfoBox({Key? key}) : super(key: key);
  userInfoBox.set_user_info(
      this.user, this.userGrade, this.userClass, this.userNumber);

  @override
  Widget build(BuildContext context) {
    return (Container(
      width: 380,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 3),
        // color: Color.fromRGBO(73, 169, 242, 10)
      ),
      //안에 들어갈 디자인 입니다.
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(
              Icons.account_circle_rounded,
              size: 100,
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              children: [
                SizedBox(
                  child: Text(
                    '${this.user}',
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  '${this.userGrade}학년 / ${this.userClass}반',
                  style: const TextStyle(fontSize: 17),
                ),
                Text(
                  '${this.userNumber}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ]),
        ],
      ),
    ));
  }
}
