import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q_scr/guesses.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q_scr/homee.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q_scr/player.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q_scr/seersettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QBotomBar extends StatefulWidget {
  const QBotomBar({super.key, this.indexScr = 0});
  final int indexScr;

  @override
  State<QBotomBar> createState() => QBotomBarState();
}

class QBotomBarState extends State<QBotomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 75.h,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF27273A),
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: const Color(0xFF3B3B4C),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: buildNavItem(
              0,
              'assets/icons/1.png',
              'assets/icons/11.png',
            )),
            Expanded(
                child: buildNavItem(
              1,
              'assets/icons/2.png',
              'assets/icons/22.png',
            )),
            Expanded(
                child: buildNavItem(
              2,
              'assets/icons/3.png',
              'assets/icons/33.png',
            )),
            Expanded(
                child: buildNavItem(
              3,
              'assets/icons/4.png',
              'assets/icons/44.png',
            )),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String iconPath, String nul) {
    bool isActive = _currentIndex == index;

    return QMotiBut(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isActive ? iconPath : nul,
                width: 26.w,
                height: 26.h,
              ),
              // const SizedBox(height: 5),
              // Text(
              //   t,
              //   style: TextStyle(
              //     color: isActive
              //         ? ColorQ.blue
              //         : const Color.fromARGB(158, 147, 147, 147),
              //     fontWeight: FontWeight.w400,
              //     fontSize: 10.sp,
              //     height: 1.sp,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final _pages = <Widget>[
    const Homee(),
    const Player(),
    const Guesses(),
    const Seersettings(),
  ];
}
