import 'dart:io';

import 'package:esportsanalytix_probe_oracle_221_t/models/player_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerDetailsDialog extends StatelessWidget {
  final PlayerModel player;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PlayerDetailsDialog({
    super.key,
    required this.player,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF2E2E3E),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 100.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      player.nickname,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: ColorQ.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: player.avatarPath.startsWith('/')
                        ? FileImage(File(player.avatarPath))
                        : AssetImage(player.avatarPath) as ImageProvider,
                    radius: 22.r,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              if (player.game.isNotEmpty) ...[
                _buildRow("Game", player.game),
                _divider(),
              ],
              if (player.mainRole.isNotEmpty) ...[
                _buildRow("Main role", player.mainRole),
                _divider(),
              ],
              if (player.rating != 0) ...[
                _buildRow("Current rating", player.rating.toStringAsFixed(0)),
                _divider(),
              ],
              if (player.favoriteItems.isNotEmpty)
                _buildRow("Favorite heroes/weapons", player.favoriteItems),
              if (player.matchCount > 0 ||
                  player.winRate > 0 ||
                  player.avgKDA > 0) ...[
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Statistics",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: ColorQ.white,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    if (player.matchCount > 0)
                      _buildStatBox("${player.matchCount}", "Matches"),
                    if (player.winRate > 0)
                      _buildStatBox(
                          "${player.winRate.toInt()}%", "Win percentage"),
                    if (player.avgKDA > 0)
                      _buildStatBox("${player.avgKDA.toInt()}", "KDA"),
                  ],
                ),
              ],
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: ColorQ.blue,
                  borderRadius: BorderRadius.circular(32.r),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  onPressed: onEdit,
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      color: ColorQ.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text('Delete player'),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              onDelete();
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            isDestructiveAction: true,
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(color: ColorQ.grey, fontSize: 12.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(color: ColorQ.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(
        color: ColorQ.grey.withOpacity(0.3),
        thickness: 1,
        height: 1,
      ),
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: 90.h),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 6.w),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          border: Border.all(color: ColorQ.grey.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontSize: 22.sp,
                  color: ColorQ.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: ColorQ.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
