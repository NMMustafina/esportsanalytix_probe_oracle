import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52.w,
        height: 24.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorQ.stroke,
          ),
          color: value ? ColorQ.white : ColorQ.secondary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          children: [
            Align(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: value ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
