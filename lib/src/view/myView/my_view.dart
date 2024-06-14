import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/model/progress.dart';
import 'package:naruhodo/src/model/voca.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/myView/my_view_model.dart';
import 'package:naruhodo/src/widgets/dialog/user_delete_dialog.dart';
import 'package:naruhodo/src/widgets/dialog/user_review_delete_dialog.dart';
import 'package:naruhodo/src/widgets/empty/review_empty.dart';
import 'package:naruhodo/src/widgets/section/my_view_content_card.dart';
import 'package:naruhodo/src/widgets/user_detail.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/theme/res/layout.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';

class MyView extends StatefulWidget {
  const MyView({
    super.key,
    required this.viewModel,
  });

  final MyViewModel viewModel;

  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width * .8;

    return BaseView(
      viewModel: widget.viewModel,
      builder: (context, viewModel) => Stack(
        children: [
          Column(
            children: [
              if (viewModel.userData != null)
                _buildUserDetail(context, viewModel),
              const SizedBox(height: 36),
              _buildContent(viewModel),

              /// 로그아웃
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Button(
                    width: double.infinity,
                    size: ButtonSize.medium,
                    text: S.current.logOut,
                    backgroundColor: context.color.secondary,
                    onPressed: viewModel.signOut),
              ),

              /// 탈퇴
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                child: Button(
                    width: double.infinity,
                    size: ButtonSize.medium,
                    text: S.current.deleteAccount,
                    backgroundColor: context.color.hint,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return UserDelelteDialog(
                            onDeletePressed: widget.viewModel.onDeletePressed,
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(MyViewModel viewModel) {
    Map<String, Progress> progressMap = viewModel.progressMap;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Expanded(
      child: progressMap.isEmpty
          ? const ReviewEmpty()
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: context.layout(width * .95,
                          tablet: width * .5, desktop: width * .5),
                      maxHeight: context.layout(height * .3,
                          tablet: width * .3, desktop: width * .3),
                    ),
                    child: Swiper(
                      itemBuilder: (context, index) {
                        var entry = progressMap.entries.toList()[index];
                        var progress = entry.value;
                        List<Voca> vocaList =
                            viewModel.vocasMap[entry.key] ?? [];
                        return Center(
                          child: MyViewContentCard(
                            topic: entry.key,
                            percent: progress.percent,
                            totalCards: progress.totalCards,
                            reviewedCards: progress.reviewedCards,
                            onTap: () {
                              _moveRouteToReview(vocaList, index, context,
                                  progress.reviewedCards);
                            },
                            onResetPressed: (topic) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return UserReviewDelelteDialog(
                                    topic: topic,
                                    onResetPressed: viewModel.onResetPressed,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                      itemCount: progressMap.length,
                      viewportFraction: 0.8,
                      scale: 0.9, // Adjust scale if needed
                      loop: false,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildUserDetail(BuildContext context, MyViewModel viewModel) {
    return Column(
      children: [
        UserDeatil(
          context: context,
          email: viewModel.email ?? '',
          avatarUrl: viewModel.userData?['avatarUrl'] ?? '',
        ),
        Button(
          onPressed: widget.viewModel.refreshData,
          type: ButtonType.flat,
          iconData: Icons.refresh,
          text: 'Refresh',
        ),
      ],
    );
  }

  void _moveRouteToReview(
      List<Voca> vocaList, int index, BuildContext context, reviewedCards) {
    final Map<String, dynamic> arguments = {
      'vocaList': vocaList,
      'key': index, // 0, 1, 2
      'point': reviewedCards, // start Point
    };

    Navigator.pushNamed(
      context,
      RoutePath.review,
      arguments: arguments,
    );
  }
}
