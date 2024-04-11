import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/pages/welcome/blocs/bloc/welcome_bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: Container(
        child: Scaffold(
          body: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(top: 34.h),
                width: 375.w,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        state.page = index;
                        BlocProvider.of<WelcomeBloc>(context)
                            .add(WelcomeEvent());
                      },
                      children: [
                        _page(
                            1,
                            context,
                            'Next',
                            "Unravel Cinematic Mastery",
                            "Embark on a journey through the cinematic masterpiece that redefined storytelling. Explore the intricate web of power dynamics, riveting drama, and unforgettable performances.",
                            "assets/moviesAssets/godfather.jpg"),
                        _page(
                            2,
                            context,
                            'Next',
                            "Discover Seamless Navigation",
                            "Swing through our app with the agility and precision of your favorite web-slinging hero. Experience seamless navigation that takes you from one thrilling adventure to the next.",
                            "assets/moviesAssets/spiderman.jpg"),
                        _page(
                            3,
                            context,
                            'Get Started',
                            "Create Your Inner Circle",
                            "Build your own close-knit community of favorite movies. Save movies to your favorites list, curate your own collection, and enjoy the comfort of knowing your cinematic companions are always close at hand",
                            "assets/moviesAssets/friends.jpg"),
                      ],
                    ),
                    Positioned(
                      bottom: 60.h,
                      child: DotsIndicator(
                        position: state.page,
                        dotsCount: 3,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                            activeColor: AppColors.primaryElement,
                            color: AppColors.primaryThirdElementText,
                            size: const Size.square(8.0),
                            activeSize: const Size(15.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subtitle, String imagePath) {
    return Container(
      height: 350.h,
      decoration: BoxDecoration(
        image: DecorationImage(
            opacity: 0.3, image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 290.w,
          ),
          SizedBox(
              height: 120,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Container(
            width: 375.w,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              subtitle,
              style: TextStyle(
                color: AppColors.primarySecondaryElementText,
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                if (index < 3) {
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                } else {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const MyHomePage(),
                  //   ),
                  // );
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/sign_in", (route) => false);
                }
              },
              child: Center(
                child: Text(
                  buttonName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
