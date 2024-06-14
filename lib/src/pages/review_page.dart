import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/voca.dart';
import 'package:naruhodo/src/view/review/review_view.dart';
import 'package:naruhodo/src/view/review/review_view_model.dart';
import 'package:naruhodo/src/widgets/app_bar_main_widget.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    super.key,
    required this.vocaList,
    required this.level,
    this.point,
  });
  final int? point;
  final int level;
  final List<Voca> vocaList;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  Future<ReviewViewModel> initViewModel(BuildContext context) async {
    ReviewViewModel viewModel = ReviewViewModel(
      level: widget.level,
      point: widget.point,
      vocaList: widget.vocaList,
      learningService: context.read(),
      reviewService: context.read(),
      authService: context.read(),
      ttsService: context.read(),
    );
    await viewModel.initializer;
    return viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMainWidget(
        text: "REVIEW",
        showBackArrow: true,
      ),
      body: FutureBuilder<ReviewViewModel>(
        future: initViewModel(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return ReviewView(
                viewModel: snapshot.data!,
              );
            }
          }
          // While waiting for the future to finish, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
