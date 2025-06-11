import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/moti_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/models/match_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/widgets/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class EditMatchScreen extends StatefulWidget {
  final MatchModel match;
  final dynamic matchKey;

  const EditMatchScreen(
      {super.key, required this.match, required this.matchKey});

  @override
  State<EditMatchScreen> createState() => _EditMatchScreenState();
}

class _EditMatchScreenState extends State<EditMatchScreen> {
  late DateTime _selectedDate;
  late TextEditingController _gameController;
  late TextEditingController _team1Controller;
  late TextEditingController _team2Controller;
  late TextEditingController _noteController;
  bool _isDraw = false;

  @override
  void initState() {
    super.initState();
    final match = widget.match;

    _selectedDate = match.dateTime;
    _gameController = TextEditingController(text: match.gameName);
    _team1Controller = TextEditingController(text: match.winnerTeam);
    _team2Controller = TextEditingController(text: match.loserTeam);
    _noteController = TextEditingController(text: match.note ?? '');
    _isDraw = match.isDraw;

    _gameController.addListener(_updateFormState);
    _team1Controller.addListener(_updateFormState);
    _team2Controller.addListener(_updateFormState);
    _noteController.addListener(_updateFormState);
  }

  void _updateFormState() => setState(() {});

  @override
  void dispose() {
    _gameController.dispose();
    _team1Controller.dispose();
    _team2Controller.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(43.r)),
        child: Container(
          height: 300.h,
          color: ColorQ.stroke,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child:
                      const Text('Done', style: TextStyle(color: Colors.white)),
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(brightness: Brightness.dark),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    maximumDate: DateTime.now(),
                    initialDateTime: _selectedDate,
                    onDateTimeChanged: (val) =>
                        setState(() => _selectedDate = val),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMatch() async {
    final updatedMatch = MatchModel(
      dateTime: _selectedDate,
      gameName: _gameController.text,
      isDraw: _isDraw,
      winnerTeam: _team1Controller.text,
      loserTeam: _team2Controller.text,
      note: _noteController.text.isNotEmpty ? _noteController.text : null,
    );

    if (_isMatchChanged(updatedMatch)) {
      final box = await Hive.openBox<MatchModel>('matches');
      await box.put(widget.matchKey, updatedMatch);
    }

    Navigator.pop(context);
  }

  bool _isMatchChanged(MatchModel newMatch) {
    final old = widget.match;
    return old.dateTime != newMatch.dateTime ||
        old.gameName != newMatch.gameName ||
        old.isDraw != newMatch.isDraw ||
        old.winnerTeam != newMatch.winnerTeam ||
        old.loserTeam != newMatch.loserTeam ||
        (old.note ?? '') != (newMatch.note ?? '');
  }

  bool get _isFormValid =>
      _gameController.text.trim().isNotEmpty &&
      _team1Controller.text.trim().isNotEmpty &&
      _team2Controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final isChanged = _isMatchChanged(MatchModel(
      dateTime: _selectedDate,
      gameName: _gameController.text,
      isDraw: _isDraw,
      winnerTeam: _team1Controller.text,
      loserTeam: _team2Controller.text,
      note: _noteController.text.isNotEmpty ? _noteController.text : null,
    ));

    final bool canSubmit = _isFormValid && isChanged;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: ColorQ.white),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                title: const Text('Leave the page'),
                content: const Text(
                    'In this case your match changes will not be saved'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Cancel',
                        style: TextStyle(color: ColorQ.blue, fontSize: 17.sp)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: Text('Leave',
                        style: TextStyle(
                            color: ColorQ.blue,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        title: Text('Editing a match',
            style: TextStyle(
                color: ColorQ.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              _buildLabel("Match date and time"),
              _buildInputField(
                readOnly: true,
                controller: TextEditingController(
                    text: DateFormat("dd.MM.yyyy HH:mm").format(_selectedDate)),
                onTap: _selectDate,
                suffix: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: SvgPicture.asset('assets/icons/calendar.svg',
                      fit: BoxFit.contain),
                ),
              ),
              _buildLabel("Game name"),
              _buildInputField(
                  controller: _gameController, hint: "Enter a name"),
              SizedBox(height: 8.h),
              _buildLabel("Match outcome", isBold: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Draw in the game',
                      style: TextStyle(color: ColorQ.grey, fontSize: 15.sp)),
                  CustomSwitch(
                      value: _isDraw,
                      onChanged: (val) => setState(() => _isDraw = val)),
                ],
              ),
              if (_isDraw) ...[
                _buildLabel("Team 1"),
                _buildInputField(
                    controller: _team1Controller, hint: "Enter a team"),
                _buildLabel("Team 2"),
                _buildInputField(
                    controller: _team2Controller, hint: "Enter a team"),
              ] else ...[
                _buildLabel("Winner team"),
                _buildInputField(
                    controller: _team1Controller, hint: "Enter a team"),
                _buildLabel("Loser team"),
                _buildInputField(
                    controller: _team2Controller, hint: "Enter a team"),
              ],
              _buildLabel("Match Notes"),
              _buildInputField(
                  controller: _noteController,
                  hint: "Comment field",
                  maxLines: 4),
              SizedBox(height: 44.h),
              QMotiBut(
                onPressed: canSubmit ? _saveMatch : null,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: canSubmit ? ColorQ.blue : ColorQ.grey,
                    borderRadius: BorderRadius.circular(43.r),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: ColorQ.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          color: isBold ? Colors.white : ColorQ.grey,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          fontSize: isBold ? 18.sp : 14.sp,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? hint,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffix,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      cursorColor: ColorQ.white,
      onTap: onTap,
      maxLines: maxLines,
      style: TextStyle(color: ColorQ.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: ColorQ.grey, fontSize: 14.sp),
        filled: true,
        fillColor: ColorQ.secondary,
        suffix: suffix,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorQ.stroke, width: 1.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorQ.stroke, width: 1.r),
        ),
      ),
    );
  }
}
