import 'dart:io';

import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AvatarSelector extends StatelessWidget {
  final String? selectedAvatar;
  final File? customAvatar;
  final ValueChanged<String> onAvatarSelected;
  final ValueChanged<File> onCustomAvatarSelected;

  const AvatarSelector({
    super.key,
    required this.selectedAvatar,
    required this.customAvatar,
    required this.onAvatarSelected,
    required this.onCustomAvatarSelected,
  });

  Future<void> _pickImage(BuildContext context) async {
    final status = await Permission.photos.status;

    if (status.isGranted) {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) onCustomAvatarSelected(File(picked.path));
    } else if (status.isDenied) {
      final result = await Permission.photos.request();
      if (result.isGranted) {
        final picked =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (picked != null) onCustomAvatarSelected(File(picked.path));
      } else {
        await showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Access Denied'),
            content: const Text('You need to allow access to select a photo.'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      await showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Access Needed'),
          content: const Text('Please enable photo access in Settings.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                openAppSettings();
                Navigator.pop(ctx);
              },
              child: const Text('Open Settings'),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
              isDestructiveAction: true,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildAvatarTile({
    required Widget avatarWidget,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: ColorQ.darkGrey,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80.r,
              height: 80.r,
              child: ClipOval(child: avatarWidget),
            ),
            SizedBox(height: 16.h),
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? ColorQ.blue : ColorQ.grey,
                  width: 2.r,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorQ.blue,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarImage(String path) {
    if (path.startsWith('/')) {
      return Image.file(File(path), fit: BoxFit.cover);
    } else {
      return Image.asset(path, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select an avatar',
            style: TextStyle(
              color: ColorQ.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                final hasAvatar = customAvatar != null;

                return GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: ColorQ.darkGrey,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: hasAvatar
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 80.r,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorQ.blue, width: 2),
                                    borderRadius: BorderRadius.circular(12.r),
                                    image: DecorationImage(
                                      image: FileImage(customAvatar!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80.r,
                                  decoration: BoxDecoration(
                                    color: ColorQ.blue.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/edit.svg',
                                  width: 24.r,
                                  height: 24.r,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : Container(
                              width: 80.r,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.6),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(Icons.add,
                                    color: Colors.white, size: 24.r),
                              ),
                            ),
                    ),
                  ),
                );
              } else {
                final path = 'assets/images/avatar$index.png';
                final isSelected = selectedAvatar == path;

                return _buildAvatarTile(
                  avatarWidget: _buildAvatarImage(path),
                  isSelected: isSelected,
                  onTap: () => onAvatarSelected(path),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
