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
  int _totalSeconds = 5 * 60; // 5 minutes default
  int _remainingSeconds = 5 * 60;
  bool _isRunning = false;
  String _selectedPreset = '5 Minutes';

  final Map<String, int> _presets = {
    '1 Minute': 60,
    '3 Minutes': 3 * 60,
    '5 Minutes': 5 * 60,
    '10 Minutes': 10 * 60,
    '15 Minutes': 15 * 60,
    '30 Minutes': 30 * 60,
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
      title: '⏱️ Timer Finished!',
      body: 'Your $_selectedPreset timer has finished.',
      channelId: NotificationService.channelIdReminders,
      channelName: NotificationService.channelNameReminders,
    );

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.timer_outlined, size: 26),
              SizedBox(width: 8),
              Text('Timer Finished!', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
            ],
          ),
          content: Text('Your "$_selectedPreset" timer has reached 0:00!'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _showCustomTimerDialog() async {
    final minController = TextEditingController(text: '${_totalSeconds ~/ 60}');
    final secController = TextEditingController(text: '${_totalSeconds % 60}');
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Custom Timer', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
        content: Row(
          children: [
            Expanded(
              child: TextField(
                controller: minController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Minutes'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: secController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Seconds'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final mins = int.tryParse(minController.text) ?? 0;
              final secs = int.tryParse(secController.text) ?? 0;
              final total = (mins * 60 + secs).clamp(1, 24 * 3600);
              Navigator.pop(ctx, total);
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
    if (result != null && mounted) {
      _timer?.cancel();
      setState(() {
        _selectedPreset = 'Custom (${_formatTime(result)})';
        _totalSeconds = result;
        _remainingSeconds = result;
        _isRunning = false;
      });
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
          'Timer',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w700, color: primary),
        ),
        actions: [
          TextButton.icon(
            onPressed: _showCustomTimerDialog,
            icon: Icon(Icons.tune_rounded, size: 18, color: accent),
            label: Text('Custom', style: TextStyle(color: accent, fontWeight: FontWeight.w600)),
          ),
        ],
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
                      Icon(Icons.timer_outlined, size: 36, color: accent),
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
                        _isRunning ? 'Timer running...' : (_remainingSeconds == 0 ? 'Time is up!' : 'Ready'),
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

          // Quick Presets
          Text(
            'Quick Presets',
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
                            Icons.timer_outlined,
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
