import 'package:esportsanalytix_probe_oracle_221_t/q/botbar_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QOnBoDi extends StatefulWidget {
  const QOnBoDi({super.key});

  @override
  State<QOnBoDi> createState() => _QOnBoDiState();
}

class _QOnBoDiState extends State<QOnBoDi> {
  final PageController _controller = PageController();
  int introIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorQ.white,
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                introIndex = index;
              });
            },
            children: const [
              OnWid(
                image: '1',
              ),
              OnWid(
                image: '2',
              ),
              OnWid(
                image: '3',
              ),
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                QMotiBut(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QBotomBar(),
                      ),
                      (protected) => false,
                    );
                  },
                  child: Container(
                    height: 55,
                    width: 100,
                    margin: const EdgeInsets.only(left: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(
                            color: ColorQ.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            height: 1.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 500.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const SlideEffect(
                      dotColor: Color(0xFF27273A),
                      activeDotColor: ColorQ.blue,
                      dotWidth: 16,
                      dotHeight: 7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 690.h),
            child: Row(
              children: [
                Expanded(
                  child: QMotiBut(
                    onPressed: () {
                      if (introIndex != 2) {
                        _controller.animateToPage(
                          introIndex + 1,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QBotomBar(),
                          ),
                          (protected) => false,
                        );
                      }
                    },
                    child: Container(
                      height: 55.h,
                      margin: const EdgeInsets.only(right: 24, left: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(43),
                        color: introIndex == 1 ? ColorQ.blue : ColorQ.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            introIndex != 2 ? 'Next' : 'Start',
                            style: TextStyle(
                              color: ColorQ.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              height: 1.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnWid extends StatelessWidget {
  const OnWid({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/on$image.png',
      height: 812.h,
      width: 305.w,
      fit: BoxFit.cover,
      // alignment: Alignment.bottomCenter,
    );
  }
}
