import 'package:esportsanalytix_probe_oracle_221_t/models/player_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/screens/add_edit_player_page.dart';
import 'package:esportsanalytix_probe_oracle_221_t/widgets/player_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: QMotiBut(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditPlayerPage(),
            ),
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
                'Add a player',
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
          'Player Profiles',
          style: TextStyle(
            color: ColorQ.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder<Box<PlayerModel>>(
          valueListenable: Hive.box<PlayerModel>('players').listenable(),
          builder: (context, box, _) {
            final players = box.values.toList();

            if (players.isEmpty) {
              return Center(
                child: SizedBox(
                  height: 300.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      "You haven't added any players yet. Start adding everyone one by one.",
                      style: TextStyle(
                        color: ColorQ.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 120.h, top: 16.h),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return PlayerCard(player: player);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
