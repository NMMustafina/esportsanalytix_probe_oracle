import 'dart:io';

import 'package:esportsanalytix_probe_oracle_221_t/models/player_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/screens/add_edit_player_page.dart';
import 'package:esportsanalytix_probe_oracle_221_t/widgets/player_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel player;

  const PlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => PlayerDetailsDialog(
            player: player,
            onEdit: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditPlayerPage(player: player),
                ),
              );
            },
            onDelete: () {
              player.delete();
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2E2E3E),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    player.nickname,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorQ.white,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.white,
                  backgroundImage: player.avatarPath.startsWith('/')
                      ? FileImage(File(player.avatarPath))
                      : AssetImage(player.avatarPath) as ImageProvider,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _infoRow('Game', player.game),
            if (player.mainRole.trim().isNotEmpty) ...[
              _divider(),
              _infoRow('Main role', player.mainRole),
            ],
            _divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Brief Stats (Win \nPercentage, KDA)',
                    style: TextStyle(
                      color: ColorQ.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Text(
                  '${player.winRate.toInt()}',
                  style: TextStyle(
                    color: ColorQ.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorQ.grey,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: ColorQ.white,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(
        color: ColorQ.grey.withOpacity(0.3),
        thickness: 1,
        height: 1,
      ),
    );
  }
}
