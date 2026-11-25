import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/widgets/homely_card.dart';

class CookieTimerScreen extends ConsumerStatefulWidget {
  const CookieTimerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CookieTimerScreen> createState() => _CookieTimerScreenState();
}

class _CookieTimerScreenState extends ConsumerState<CookieTimerScreen> {
  Timer? _timer;
  int _totalSeconds = 12 * 60; // 12 minutes default for classic cookies
  int _remainingSeconds = 12 * 60;
  bool _isRunning = false;
  String _selectedPreset = 'Chewy Chocolate Chip (12m)';

  final Map<String, int> _presets = {
    'Chewy Chocolate Chip (12m)': 12 * 60,
    'Crispy Butter Cookies (15m)': 15 * 60,
    'Soft Oatmeal Raisin (10m)': 10 * 60,
    'Shortbread / Biscuits (18m)': 18 * 60,
    'Quick Brownie Bites (8m)': 8 * 60,
    'Quick Test (15s)': 15,
  };

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_remainingSeconds <= 0) {
      _remainingSeconds = _totalSeconds;
    }
    _timer?.cancel();
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 1) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() {
          _remainingSeconds = 0;
          _isRunning = false;
        });
        _onBakeComplete();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _remainingSeconds = _totalSeconds;
    });
  }

  Future<void> _onBakeComplete() async {
    // Send immediate alarm notification
    final notif = ref.read(notificationServiceProvider);
    await notif.showImmediateNotification(
      id: 888888,
      title: '🍪 Cookies Are Ready!',
      body: 'Ding! Your $_selectedPreset baking timer has finished. Remove them from oven to cool!',
      channelId: NotificationService.channelIdReminders,
      channelName: NotificationService.channelNameReminders,
    );

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Row(
            children: [
              Text('🍪 ', style: TextStyle(fontSize: 26)),
              Text('Cookies Ready!', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
            ],
          ),
          content: Text('Your "$_selectedPreset" baking timer has reached 0:00! Check the oven now.'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Awesome!'),
            ),
          ],
        ),
      );
    }
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final progress = _totalSeconds > 0 ? (_remainingSeconds / _totalSeconds) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cookie Baking Timer 🍪',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w700, color: primary),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(HomelySpacing.screenPadding),
        children: [
          // Circular Timer Display
          Center(
            child: SizedBox(
              width: 240,
              height: 240,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 10,
                      backgroundColor: isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg,
                      color: _remainingSeconds <= 30 && _isRunning ? HomelyColors.danger : accent,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🍪', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                          color: primary,
                        ),
                      ),
                      Text(
                        _isRunning ? 'Baking in progress...' : (_remainingSeconds == 0 ? 'Baking finished!' : 'Ready to bake'),
                        style: TextStyle(fontSize: 12, color: secondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: HomelySpacing.xl),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: _resetTimer,
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(width: HomelySpacing.md),
              FilledButton.icon(
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                icon: Icon(_isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 22),
                label: Text(_isRunning ? 'Pause' : 'Start Timer'),
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: isDark ? const Color(0xFF151714) : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: HomelySpacing.xl),

          // Cookie Presets
          Text(
            'Cookie & Bakery Presets',
            style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w700, color: primary),
          ),
          const SizedBox(height: 8),
          ..._presets.entries.map((entry) {
            final isSelected = _selectedPreset == entry.key;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: HomelyCard(
                onTap: () {
                  _timer?.cancel();
                  setState(() {
                    _selectedPreset = entry.key;
                    _totalSeconds = entry.value;
                    _remainingSeconds = entry.value;
                    _isRunning = false;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isSelected ? accent.withOpacity(0.18) : (isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.cookie_outlined,
                            size: 20,
                            color: isSelected ? accent : secondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? accent : primary,
                          ),
                        ),
                      ],
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle_rounded, color: accent, size: 20)
                    else
                      Text(
                        _formatTime(entry.value),
                        style: TextStyle(fontSize: 12, color: secondary),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
