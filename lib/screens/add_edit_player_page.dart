import 'dart:io';

import 'package:esportsanalytix_probe_oracle_221_t/models/player_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/widgets/avatar_selector.dart';
import 'package:esportsanalytix_probe_oracle_221_t/widgets/player_form_fields.dart';
import 'package:esportsanalytix_probe_oracle_221_t/widgets/save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class AddEditPlayerPage extends StatefulWidget {
  final PlayerModel? player;

  const AddEditPlayerPage({super.key, this.player});

  @override
  State<AddEditPlayerPage> createState() => _AddEditPlayerPageState();
}

class _AddEditPlayerPageState extends State<AddEditPlayerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _gameController = TextEditingController();
  final _roleController = TextEditingController();
  final _ratingController = TextEditingController();
  final _favoritesController = TextEditingController();
  final _matchesController = TextEditingController();
  final _winRateController = TextEditingController();
  final _kdaController = TextEditingController();
  late final String _initialNickname;
  late final String _initialGame;
  late final String _initialRole;
  late final String _initialRating;
  late final String _initialFavorites;
  late final String _initialMatches;
  late final String _initialWinRate;
  late final String _initialKDA;
  late final String _initialAvatarPath;

  String? _selectedAvatar;
  File? _customAvatar;

  bool _isChanged = false;

  bool get _isFormValid {
    final hasAvatar = _customAvatar != null || _selectedAvatar != null;
    return hasAvatar &&
        _nicknameController.text.trim().isNotEmpty &&
        _matchesController.text.trim().isNotEmpty &&
        _winRateController.text.trim().isNotEmpty &&
        _kdaController.text.trim().isNotEmpty;
  }

  void _updateState() => setState(() => _isChanged = true);

  Future<bool> _onWillPop() async {
    if (!_isChanged) return true;

    return await showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text('Leave the page'),
            content: const Text('This player changes will not be saved'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              CupertinoDialogAction(
                child: const Text('Leave'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _checkForChanges() {
    final avatarChanged =
        (_customAvatar?.path ?? _selectedAvatar ?? '') != _initialAvatarPath;

    final changed = _nicknameController.text != _initialNickname ||
        _gameController.text != _initialGame ||
        _roleController.text != _initialRole ||
        _ratingController.text != _initialRating ||
        _favoritesController.text != _initialFavorites ||
        _matchesController.text != _initialMatches ||
        _winRateController.text != _initialWinRate ||
        _kdaController.text != _initialKDA ||
        avatarChanged;

    if (_isChanged != changed) {
      setState(() => _isChanged = changed);
    }
  }

  @override
  void initState() {
    super.initState();
    final p = widget.player;

    if (p != null) {
      _nicknameController.text = p.nickname;
      _gameController.text = p.game;
      _roleController.text = p.mainRole;
      _ratingController.text = p.rating != 0 ? p.rating.toString() : '';
      _favoritesController.text = p.favoriteItems;
      _matchesController.text = p.matchCount.toString();
      _winRateController.text = p.winRate.toString();
      _kdaController.text = p.avgKDA.toString();
      _initialAvatarPath = p.avatarPath;

      if (p.avatarPath.startsWith("/")) {
        _customAvatar = File(p.avatarPath);
      } else {
        _selectedAvatar = p.avatarPath;
      }
    } else {
      _initialAvatarPath = '';
    }

    _initialNickname = _nicknameController.text;
    _initialGame = _gameController.text;
    _initialRole = _roleController.text;
    _initialRating = _ratingController.text;
    _initialFavorites = _favoritesController.text;
    _initialMatches = _matchesController.text;
    _initialWinRate = _winRateController.text;
    _initialKDA = _kdaController.text;

    _nicknameController.addListener(_checkForChanges);
    _gameController.addListener(_checkForChanges);
    _roleController.addListener(_checkForChanges);
    _ratingController.addListener(_checkForChanges);
    _favoritesController.addListener(_checkForChanges);
    _matchesController.addListener(_checkForChanges);
    _winRateController.addListener(_checkForChanges);
    _kdaController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _gameController.dispose();
    _roleController.dispose();
    _ratingController.dispose();
    _favoritesController.dispose();
    _matchesController.dispose();
    _winRateController.dispose();
    _kdaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.player != null;
    final bool canSubmit = _isFormValid && (_isChanged || !isEditing);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: ColorQ.white),
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop) Navigator.pop(context);
            },
          ),
          title: Text(
            isEditing ? 'Edit Player' : 'Player adding',
            style: TextStyle(
              color: ColorQ.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarSelector(
                      selectedAvatar: _selectedAvatar,
                      customAvatar: _customAvatar,
                      onAvatarSelected: (path) {
                        setState(() {
                          _selectedAvatar = path;
                          _customAvatar = null;
                          _checkForChanges();
                        });
                      },
                      onCustomAvatarSelected: (file) {
                        setState(() {
                          _customAvatar = file;
                          _selectedAvatar = null;
                          _checkForChanges();
                        });
                      },
                    ),
                    SizedBox(height: 24.h),
                    PlayerFormFields(
                      nicknameController: _nicknameController,
                      gameController: _gameController,
                      roleController: _roleController,
                      ratingController: _ratingController,
                      favoritesController: _favoritesController,
                      matchesController: _matchesController,
                      winRateController: _winRateController,
                      kdaController: _kdaController,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: SaveButton(
                isEnabled: canSubmit,
                isEditing: isEditing,
                onPressed: () async {
                  final box = await Hive.openBox<PlayerModel>('players');
                  final player = PlayerModel(
                    avatarPath: _customAvatar?.path ?? _selectedAvatar ?? '',
                    nickname: _nicknameController.text.trim(),
                    game: _gameController.text.trim(),
                    mainRole: _roleController.text.trim(),
                    rating: int.tryParse(_ratingController.text) ?? 0,
                    favoriteItems: _favoritesController.text.trim(),
                    matchCount: int.tryParse(_matchesController.text) ?? 0,
                    winRate: double.tryParse(_winRateController.text) ?? 0.0,
                    avgKDA: double.tryParse(_kdaController.text) ?? 0.0,
                  );

                  if (isEditing && widget.player != null) {
                    final existing = widget.player!;
                    existing
                      ..avatarPath =
                          _customAvatar?.path ?? _selectedAvatar ?? ''
                      ..nickname = _nicknameController.text.trim()
                      ..game = _gameController.text.trim()
                      ..mainRole = _roleController.text.trim()
                      ..rating = int.tryParse(_ratingController.text) ?? 0
                      ..favoriteItems = _favoritesController.text.trim()
                      ..matchCount = int.tryParse(_matchesController.text) ?? 0
                      ..winRate =
                          double.tryParse(_winRateController.text) ?? 0.0
                      ..avgKDA = double.tryParse(_kdaController.text) ?? 0.0;

                    await existing.save();
                  } else {
                    final player = PlayerModel(
                      avatarPath: _customAvatar?.path ?? _selectedAvatar ?? '',
                      nickname: _nicknameController.text.trim(),
                      game: _gameController.text.trim(),
                      mainRole: _roleController.text.trim(),
                      rating: int.tryParse(_ratingController.text) ?? 0,
                      favoriteItems: _favoritesController.text.trim(),
                      matchCount: int.tryParse(_matchesController.text) ?? 0,
                      winRate: double.tryParse(_winRateController.text) ?? 0.0,
                      avgKDA: double.tryParse(_kdaController.text) ?? 0.0,
                    );
                    await box.add(player);
                  }

                  if (context.mounted) Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
