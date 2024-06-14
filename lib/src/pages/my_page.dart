import 'package:flutter/material.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/view/myView/my_view.dart';
import 'package:naruhodo/src/view/myView/my_view_model.dart';
import 'package:naruhodo/src/widgets/app_bar_main_widget.dart';
import 'package:naruhodo/src/widgets/empty/user_empty.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late final MyViewModel viewModel = MyViewModel(
    learningService: context.read(),
    authService: context.read(),
    reviewService: context.read(),
    onUserLoggedOut: _handleLogout,
  );

  void _handleLogout() {
    // Use context to navigate
    // print('logout??');
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutePath.home,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = viewModel.user;

    return Scaffold(
      appBar: const AppBarMainWidget(
        text: "My Page",
        showBackArrow: false,
      ),
      body: SafeArea(
        child: (user == null)
            ? UserEmpty(
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    RoutePath.auth,
                  );
                },
              )
            : MyView(viewModel: viewModel),
      ),
    );
  }

  // Padding searchRow() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 16,
  //       vertical: 8,
  //     ),
  //     child: Row(
  //       children: [
  //         /// 검색
  //         Expanded(
  //           child: InputField(
  //             hint: S.current.searchProduct,
  //           ),
  //         ),
  //         const SizedBox(width: 16),

  //         /// 검색 버튼
  //         Button(
  //           icon: 'search',
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
