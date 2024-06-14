import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/button/custom_button.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/custom/dimensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  dynamic activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Set the background color to white here

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _carouselSlider(height),
            _pageIndicator(),
          ],
        ),
        bottomNavigationBar: _bottomButton(context),
      ),
    );
  }

  Widget _carouselSlider(height) {
    return FlutterCarousel(
      options: CarouselOptions(
          height: height * .75,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          pageSnapping: true,
          autoPlayCurve: Curves.easeInOut,
          enableInfiniteScroll: true,
          viewportFraction: 1.0,
          showIndicator: false,
          onPageChanged: (index, reason) {
            setState(() {
              activeIndex = index;
            });
          }),
      items: [
        _sliderPage1(),
        _sliderPage2(),
      ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalPadding, vertical: 0),
      child: CustomButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/login');
          Navigator.pushReplacementNamed(
            context,
            RoutePath.home,
          );
        },
        buttonName: "Get Started",
        buttonInsideColor: context.color.primary,
        buttonBorderColor: context.color.primary,
      ),
    );
  }

  Widget _sliderPage1() {
    return AnimatedOpacity(
        opacity: activeIndex == 0 ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 888),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.walk,
              repeat: true,
              height: 250,
            ),
            const SizedBox(height: 16),
            Text(
              "Speak Easy",
              style: context.typo.headline4.copyWith(
                fontWeight: context.typo.semiBold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                "Essential prerequisites for language learning.\n Listen and speak easily anytime, anywhere.",
                style: context.typo.body2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }

  Widget _sliderPage2() {
    return AnimatedOpacity(
      opacity: activeIndex == 1 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 888),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.cycle,
            repeat: true,
            height: 250,
          ),
          const SizedBox(height: 16),
          Text(
            "Boost Your Learning",
            style: context.typo.headline4.copyWith(
              fontWeight: context.typo.semiBold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Rich examples provided!\nStudying within context enhances learning efficiency",
            style: context.typo.body2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _pageIndicator() {
    // double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          axisDirection: Axis.horizontal,
          count: 2,
          effect: ExpandingDotsEffect(
            dotColor: context.color.background,
            activeDotColor: context.color.primary,
            dotWidth: 10,
            dotHeight: 8,
          ),
          // your preferred effect
          onDotClicked: (index) {}),
    );
  }
}
