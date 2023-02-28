import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_main_page/src/constants/firebase_constants.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../pages/mainPage/main_home.dart';
import '../pages/others/introduce.dart';
import 'error_controller.dart';

class AuthController extends GetxController {
  final bool? isChecked;
  final showHome = prefs.getBool('showHome') ?? false;

  AuthController({this.isChecked}) {}

  Future login(String id, String password) async {
    if (id == '') {
      ErrorMessage.toastErrorMessage("학번을 입력하세요.");
      return;
    }
    if (password == '') {
      ErrorMessage.toastErrorMessage("비밀번호를 입력하세요.");
      return;
    }

    try {
      final String user = id;
      DocumentSnapshot userInfoData =
          await firebaseFirestore.collection('UserInfo').doc(user).get();

      if (!userInfoData.exists) {
        ErrorMessage.toastErrorMessage("가입하지 않은 학번입니다.");
        return;
      }
      await auth
          .signInWithEmailAndPassword(
        email: userInfoData['email'],
        password: password,
      )
          .then((value) {
        if (value.user!.emailVerified == false) {
          toastMessage('이메일 인증을 완료해주세요!');
          return;
        }

        if (isChecked == true) {
          _updateAutoLoginStatus(isChecked!);
          _saveUserData(userInfoData['userNumber'], userInfoData['userName'],
              userInfoData['isAdmin']);
          return;
        }

        prefs.setString('userNumber', userInfoData['userNumber']);
        prefs.setInt('index', prefs.getInt('index') ?? 1);

        Get.off(showHome
            ? MainHome(
                userNumber: userInfoData.id,
                user: userInfoData['userName'],
                isAdmin: userInfoData['isAdmin'])
            : OnBoardingPage(
                userNumber: userInfoData.id,
                user: userInfoData['userName'],
                isAdmin: userInfoData['isAdmin']));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ErrorMessage.toastErrorMessage('비밀번호가 다릅니다');
        return;
      }

      ErrorMessage.toastErrorMessage('잠시 후에 다시 시도해주세요');
    }
  }

  Future<void> _updateAutoLoginStatus(bool boolean) async {
    if (boolean == true) {
      prefs.setBool('autoLoginStatus', true);
    } else {
      prefs.setBool('autoLoginStatus', false);
    }
  }

  Future<void> _saveUserData(String number, String name, bool boolean) async {
    prefs.setString('userNumber', number);
    prefs.setString('user', name);
    prefs.setBool('isAdmin', boolean);
  }

  // Future createUser(String name, String id, String email, String password, String passwordCheck, String authCode) async{
  //   bool isAdmin = false;
  //     if (name == '') {
  //       toastErrorMessage("이름을 입력하세요.");
  //       return;
  //     }
  //     if (id == '') {
  //       toastErrorMessage("학번을 입력하세요.");
  //       return;
  //     }
  //     if (email == '') {
  //       toastErrorMessage("이메일을 입력하세요.");
  //       return;
  //     }
  //     if (password == '') {
  //       toastErrorMessage("비밀번호를 입력하세요.");
  //       return;
  //     }
  //     if (passwordCheck == '') {
  //       toastErrorMessage("비밀번호를 확인해야합니다.");
  //       return;
  //     }
  //     if (password != passwordCheck) {
  //       toastErrorMessage("비밀번호 확인이 안됩니다.");
  //       return;
  //     }
  //     if (authCode != "160") {
  //       toastErrorMessage("학과 번호가 틀렸습니다.");
  //       return;
  //     }

  //     try {
  //       DocumentSnapshot userinfoData =
  //           await FirebaseFirestore
  //               .instance
  //               .collection('UserInfo')
  //               .doc(id)
  //               .get();
  //       if (userinfoData.exists) {
  //         toastMessage(
  //             "이미 존재하는 학번이 있습니다.");
  //         return;
  //       }

  //       await _auth
  //           .createUserWithEmailAndPassword(
  //               email: email,
  //               password: password)
  //           .then((value) {
  //         if (value.user!.email == null) {
  //         } else {
  //           firestore
  //               .collection('UserInfo')
  //               .doc(id)
  //               .set({
  //             'userName': name,
  //             'userNumber':
  //                 id,
  //             'email': email,
  //             'isAdmin': isAdmin,
  //           });
  //         }
  //         return value;
  //       });
  //       _showAuthDialog();

  //       FirebaseAuth.instance.currentUser
  //           ?.sendEmailVerification();
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'weak-password') {
  //         toastMessage(
  //             '비밀번호가 약합니다\n(추천)숫자 + 영어 + 특수문자');
  //         return;
  //       }
  //       if (e.code ==
  //           'email-already-in-use') {
  //         toastMessage('이미 사용된 이메일입니다.');
  //         return;
  //       }
  //       toastMessage("잠시후에 다시 시도해주세요.");
  //     }

  // }
}
