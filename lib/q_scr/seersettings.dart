import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/dok_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/pro_q.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Seersettings extends StatelessWidget {
  const Seersettings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: ColorQ.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QMotiBut(
                  onPressed: () {
                    lauchUrl(context, DokQ.priPoli);
                  },
                  child: Image.asset(
                    'assets/icons/s1.png',
                    width: 168.w,
                  ),
                ),
                QMotiBut(
                  onPressed: () {
                    lauchUrl(context, DokQ.terOfUse);
                  },
                  child: Image.asset(
                    'assets/icons/s2.png',
                    width: 168.w,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                QMotiBut(
                  onPressed: () {
                    lauchUrl(context, DokQ.suprF);
                  },
                  child: Image.asset(
                    'assets/icons/s3.png',
                    width: 168.w,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
