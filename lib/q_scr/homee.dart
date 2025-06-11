import 'package:esportsanalytix_probe_oracle_221_t/models/match_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/screens/add_match_screen.dart';
import 'package:esportsanalytix_probe_oracle_221_t/screens/edit_match_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: QMotiBut(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddMatchScreen()),
          ).then((_) => setState(() {}));
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
                'Add a match',
                style: TextStyle(
                  color: ColorQ.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Main',
          style: TextStyle(
            color: ColorQ.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Box<MatchModel>>(
          future: Hive.openBox<MatchModel>('matches'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            final box = snapshot.data!;
            final matches = box.values.toList().reversed.toList();

            if (matches.isEmpty) {
              return Center(
                child: SizedBox(
                  height: 300.h,
                  child: Text(
                    'No data available. Add your first\n     matches to start analyzing',
                    style: TextStyle(
                      color: ColorQ.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(bottom: 140.h),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 120.h, top: 16.h),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return QMotiBut(
                    onPressed: () => _showMatchActions(context, box, match.key),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E2E3E),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match.gameName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorQ.white,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          if (match.isDraw)
                            _buildRow('Match result', 'Draw', isBold: true),
                          _buildRow(
                            match.isDraw ? 'Team 1' : 'Winner team',
                            match.winnerTeam,
                            isBold: true,
                          ),
                          _buildRow(match.isDraw ? 'Team 2' : 'Loser team',
                              match.loserTeam,
                              isBold: true),
                          _buildRow(
                            'Match date and time',
                            DateFormat('dd.MM.yyyy HH:mm')
                                .format(match.dateTime),
                          ),
                          if (match.note != null &&
                              match.note!.trim().isNotEmpty) ...[
                            Padding(
                              padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Notes',
                                      style: TextStyle(
                                        color: ColorQ.grey,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 100.w),
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                      match.note!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: ColorQ.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Container(
        padding: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorQ.stroke,
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(
                  color: ColorQ.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Flexible(
              child: Text(
                value,
                overflow: TextOverflow.visible,
                maxLines: 1,
                style: TextStyle(
                  color: ColorQ.white,
                  fontSize: 14.sp,
                  fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMatchActions(
      BuildContext context, Box<MatchModel> box, dynamic key) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Edit match',
                style: TextStyle(
                  color: ColorQ.blue,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                )),
            onPressed: () {
              Navigator.pop(context);
              final match = box.get(key);
              if (match == null) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditMatchScreen(match: match, matchKey: key),
                ),
              ).then((_) => setState(() {}));
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Delete match',
              style: TextStyle(
                color: Colors.red,
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (ctx) => CupertinoAlertDialog(
                  title: const Text('Leave the page'),
                  content: const Text(
                    'Are you sure you want to exit? Your income changes will not be saved.',
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: ColorQ.blue,
                          fontSize: 17.sp,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: false,
                      onPressed: () {
                        box.delete(key);
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: ColorQ.blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: ColorQ.blue,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
