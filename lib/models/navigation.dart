import 'package:app_lock_flutter/screens/app_list.dart';
import 'package:app_lock_flutter/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeNavigator extends StatelessWidget {
  HomeNavigator({super.key});

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.98,
              child: PageView(
                controller: _controller,
                children: const [
                  AppCard(),
                  SettingsPage(),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 2,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotHeight: 5,
                dotWidth: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
