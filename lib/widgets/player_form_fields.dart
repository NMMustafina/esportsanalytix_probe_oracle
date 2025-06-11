import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerFormFields extends StatelessWidget {
  final TextEditingController nicknameController;
  final TextEditingController gameController;
  final TextEditingController roleController;
  final TextEditingController ratingController;
  final TextEditingController favoritesController;
  final TextEditingController matchesController;
  final TextEditingController winRateController;
  final TextEditingController kdaController;

  const PlayerFormFields({
    super.key,
    required this.nicknameController,
    required this.gameController,
    required this.roleController,
    required this.ratingController,
    required this.favoritesController,
    required this.matchesController,
    required this.winRateController,
    required this.kdaController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(nicknameController, 'Nickname*', 'Enter a nickname'),
        _buildTextField(gameController, 'Game*', 'Enter the game name'),
        _buildTextField(
            roleController, 'Main role', 'Specify your main role in the game'),
        _buildTextField(
          ratingController,
          'Current rating',
          'Enter details',
          isNumber: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        _buildTextField(
            favoritesController, 'Favorite heroes/weapons', 'Enter details'),
        _buildTextField(
          matchesController,
          'Number of matches*',
          'Enter details',
          isNumber: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        _buildTextField(
          winRateController,
          'Win percentage*',
          'Enter details',
          isNumber: true,
          suffixText: '%',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d{0,2})?$')),
            TextInputFormatter.withFunction((oldValue, newValue) {
              try {
                final double value = double.parse(newValue.text);
                if (value > 100) return oldValue;
                return newValue;
              } catch (_) {
                return newValue;
              }
            }),
          ],
        ),
        _buildTextField(kdaController, 'Average KDA*', 'Enter details',
            isNumber: true),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    bool isNumber = false,
    String? suffixText,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: ColorQ.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: controller,
            keyboardType: isNumber
                ? const TextInputType.numberWithOptions(decimal: true)
                : null,
            inputFormatters: inputFormatters,
            style: TextStyle(color: ColorQ.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: ColorQ.grey),
              filled: true,
              fillColor: ColorQ.secondary,
              suffixText: suffixText,
              suffixStyle: TextStyle(color: ColorQ.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: ColorQ.stroke, width: 1.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: ColorQ.stroke, width: 1.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
