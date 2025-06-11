import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/qq_tols.dart';

class PiChrtDta {
  const PiChrtDta(this.colr, this.prcnt);

  final Color colr;
  final double prcnt;
}

class PiChrt extends StatelessWidget {
  PiChrt({
    required this.dta,
    required this.rdius,
    this.strkWdth = 8,
    this.chld,
    Key? key,
  })  : assert(dta.fold<double>(0, (sm, dta) => sm + dta.prcnt) <= 100),
        super(key: key);

  final List<PiChrtDta> dta;
  final double rdius;
  final double strkWdth;
  final Widget? chld;

  @override
  Widget build(cntxt) {
    return CustomPaint(
      painter: _Pntr(strkWdth, dta),
      size: Size.square(rdius),
      child: SizedBox.square(
        dimension: rdius * 2,
        child: Center(
          child: chld,
        ),
      ),
    );
  }
}

class _PntrDta {
  const _PntrDta(this.pnt, this.rdns);

  final Paint pnt;
  final double rdns;
}

class _Pntr extends CustomPainter {
  _Pntr(double strkWdth, List<PiChrtDta> dta) {
    dtaLst = dta
        .map((e) => _PntrDta(
              Paint()
                ..color = e.colr
                ..style = PaintingStyle.stroke
                ..strokeWidth = strkWdth
                ..strokeCap = StrokeCap.round,
              (e.prcnt - _pdng) * _prcntInRdns,
            ))
        .toList();
  }

  static const _prcntInRdns = 0.062831853071796;
  static const _pdng = 4;
  static const _pdngInRdns = _prcntInRdns * _pdng;
  static const _strtAngl = -1.570796 + _pdngInRdns / 2;

  late final List<_PntrDta> dtaLst;

  @override
  void paint(Canvas cnvs, Size sz) {
    final rct = Offset.zero & sz;
    double strtAngl = _strtAngl;

    if (dtaLst.length == 1) {
      final dta = dtaLst.first;
      final pth = Path()..addArc(rct, 0, 2 * 3.14159); // Full circle (2π radians)
      cnvs.drawPath(pth, dta.pnt);
    } else {
      for (final dta in dtaLst) {
        final pth = Path()..addArc(rct, strtAngl, dta.rdns);
        strtAngl += dta.rdns + _pdngInRdns;
        cnvs.drawPath(pth, dta.pnt);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDlgt) {
    return oldDlgt != this;
  }
}

class GssStatGrph extends StatelessWidget {
  final List<GuessModl> gssMdls;

  const GssStatGrph({super.key, required this.gssMdls});

  @override
  Widget build(BuildContext cntxt) {
    final hstry =
        gssMdls.where((mdl) => mdl.guessAnswer != null).toList();

    int wrngCnt = 0;
    int rghtCnt = 0;
    int drwCnt = 0;

    for (var gss in hstry) {
      switch (gss.guessAnswer) {
        case GuessAnswer.wrong:
          wrngCnt++;
          break;
        case GuessAnswer.right:
          rghtCnt++;
          break;
        case GuessAnswer.draw:
          drwCnt++;
          break;
        default:
          break;
      }
    }

    final ttl = wrngCnt + rghtCnt + drwCnt;
    if (ttl == 0) return const SizedBox();

    // Calculate percentages for each segment
    final wrngPrcnt = (wrngCnt / ttl) * 100;
    final rghtPrcnt = (rghtCnt / ttl) * 100;
    final drwPrcnt = (drwCnt / ttl) * 100;

    final chrtDta = [
      if (wrngCnt > 0) PiChrtDta(const Color(0xFFFF3B30), wrngPrcnt),
      if (drwCnt > 0) PiChrtDta(const Color(0xFF288BF7), drwPrcnt),
      if (rghtCnt > 0) PiChrtDta(const Color(0xFF34C759), rghtPrcnt),
    ];

    return SizedBox(
      height: 200.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 200.h,
            height: 200.h,
            child: PiChrt(
              dta: chrtDta,
              rdius: 100.r,
              strkWdth: 15.r,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _bldStatRw(
                colr: const Color(0xFFFF3B30),
                lbl: 'Wrong',
                cnt: wrngCnt,
              ),
              SizedBox(height: 4.h),
              _bldStatRw(
                colr: const Color(0xFF34C759),
                lbl: 'Right',
                cnt: rghtCnt,
              ),
              SizedBox(height: 4.h),
              _bldStatRw(
                colr: const Color(0xFF288BF7),
                lbl: '50/50',
                cnt: drwCnt,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bldStatRw({
    required Color colr,
    required String lbl,
    required int cnt,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: colr,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          lbl,
          style: TextStyle(
            color: colr,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          cnt.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
