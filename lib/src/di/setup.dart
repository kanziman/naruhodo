import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naruhodo/src/repository/voca_repository.dart';
import 'package:naruhodo/src/repository/word_repository.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/src/service/category_service.dart';
import 'package:naruhodo/src/service/lang_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/service/nav_service.dart';
import 'package:naruhodo/src/service/review_service.dart';
import 'package:naruhodo/src/service/speak_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/service/tts_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 1. Provider 전체
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

// 2. 독립적인 객체
List<SingleChildWidget> independentModels = [
  Provider<FirebaseFirestore>(
    create: (context) => FirebaseFirestore.instance,
  ),
];

// 3. 2번에 의존성 있는 객체
List<SingleChildWidget> dependentModels = [
  ProxyProvider<FirebaseFirestore, WordRepository>(
    update: (context, firestore, _) => WordRepository(firestore: firestore),
  ),
  ProxyProvider<FirebaseFirestore, VocaRepository>(
    update: (context, firestore, _) => VocaRepository(firestore: firestore),
  ),
  ChangeNotifierProxyProvider2<WordRepository, VocaRepository, LearningService>(
    create: (context) => LearningService(
      Provider.of<WordRepository>(context, listen: false),
      Provider.of<VocaRepository>(context, listen: false),
    ),
    update: (context, wordRepository, vocaRepository, learningService) =>
        LearningService(
      wordRepository,
      vocaRepository,
    ),
  ),
  ChangeNotifierProxyProvider<VocaRepository, ReviewService>(
    create: (context) => ReviewService(
      vocaRepository: Provider.of<VocaRepository>(context, listen: false),
    ),
    update: (context, vocaRepository, reviewService) => ReviewService(
      vocaRepository: vocaRepository,
    ),
  ),
];

// 4. ViewModels
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<ThemeService>(
    create: (context) => ThemeService(),
  ),
  ChangeNotifierProvider<LangService>(
    create: (context) => LangService(),
  ),
  ChangeNotifierProvider<SectionService>(
    create: (context) => SectionService()..init(),
  ),
  ChangeNotifierProvider<AuthService>(
    create: (context) => AuthService()..initUser(),
  ),
  ChangeNotifierProvider<NavService>(
    create: (context) => NavService(),
  ),
  ChangeNotifierProvider<SpeakService>(
    create: (context) => SpeakService()..initSpeech(),
  ),
  ChangeNotifierProvider<TtsService>(
    create: (context) => TtsService(),
  ),
];
