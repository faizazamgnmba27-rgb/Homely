import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/homely_colors.dart';
import '../../../app/theme/homely_theme_provider.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/models/app_currency.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/providers/currency_provider.dart';
import '../../../core/storage/backup_restore_service.dart';
import '../../../core/widgets/homely_card.dart';
import '../../../core/widgets/homely_confirm_dialog.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isBackingUp = false;
  bool _isRestoring = false;

  Future<void> _handleTestNotification() async {
    final notifService = ref.read(notificationServiceProvider);
    await notifService.requestPermissions();
    await notifService.showImmediateNotification(
      title: 'Homely Alert Test 🔔',
      body: 'Notifications and alert channels are configured and working properly on your phone!',
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Test notification sent! Check your notification bar.'),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handleRequestPermissions() async {
    final notifService = ref.read(notificationServiceProvider);
    final granted = await notifService.requestPermissions();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(granted
              ? 'Notification permission granted!'
              : 'Permission requested. If not shown, please enable in Phone App Settings.'),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handleBackup() async {
    setState(() => _isBackingUp = true);
    final service = ref.read(backupRestoreServiceProvider);
    final result = await service.createBackup();
    setState(() => _isBackingUp = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message + (result.backupFilePath != null ? '\nSaved to: ${result.backupFilePath}' : '')),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handleRestore() async {
    final confirmed = await HomelyConfirmDialog.show(
      context,
      title: 'Restore Database Backup',
      message: 'Restoring a backup will replace your current local database with the backup data. Do you wish to continue?',
      confirmLabel: 'Choose Backup File',
      isDestructive: true,
    );
    if (confirmed != true) return;

    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (pickerResult == null || pickerResult.files.isEmpty) return;

    final filePath = pickerResult.files.first.path;
    if (filePath == null) return;

    setState(() => _isRestoring = true);
    final file = File(filePath);
    final content = await file.readAsString();
    final service = ref.read(backupRestoreServiceProvider);
    final result = await service.restoreFromBackup(content);
    setState(() => _isRestoring = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    final themeMode = ref.watch(themeModeProvider);
    final selectedCurrency = ref.watch(currencyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings & Privacy',
          style: TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w700, color: primary),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          HomelySpacing.screenPadding,
          HomelySpacing.xs,
          HomelySpacing.screenPadding,
          80,
        ),
        children: [
          // 1. Appearance / Theme Card
          Text('Appearance', style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.w700, color: secondary)),
          const SizedBox(height: 8),
          HomelyCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildRadioTile(
                  title: 'Light Theme',
                  subtitle: 'Warm oatmeal plaster (#F7F7F2)',
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (val) => ref.read(themeModeProvider.notifier).setTheme(val!),
                  primary: primary,
                  secondary: secondary,
                  accent: accent,
                ),
                const Divider(),
                _buildRadioTile(
                  title: 'Dark Theme',
                  subtitle: 'Deep obsidian slate (#151714)',
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (val) => ref.read(themeModeProvider.notifier).setTheme(val!),
                  primary: primary,
                  secondary: secondary,
                  accent: accent,
                ),
                const Divider(),
                _buildRadioTile(
                  title: 'System Default',
                  subtitle: 'Matches your Android system setting',
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  onChanged: (val) => ref.read(themeModeProvider.notifier).setTheme(val!),
                  primary: primary,
                  secondary: secondary,
                  accent: accent,
                ),
              ],
            ),
          ),

          const SizedBox(height: HomelySpacing.lg),

          // 2. Preferences & Formatting
          Text('Preferences & Formatting', style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.w700, color: secondary)),
          const SizedBox(height: 8),
          HomelyCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      selectedCurrency.symbol,
                      style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w700, color: accent),
                    ),
                  ),
                  title: Text('Currency', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                  subtitle: Text('${selectedCurrency.name} (${selectedCurrency.symbol} ${selectedCurrency.code})', style: TextStyle(fontSize: 11, color: secondary)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedCurrency.code,
                          style: TextStyle(fontFamily: 'Manrope', fontSize: 11, fontWeight: FontWeight.w700, color: accent),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 20, color: secondary),
                    ],
                  ),
                  onTap: () => _showCurrencyPicker(context, ref, selectedCurrency),
                ),
              ],
            ),
          ),

          const SizedBox(height: HomelySpacing.lg),

          // Notifications & Device Alerts
          Text('Notifications & Device Alerts', style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.w700, color: secondary)),
          const SizedBox(height: 8),
          HomelyCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.notifications_active_outlined, color: accent, size: 20),
                  ),
                  title: Text('Send Test Notification', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                  subtitle: Text('Immediately trigger a test alert on this phone', style: TextStyle(fontSize: 11, color: secondary)),
                  trailing: Icon(Icons.send_rounded, size: 20, color: accent),
                  onTap: _handleTestNotification,
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: HomelyColors.catUtilities.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.security_update_good_outlined, color: HomelyColors.catUtilities, size: 20),
                  ),
                  title: Text('Check & Grant Permission', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                  subtitle: Text('Prompt Android notification & exact alarm access', style: TextStyle(fontSize: 11, color: secondary)),
                  trailing: Icon(Icons.chevron_right, size: 20, color: secondary),
                  onTap: _handleRequestPermissions,
                ),
              ],
            ),
          ),

          const SizedBox(height: HomelySpacing.lg),

          // 3. Data & Offline Storage
          Text('Data & Offline Storage', style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.w700, color: secondary)),
          const SizedBox(height: 8),
          HomelyCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.download_rounded, color: accent, size: 20),
                  ),
                  title: Text('Export Local Backup', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                  subtitle: Text('Export SQLite database & metadata to JSON', style: TextStyle(fontSize: 11, color: secondary)),
                  trailing: _isBackingUp
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : Icon(Icons.chevron_right, size: 20, color: secondary),
                  onTap: _isBackingUp ? null : _handleBackup,
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: HomelyColors.warning.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.upload_rounded, color: HomelyColors.warning, size: 20),
                  ),
                  title: Text('Restore from Backup', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
                  subtitle: Text('Import and validate previously saved backup', style: TextStyle(fontSize: 11, color: secondary)),
                  trailing: _isRestoring
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : Icon(Icons.chevron_right, size: 20, color: secondary),
                  onTap: _isRestoring ? null : _handleRestore,
                ),
              ],
            ),
          ),

          const SizedBox(height: HomelySpacing.lg),

          // 3. Privacy & Zero-Cloud Guarantee
          Text('Privacy Architecture', style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.w700, color: secondary)),
          const SizedBox(height: 8),
          HomelyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: HomelyColors.success.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.shield_outlined, color: HomelyColors.success, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('100% Offline-First', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w700, color: primary)),
                          Text('No cloud accounts, trackers, or telemetry', style: TextStyle(fontSize: 11, color: secondary)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'HOMELY stores all your household data, invoices, warranties, and vehicle records locally on your device in an encrypted SQLite database. Your home data never leaves your hands.',
                  style: TextStyle(fontSize: 12, color: secondary, height: 1.45),
                ),
              ],
            ),
          ),

          const SizedBox(height: HomelySpacing.lg),

          // 4. About HOMELY
          Text('About', style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.w700, color: secondary)),
          const SizedBox(height: 8),
          HomelyCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('HOMELY for Android', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w700, color: primary)),
                    Text('Version 1.0.0 (Build 1)', style: TextStyle(fontSize: 11, color: secondary)),
                  ],
                ),
                Text('Material 3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioTile({
    required String title,
    required String subtitle,
    required ThemeMode value,
    required ThemeMode groupValue,
    required Function(ThemeMode?) onChanged,
    required Color primary,
    required Color secondary,
    required Color accent,
  }) {
    return RadioListTile<ThemeMode>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: accent,
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600, color: primary)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 11, color: secondary)),
    );
  }

  void _showCurrencyPicker(BuildContext context, WidgetRef ref, AppCurrency currentCurrency) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? HomelyColors.darkTextPrimary : HomelyColors.lightTextPrimary;
    final secondary = isDark ? HomelyColors.darkTextSecondary : HomelyColors.lightTextSecondary;
    final accent = isDark ? HomelyColors.darkAccent : HomelyColors.lightAccent;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? HomelyColors.darkCard : HomelyColors.lightCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Currency',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: AppCurrency.supportedCurrencies.length,
                    separatorBuilder: (_, __) => const Divider(height: 1, indent: 64),
                    itemBuilder: (context, index) {
                      final curr = AppCurrency.supportedCurrencies[index];
                      final isSelected = curr.code == currentCurrency.code;
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? accent.withOpacity(0.15) : (isDark ? HomelyColors.darkSecondaryBg : HomelyColors.lightSecondaryBg),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            curr.symbol,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? accent : primary,
                            ),
                          ),
                        ),
                        title: Text(
                          curr.name,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                            color: primary,
                          ),
                        ),
                        subtitle: Text(
                          '${curr.code} • ${curr.flagEmoji} • ${curr.minorUnitName}',
                          style: TextStyle(fontSize: 12, color: secondary),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle_rounded, color: accent, size: 22)
                            : null,
                        onTap: () {
                          ref.read(currencyProvider.notifier).setCurrency(curr);
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Currency updated to ${curr.name} (${curr.symbol} ${curr.code})'),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
