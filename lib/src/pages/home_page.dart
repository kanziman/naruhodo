import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/lang_service.dart';
import 'package:naruhodo/src/service/nav_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/home/home_view.dart';
import 'package:naruhodo/src/pages/my_page.dart';
import 'package:naruhodo/src/pages/pattern_page.dart';
import 'package:naruhodo/src/pages/voca_page.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  List<Widget> get _bottomNavBarPages {
    var currentLocale = context.watch<LangService>().locale.toString();
    return [
      HomeView(key: ValueKey(currentLocale)),
      PatternPage(key: ValueKey(currentLocale)),
      VocaPage(key: ValueKey(currentLocale)),
      MyPage(key: ValueKey(currentLocale)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navService = Provider.of<NavService>(context);
    _currentPage = navService.navPage;

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _bottomNavBarPages[_currentPage],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.color.background.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentPage,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: context.color.primary,
        unselectedItemColor: context.color.text,
        backgroundColor: context.color.surface,
        elevation: 10.0,
        onTap: (value) {
          context.read<NavService>().updateNavPage(value);
        },
        items: [
          BottomNavigationBarItem(
            label: S.current.home,
            icon: Icon(
              Icons.home_filled,
              color: _currentPage == 0
                  ? context.color.primary
                  : context.color.text,
            ),
          ),
          BottomNavigationBarItem(
            label: S.current.speak,
            icon: Icon(
              Icons.mic,
              color: _currentPage == 1
                  ? context.color.primary
                  : context.color.text,
            ),
          ),
          BottomNavigationBarItem(
            label: S.current.voca,
            icon: Icon(
              Icons.lightbulb_sharp,
              color: _currentPage == 2
                  ? context.color.primary
                  : context.color.text,
            ),
          ),
          BottomNavigationBarItem(
            label: S.current.my,
            icon: Icon(
              Icons.more,
              color: _currentPage == 3
                  ? context.color.primary
                  : context.color.text,
            ),
          ),
        ],
      ),
    );
  }
}
