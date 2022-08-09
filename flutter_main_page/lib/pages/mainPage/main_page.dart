// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_alarm/main_alarm.dart';

// import 'main_page_sub/main_home/main_home.dart';

// class MainPage extends StatefulWidget {
//   final String userNumber;
//   final String user;
//   final bool isAdmin;
//   const MainPage(
//       {Key? key,
//       required this.userNumber,
//       required this.user,
//       required this.isAdmin})
//       : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int currentTab = 0;

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> screens = [
//       MainHome(
//         user: widget.user,
//         isAdmin: widget.isAdmin,
//       ),
//       MainAlarm()
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey,
//         title: const Text(
//           "Information and Communication",
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'Pacifico',
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//       ),
//       body: screens[currentTab],
//       floatingActionButton: FabCircularMenu(
//         alignment: Alignment.bottomCenter,
//         ringWidth: 150,
//         ringColor: Colors.white,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
//               Text("공지사항"),
//             ],
//           ),
          
//         ],
//       ),
//       //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 5.0,
//         child: Container(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     currentTab = 0;
//                     print(widget.user);
//                   });
//                 },
//                 icon: Icon(
//                   Icons.home_outlined,
//                   color: currentTab == 0 ? Colors.black : Colors.grey,
//                   size: 30,
//                 ),
//               ),
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                       currentTab = 1;
//                     });
//                   },
//                   icon: Icon(
//                     Icons.notifications_active_outlined,
//                     color: currentTab == 1 ? Colors.black : Colors.grey,
//                     size: 30,
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// bottomNavigationBar: BottomNavigationBar(
//         onTap: (index) {
//           setState(() {
//             _index = index;
//           });
//         },
//         currentIndex: _index,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.blueGrey[300],
//         selectedItemColor: Colors.white,
//         // ignore: prefer_const_literals_to_create_immutables
//         items: [
//           const BottomNavigationBarItem(
//             label: '홈',
//             icon: Icon(Icons.home),
//           ),
//           const BottomNavigationBarItem(
//               label: '커뮤니티', icon: Icon(Icons.assignment)),
//           const BottomNavigationBarItem(
//             label: '알림',
//             icon: Icon(Icons.alarm),
//           ),
//           const BottomNavigationBarItem(
//               label: '내정보', icon: Icon(Icons.account_circle)),
//         ],
//       ),
