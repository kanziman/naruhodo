// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Naruhodo`
  String get app {
    return Intl.message(
      'Naruhodo',
      name: 'app',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Korean`
  String get ko {
    return Intl.message(
      'Korean',
      name: 'ko',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Speak`
  String get speak {
    return Intl.message(
      'Speak',
      name: 'speak',
      desc: '',
      args: [],
    );
  }

  /// `Vocabulary`
  String get voca {
    return Intl.message(
      'Vocabulary',
      name: 'voca',
      desc: '',
      args: [],
    );
  }

  /// `My`
  String get my {
    return Intl.message(
      'My',
      name: 'my',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get loginSuccess {
    return Intl.message(
      'Login Success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Success`
  String get signUpSuccess {
    return Intl.message(
      'Sign Up Success',
      name: 'signUpSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get pw {
    return Intl.message(
      'Password',
      name: 'pw',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPw {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPw',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Join now`
  String get join {
    return Intl.message(
      'Join now',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Not a Member ?`
  String get notMember {
    return Intl.message(
      'Not a Member ?',
      name: 'notMember',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?`
  String get alreadyAccount {
    return Intl.message(
      'Already have an account ?',
      name: 'alreadyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login now`
  String get loginNow {
    return Intl.message(
      'Login now',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password of at least 6 characters.`
  String get moreThan6 {
    return Intl.message(
      'Please enter a password of at least 6 characters.',
      name: 'moreThan6',
      desc: '',
      args: [],
    );
  }

  /// `This email is already registered.`
  String get alreadySignUp {
    return Intl.message(
      'This email is already registered.',
      name: 'alreadySignUp',
      desc: '',
      args: [],
    );
  }

  /// `Please check the email format.`
  String get emailFormCheckNeeded {
    return Intl.message(
      'Please check the email format.',
      name: 'emailFormCheckNeeded',
      desc: '',
      args: [],
    );
  }

  /// `No matching email found.`
  String get noEmail {
    return Intl.message(
      'No matching email found.',
      name: 'noEmail',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get pwCheckNeeded {
    return Intl.message(
      'Passwords do not match.',
      name: 'pwCheckNeeded',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email.`
  String get checkEmail {
    return Intl.message(
      'Please enter your email.',
      name: 'checkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password.`
  String get checkPw {
    return Intl.message(
      'Please enter your password.',
      name: 'checkPw',
      desc: '',
      args: [],
    );
  }

  /// `Alphabet Table`
  String get alphabetDesc {
    return Intl.message(
      'Alphabet Table',
      name: 'alphabetDesc',
      desc: '',
      args: [],
    );
  }

  /// `Great !`
  String get great {
    return Intl.message(
      'Great !',
      name: 'great',
      desc: '',
      args: [],
    );
  }

  /// `You are ready to go to the next step`
  String get greatDesc {
    return Intl.message(
      'You are ready to go to the next step',
      name: 'greatDesc',
      desc: '',
      args: [],
    );
  }

  /// `There is nothing to review yet.`
  String get noReview {
    return Intl.message(
      'There is nothing to review yet.',
      name: 'noReview',
      desc: '',
      args: [],
    );
  }

  /// `Continue your learning`
  String get learningCheer {
    return Intl.message(
      'Continue your learning',
      name: 'learningCheer',
      desc: '',
      args: [],
    );
  }

  /// `continue`
  String get continueMessage {
    return Intl.message(
      'continue',
      name: 'continueMessage',
      desc: '',
      args: [],
    );
  }

  /// `Added`
  String get added {
    return Intl.message(
      'Added',
      name: 'added',
      desc: '',
      args: [],
    );
  }

  /// `Fail`
  String get fail {
    return Intl.message(
      'Fail',
      name: 'fail',
      desc: '',
      args: [],
    );
  }

  /// `There is no card.`
  String get noCard {
    return Intl.message(
      'There is no card.',
      name: 'noCard',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `PASS`
  String get pass {
    return Intl.message(
      'PASS',
      name: 'pass',
      desc: '',
      args: [],
    );
  }

  /// `don't keep`
  String get passDesc {
    return Intl.message(
      'don\'t keep',
      name: 'passDesc',
      desc: '',
      args: [],
    );
  }

  /// `GOOD`
  String get good {
    return Intl.message(
      'GOOD',
      name: 'good',
      desc: '',
      args: [],
    );
  }

  /// `+3day`
  String get goodDesc {
    return Intl.message(
      '+3day',
      name: 'goodDesc',
      desc: '',
      args: [],
    );
  }

  /// `HARD`
  String get hard {
    return Intl.message(
      'HARD',
      name: 'hard',
      desc: '',
      args: [],
    );
  }

  /// `+1day`
  String get hardDesc {
    return Intl.message(
      '+1day',
      name: 'hardDesc',
      desc: '',
      args: [],
    );
  }

  /// `KEEP`
  String get keep {
    return Intl.message(
      'KEEP',
      name: 'keep',
      desc: '',
      args: [],
    );
  }

  /// `save it`
  String get keepDesc {
    return Intl.message(
      'save it',
      name: 'keepDesc',
      desc: '',
      args: [],
    );
  }

  /// `5min`
  String get duration5 {
    return Intl.message(
      '5min',
      name: 'duration5',
      desc: '',
      args: [],
    );
  }

  /// `Katakana`
  String get katakana {
    return Intl.message(
      'Katakana',
      name: 'katakana',
      desc: '',
      args: [],
    );
  }

  /// `Hiragana`
  String get hiragana {
    return Intl.message(
      'Hiragana',
      name: 'hiragana',
      desc: '',
      args: [],
    );
  }

  /// `Patterns`
  String get patterns {
    return Intl.message(
      'Patterns',
      name: 'patterns',
      desc: '',
      args: [],
    );
  }

  /// `Examples`
  String get examples {
    return Intl.message(
      'Examples',
      name: 'examples',
      desc: '',
      args: [],
    );
  }

  /// `Correct!`
  String get correct {
    return Intl.message(
      'Correct!',
      name: 'correct',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! You've got the right answer.`
  String get correctSub {
    return Intl.message(
      'Congratulations! You\'ve got the right answer.',
      name: 'correctSub',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect!`
  String get incorrect {
    return Intl.message(
      'Incorrect!',
      name: 'incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Try again.`
  String get incorrectSub {
    return Intl.message(
      'Try again.',
      name: 'incorrectSub',
      desc: '',
      args: [],
    );
  }

  /// `Random`
  String get random {
    return Intl.message(
      'Random',
      name: 'random',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete?`
  String get deleteDialogDesc {
    return Intl.message(
      'Do you want to delete?',
      name: 'deleteDialogDesc',
      desc: '',
      args: [],
    );
  }

  /// `Committed to follow the Play Families policy`
  String get safety {
    return Intl.message(
      'Committed to follow the Play Families policy',
      name: 'safety',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
