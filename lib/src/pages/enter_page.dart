import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/service/lang_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/view/card/alphatbet/alphabet_card_view.dart';
import 'package:naruhodo/src/view/card/alphatbet/alphabet_table_view.dart';
import 'package:naruhodo/src/view/card/card_view.dart';
import 'package:naruhodo/src/view/card/card_view_model.dart';
import 'package:naruhodo/src/view/card/voca/voca_view.dart';
import 'package:naruhodo/src/view/card/voca/voca_view_model.dart';
import 'package:naruhodo/src/view/pattern/pattern_view.dart';
import 'package:naruhodo/src/view/pattern/pattern_view_model.dart';
import 'package:naruhodo/src/view/quiz/quiz_view.dart';
import 'package:naruhodo/src/view/quiz/quiz_view_model.dart';
import 'package:naruhodo/src/view/sentence/sentence_view.dart';
import 'package:naruhodo/src/view/sentence/sentence_view_model.dart';
import 'package:naruhodo/theme/component/appbar/app_bar_button.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/theme/component/pop_button.dart';
import 'package:provider/provider.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({
    super.key,
    required this.queryRequest,
  });
  final QueryRequest queryRequest;

  @override
  State<LearningPage> createState() => LearningPageState();
}

class LearningPageState extends State<LearningPage> {
  // late final LearningService learningService = context.read();
  // late final CardViewModel cardViewModel = CardViewModel(
  //     learningService: context.read(), ttsService: context.read());
  // late final PatternViewModel patternViewModel = PatternViewModel(
  //     learningService: context.read(), ttsService: context.read());
  // late final SentenceViewModel sentenceViewModel = SentenceViewModel(
  //     learningService: context.read(), ttsService: context.read());
  // late final QuizViewModel quizViewModel = QuizViewModel(
  //     learningService: context.read(),
  //     speakService: context.read(),
  //     ttsService: context.read());
  // late final VocaViewModel vocaViewModel = VocaViewModel(
  //     learningService: context.read(),
  //     authService: context.read(),
  //     reviewService: context.read(),
  //     ttsService: context.read());

  // @override
  // void initState() {
  //   super.initState();
  //   // log("subjectType >> ${widget.queryRequest.subjectType}");
  //   // log("topic >> ${widget.queryRequest.topic}");
  //   // log("from >> ${widget.queryRequest.from}");
  //   learningService.setQueryRequest(widget.queryRequest);
  // }

  late final LearningService learningService;
  late final CardViewModel cardViewModel;
  late final PatternViewModel patternViewModel;
  late final SentenceViewModel sentenceViewModel;
  late final QuizViewModel quizViewModel;
  late final VocaViewModel vocaViewModel;
  @override
  void initState() {
    super.initState();
    final contextRead = context.read;
    learningService = contextRead();
    cardViewModel = CardViewModel(
        learningService: contextRead(), ttsService: contextRead());
    patternViewModel = PatternViewModel(
        learningService: contextRead(), ttsService: contextRead());
    sentenceViewModel = SentenceViewModel(
        learningService: contextRead(), ttsService: contextRead());
    quizViewModel = QuizViewModel(
      learningService: contextRead(),
      speakService: contextRead(),
      ttsService: contextRead(),
    );
    vocaViewModel = VocaViewModel(
      learningService: contextRead(),
      authService: contextRead(),
      reviewService: contextRead(),
      ttsService: contextRead(),
    );

    learningService.setQueryRequest(widget.queryRequest);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LangService>().locale;
    return Scaffold(
        appBar: AppBar(
          leading: const PopButton(),
          titleSpacing: 0,
          actions: const [
            AppBarButton(),
          ],
        ),
        body: (SubjectType.voca == widget.queryRequest.subjectType ||
                SubjectType.review == widget.queryRequest.subjectType)
            ? _buildContent()
            : SafeArea(child: _buildContent()));
  }

  Widget _buildContent() {
    switch (widget.queryRequest.subjectType) {
      case SubjectType.hiraganaTable:
      case SubjectType.katakanaTable:
        return AlphabetTableView(
          viewModel: cardViewModel,
          crossAxisCount: 5,
        );
      case SubjectType.hiragana:
      case SubjectType.katakana:
        return AlphabetCardView(
          viewModel: cardViewModel,
          cardSize: CardSize.xlarge,
        );
      case SubjectType.hiraganaWord:
      case SubjectType.katakanaWord:
        return CardView(
          viewModel: cardViewModel,
        );
      case SubjectType.hiraganaSentence:
      case SubjectType.katakanaSentence:
        return VocaSentenceView(
          viewModel: sentenceViewModel,
        );
      case SubjectType.quiz:
        return VocaQuizView(
          viewModel: quizViewModel,
        );
      case SubjectType.pattern:
        return PatternView(
          viewModel: patternViewModel,
        );
      case SubjectType.voca:
        return VocaView(
          viewModel: vocaViewModel,
        );
      case SubjectType.review:
        return VocaView(
          viewModel: vocaViewModel,
        );
    }
  }
}
