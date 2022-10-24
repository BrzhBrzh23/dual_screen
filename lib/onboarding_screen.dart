import 'package:dual_screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLastPage = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 150),
          child: PageView(
            onPageChanged: (index) => {
              setState(
                () {
                  isLastPage = index == 2;
                },
              )
            },
            controller: controller,
            children: [
              buildPage(
                  urlImage: 'assets/images/multitask.png',
                  title: 'Multitasking Split Screen',
                  subtitle: 'Quick switch between fullscreen and dual screen'),
              buildPage(
                  urlImage: 'assets/images/browser.png',
                  title: 'Web Browser',
                  subtitle:
                      'Quick and easy access to your favorite websites and screens'),
              buildPage(
                  urlImage: 'assets/images/like.png',
                  title: 'Help us become better',
                  subtitle:
                      'Please let us know. We are looking for any feedback'),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 150,
          color: Constants().onBoardColor,
          child: Column(
            children: [
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Constants().buttonColor),
                      height: 56,
                      width: MediaQuery.of(context).size.width - 112,
                      child: TextButton(
                          child: Text('Continue',
                              style: Constants().boldBlackText),
                          onPressed: () async {
                            if (isLastPage) {
                              final preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setBool('showLogin', true);

                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          }))),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text('Terms of Use',
                        style: Constants().regularWhiteTextFourteen),
                    onPressed: () {},
                  ),
                  TextButton(
                      child: Text(
                        'Restore',
                        style: Constants().regularWhiteTextFourteen,
                      ),
                      onPressed: () {}),
                  TextButton(
                      child: Text('Privacy Policy',
                          style: Constants().regularWhiteTextFourteen),
                      onPressed: () {}),
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildPage(
        {required String urlImage,
        required String title,
        required String subtitle}) =>
    Container(
      color: Constants().onBoardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(children: [
          Expanded(child: Image.asset(urlImage)),
          Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
            style: Constants().boldWhiteText,
          )),
          const SizedBox(
            height: 23,
          ),
          Center(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Constants().regularWhiteText,
            ),
          )
        ]),
      ),
    );
