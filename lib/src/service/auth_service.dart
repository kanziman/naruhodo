import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naruhodo/util/helper/avatar_helper.dart';
import 'package:naruhodo/util/custom/common_consts.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:naruhodo/util/helper/security_helper.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;
  User? user;

  void initUser() {
    user = currentUser();
    if (user != null) {
      loadUserData();
    }
  }

  User? currentUser() {
    String? uid = _firebaseAuth.currentUser?.uid;

    if (uid != null) {
      FirebaseFirestore.instance.collection('users');
    }

    return _firebaseAuth.currentUser;
  }

  // Method to fetch user details from Firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
    } else {
      throw Exception('No user logged in');
    }
  }

  void loadUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await getUserData();
      _userData = userData.data();
      notifyListeners();
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }

  // Stream of authentication state changes
  Stream<User?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  void signUp({
    required String email, // 이메일
    required String password, // 비밀번호
    required String confirmPassword,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    // 회원가입
    // 이메일 및 비밀번호 입력 여부 확인
    if (email.isEmpty) {
      onError(S.current.checkEmail);
      return;
    } else if (password.isEmpty || confirmPassword.isEmpty) {
      onError(S.current.checkPw);
      return;
    } else if (password != confirmPassword) {
      onError(S.current.pwCheckNeeded);
      return;
    }

    // firebase auth 회원 가입
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final securityUtil = SecurityUtil(keyString: ENC_KEY);
      String encryptedEmail = securityUtil.encrypt(email);
      log('encryptedEmail $encryptedEmail');

      String decryptedEmail = securityUtil.decrypt(encryptedEmail);
      log('decryptedEmail $decryptedEmail');

      // Get the UID of the newly created user
      String uid = userCredential.user!.uid;
      // Generate a random avatar URL
      String avatarUrl = Avatar.generateRandomAvatarUrl();

      // Save additional user information in Firestore under the 'users' collection
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': encryptedEmail,
        'createdAt': FieldValue.serverTimestamp(),
        'avatarUrl': avatarUrl
      });

      // 성공 함수 호출
      onSuccess();
    } on FirebaseAuthException catch (e) {
      // Firebase auth 에러 발생
      if (e.code == 'weak-password') {
        onError(S.current.moreThan6);
      } else if (e.code == 'email-already-in-use') {
        onError(S.current.alreadySignUp);
      } else if (e.code == 'invalid-email') {
        onError(S.current.emailFormCheckNeeded);
      } else if (e.code == 'user-not-found') {
        onError(S.current.noEmail);
      } else if (e.code == 'wrong-password') {
        onError(S.current.pwCheckNeeded);
      } else if (e.code == 'invalid-credential') {
        log('The supplied auth credential is malformed or has expired.');
        onError(e.message!);
      } else {
        onError(e.message!);
      }
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }

  void signIn({
    required String email, // 이메일
    required String password, // 비밀번호
    required Function() onSuccess, // 로그인 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  }) async {
    // 로그인
    if (email.isEmpty) {
      onError(S.current.checkEmail);
      return;
    } else if (password.isEmpty) {
      onError(S.current.checkPw);
      return;
    }

    // 로그인 시도
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess(); // 성공 함수 호출
      notifyListeners(); // 로그인 상태 변경 알림
    } on FirebaseAuthException catch (e) {
      onError(e.message!);
    } catch (e) {
      onError(e.toString());
    }
  }

  Future signOut() async {
    // 로그아웃
    await FirebaseAuth.instance.signOut();
    _userData = null;
    notifyListeners(); // 로그인 상태 변경 알림
  }

  /// Google sign in
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new credentials for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //sign in!
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> deleteUserAccount(onSuccess) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Re-authenticate the user before deletion for security
      // Example: You might ask for their password again or use any re-authentication method

      // Delete user data from Firestore
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      DocumentReference userDoc = users.doc(user.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.delete(userDoc);
        // Add more deletions here if the user has data in more collections
      }).then((_) async {
        await user.delete();
        onSuccess();
        log('successfully deleted');
      }).catchError((error) {
        log("Failed to delete user: $error");
      });
    }
  }
}
