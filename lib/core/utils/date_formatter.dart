import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _standardDate = DateFormat('dd MMM yyyy');
  static final DateFormat _shortDate = DateFormat('dd MMM');
  static final DateFormat _monthYear = DateFormat('MMMM yyyy');
  static final DateFormat _timeOnly = DateFormat('hh:mm a');

  static String formatDate(DateTime date) {
    return _standardDate.format(date);
  }

  static String formatShortDate(DateTime date) {
    return _shortDate.format(date);
  }

  static String formatMonthYear(DateTime date) {
    return _monthYear.format(date);
  }

  static String formatTime(DateTime date) {
    return _timeOnly.format(date);
  }

  /// Relative human date (e.g. "Today", "Tomorrow", "Yesterday", "In 3 days", "3 days ago")
  static String formatRelative(DateTime targetDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final difference = target.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';

    if (difference > 1 && difference <= 7) {
      return 'In $difference days';
    } else if (difference < -1 && difference >= -7) {
      return '${-difference} days ago';
    }

    return _standardDate.format(targetDate);
  }

  /// Calculates remaining warranty duration text (e.g. "2 yrs 4 mos left" or "Expired")
  static String formatRemainingWarranty(DateTime expiryDate) {
    final now = DateTime.now();
    if (expiryDate.isBefore(now)) {
      return 'Warranty Expired';
    }

    final diffDays = expiryDate.difference(now).inDays;
    final years = diffDays ~/ 365;
    final remainingDays = diffDays % 365;
    final months = remainingDays ~/ 30;

    if (years > 0 && months > 0) {
      return '$years yr${years > 1 ? 's' : ''} $months mo${months > 1 ? 's' : ''} left';
    } else if (years > 0) {
      return '$years year${years > 1 ? 's' : ''} left';
    } else if (months > 0) {
      return '$months month${months > 1 ? 's' : ''} left';
    } else {
      return '$diffDays day${diffDays > 1 ? 's' : ''} left';
    }
  }
}
