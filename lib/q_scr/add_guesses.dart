import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/qq_tols.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q_scr/guesses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddGuesses extends StatefulWidget {
  const AddGuesses({super.key});

  @override
  State<AddGuesses> createState() => _AddGuessesState();
}

class _AddGuessesState extends State<AddGuesses> {
  final TextEditingController _gssCtrlr = TextEditingController();
  DateTime _slctdDt = DateTime.now();

  @override
  void dispose() {
    _gssCtrlr.dispose();
    super.dispose();
  }

  Future<void> _slctDt(BuildContext cntxt) async {
    final DateTime? pckd = await showModalBottomSheet<DateTime>(
      context: cntxt,
      backgroundColor: Colors.transparent,
      builder: (BuildContext cntxt) {
        return Container(
          decoration: BoxDecoration(
            color: ColorQ.darkGrey,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorQ.grey,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 300.h,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (cntxt, indx) {
                    final dt = DateTime.now().add(Duration(days: indx));
                    final isTdy = indx == 0;
                    return QMotiBut(
                      onPressed: () {
                        Navigator.pop(cntxt, dt);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 4.h,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: _slctdDt.isSameDay(dt)
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            isTdy
                                ? 'Today'
                                : DateFormat('E MMM d').format(dt),
                            style: TextStyle(
                              color: _slctdDt.isSameDay(dt)
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pckd != null) {
      setState(() {
        _slctdDt = pckd;
      });
    }
  }

  @override
  Widget build(BuildContext cntxt) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: ColorQ.white),
          onPressed: () => Navigator.pop(cntxt),
        ),
        title: Text(
          'Add guesses',
          style: TextStyle(
            color: ColorQ.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Your guesses',
                style: TextStyle(
                  color: ColorQ.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _gssCtrlr,
                style: TextStyle(color: ColorQ.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorQ.darkGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Your guesses',
                  hintStyle: TextStyle(
                    color: ColorQ.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Date',
                style: TextStyle(
                  color: ColorQ.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8.h),
              QMotiBut(
                onPressed: () => _slctDt(cntxt),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorQ.darkGrey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd.MM.yyyy').format(_slctdDt),
                        style: TextStyle(
                          color: ColorQ.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: ColorQ.white,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              QMotiBut(
                onPressed: () {
                  if (_gssCtrlr.text.isNotEmpty) {
                    final prvdr = cntxt.read<GuesssModlProvider>();
                    final nwGss = GuessModl(
                      guessModlid: DateTime.now().millisecondsSinceEpoch,
                      guessModlDate: _slctdDt,
                      guessModlName: _gssCtrlr.text,
                    );
                    prvdr.addUpdateGuessModl(nwGss);
                    Navigator.pop(cntxt);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: ColorQ.blue,
                    borderRadius: BorderRadius.circular(43.r),
                  ),
                  child: Center(
                    child: Text(
                      'Add guesses',
                      style: TextStyle(
                        color: ColorQ.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
