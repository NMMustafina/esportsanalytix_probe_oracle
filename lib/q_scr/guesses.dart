import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/graph_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/qq_tols.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q_scr/add_guesses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Guesses extends StatefulWidget {
  const Guesses({super.key});

  @override
  State<Guesses> createState() => _GuessesState();
}

class _GuessesState extends State<Guesses> {
  @override
  Widget build(BuildContext context) {
    final guesssModlProv = context.watch<GuesssModlProvider>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: QMotiBut(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGuesses()),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          margin: EdgeInsets.only(bottom: 100.h, left: 16.w, right: 16.w),
          decoration: BoxDecoration(
            color: ColorQ.blue,
            borderRadius: BorderRadius.circular(43.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add a new guesses',
                style: TextStyle(
                    color: ColorQ.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'My guesses',
          style: TextStyle(
            color: ColorQ.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                if (guesssModlProv.guessModls.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: GssStatGrph(
                      gssMdls: guesssModlProv.guessModls,
                    ),
                  ),
                Text(
                  'Active',
                  style: TextStyle(
                    color: ColorQ.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (guesssModlProv.getGuesModlActive().isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 24.h),
                    child: Center(
                      child: Text(
                        'Write down your new guess',
                        style: TextStyle(
                          color: ColorQ.grey,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16.h),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final ittm = guesssModlProv.getGuesModlActive()[index];
                      final isSSamDay =
                          ittm.guessModlDate.isSameDay(DateTime.now()) ||
                              ittm.guessModlDate.isBefore(DateTime.now());
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          color: ColorQ.darkGrey,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Guess for ${DateFormat('dd.MM.yyyy').format(ittm.guessModlDate)}",
                              style: TextStyle(
                                color: ColorQ.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Center(
                              child: Text(
                                ittm.guessModlName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorQ.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            if (isSSamDay)
                              SizedBox(
                                height: 16.h,
                              ),
                            if (isSSamDay)
                              Row(
                                children: [
                                  Expanded(
                                    child: QMotiBut(
                                      onPressed: () {
                                        guesssModlProv.addUpdateGuessModl(
                                            ittm.copyWith(
                                                guessAnswer: () =>
                                                    GuessAnswer.wrong));
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF3B30),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Wrong",
                                              style: TextStyle(
                                                color: ColorQ.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: QMotiBut(
                                      onPressed: () {
                                        guesssModlProv.addUpdateGuessModl(
                                            ittm.copyWith(
                                                guessAnswer: () =>
                                                    GuessAnswer.draw));
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF288BF7),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "50/50",
                                              style: TextStyle(
                                                color: ColorQ.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: QMotiBut(
                                      onPressed: () {
                                        guesssModlProv.addUpdateGuessModl(
                                            ittm.copyWith(
                                                guessAnswer: () =>
                                                    GuessAnswer.right));
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF34C759),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Right",
                                              style: TextStyle(
                                                color: ColorQ.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12.h);
                    },
                    itemCount: guesssModlProv.getGuesModlActive().length),
                SizedBox(height: 16.h),
                if (guesssModlProv.getGuesModlHistory().isNotEmpty)
                  Text(
                    'History',
                    style: TextStyle(
                      color: ColorQ.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                SizedBox(height: 16.h),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final ittm = guesssModlProv.getGuesModlHistory()[index];

                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          color: ColorQ.darkGrey,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Guess for ${DateFormat('dd.MM.yyyy').format(ittm.guessModlDate)}",
                                    style: TextStyle(
                                      color: ColorQ.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (ittm.guessAnswer == GuessAnswer.wrong)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.h, horizontal: 8.w),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF3B30),
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Wrong",
                                              style: TextStyle(
                                                color: ColorQ.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (ittm.guessAnswer == GuessAnswer.draw)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.h, horizontal: 8.w),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF288BF7),
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "50/50",
                                              style: TextStyle(
                                                color: ColorQ.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (ittm.guessAnswer == GuessAnswer.right)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.h, horizontal: 8.w),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF34C759),
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Right",
                                              style: TextStyle(
                                                color: ColorQ.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Center(
                              child: Text(
                                ittm.guessModlName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorQ.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12.h);
                    },
                    itemCount: guesssModlProv.getGuesModlHistory().length),
                SizedBox(height: 200.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension DateTimeExt on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
