import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/progress.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/service/review_service.dart';
import 'package:naruhodo/src/view/base/base_view_model.dart';
import 'package:naruhodo/util/custom/common_consts.dart';
import 'package:naruhodo/util/helper/security_helper.dart';

class MyViewModel extends BaseViewModel {
  late final LearningService learningService;
  late final ReviewService reviewService;
  late final AuthService authService;

  User? user;
  StreamSubscription<User?>? authSubscription;
  VoidCallback? onUserLoggedOut;

  MyViewModel({
    required this.learningService,
    required this.reviewService,
    required this.authService,
    this.onUserLoggedOut,
  }) {
    _initUser();
    reviewService.addListener(notifyListeners);
    _subscribeToAuthChanges();
  }

  void _initUser() {
    user = authService.currentUser();
    if (user != null) {
      authService.loadUserData();
    }
  }

  void _subscribeToAuthChanges() {
    User? previousUser = authService.currentUser();
    authSubscription = authService.onAuthStateChanged.listen((User? newUser) {
      // log('Previous user: $previousUser');
      // log('New user: $newUser');

      if (previousUser != null && newUser == null) {
        log('User has logged out');
        onUserLoggedOut?.call();
      }

      // Update the previous user after handling the potential logout
      previousUser = newUser;
      notifyListeners();
    });
  }

  void signOut() {
    authService.signOut();
  }

  @override
  void dispose() {
    authSubscription?.cancel();
    reviewService.removeListener(notifyListeners);
    super.dispose();
  }

  /// REVIEW
  Map<String, Progress> get progressMap => reviewService.progressMap;
  Map<String, Progress> newProgressMap() {
    return reviewService.progressMap;
  }

  Map get vocasMap => reviewService.vocasMap;

  User? get currentUser => user;
  Map<String, dynamic>? get userData => authService.userData;

  final securityUtil = SecurityUtil(keyString: ENC_KEY);
  String? get email => securityUtil.decrypt(userData?['email']);
  // String? get email => (userData?['email']);

  // 회원탈퇴
  void onDeletePressed() {
    authService.deleteUserAccount(authService.signOut);
  }

// 리뷰카드삭제
  void onResetPressed(String topic) {
    reviewService.resetUserReview(topic, user);
  }

  /// Refresh
  Future<void> refreshData() async {
    loadData(useCache: false);
  }

  void loadData({useCache}) async {
    learningService.setQueryRequest(const QueryRequest(
      subjectType: SubjectType.voca,
    ));
    User user = authService.currentUser()!;

    isBusy = true;
    try {
      await Future.wait([
        reviewService.loadData(user.uid, useCache: useCache),
        Future.delayed(const Duration(milliseconds: 555)),
      ]);
    } finally {
      isBusy = false;
    }
  }
}
