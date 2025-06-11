import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final bool isEnabled;
  final bool isEditing;
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.isEnabled,
    required this.isEditing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return QMotiBut(
      onPressed: isEnabled ? onPressed : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: isEnabled ? ColorQ.blue : ColorQ.grey,
          borderRadius: BorderRadius.circular(43.r),
        ),
        child: Center(
          child: Text(
            isEditing ? 'Save' : 'Add a player',
            style: TextStyle(
              color: ColorQ.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
