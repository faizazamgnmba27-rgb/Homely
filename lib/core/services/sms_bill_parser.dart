import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ParsedSmsBill {
  final String name;
  final String provider;
  final String category;
  final int amountPaise;
  final DateTime dueDate;
  final String rawBody;
  final DateTime smsDate;

  ParsedSmsBill({
    required this.name,
    required this.provider,
    required this.category,
    required this.amountPaise,
    required this.dueDate,
    required this.rawBody,
    required this.smsDate,
  });
}

class SmsBillParser {
  static const _channel = MethodChannel('com.homely.app/sms');

  static final _billKeywords = RegExp(
    r'(credit\s*card|card\s*ending|statement|total\s*(?:amount\s*)?due|min(?:imum)?\s*(?:amount\s*)?due|bill\s*(?:is\s*)?(?:generated|due|amount)|due\s*(?:on|by|date)|electricity\s*bill|broadband|postpaid|gas\s*bill|water\s*bill|emi\s*due)',
    caseSensitive: false,
  );

  static final _ignoreKeywords = RegExp(
    r'(otp|one\s*time\s*password|verification\s*code|credited\s*to|debited\s*from|spent\s*on\s*card|payment\s*(?:of|for).*?(?:received|successful|credited))',
    caseSensitive: false,
  );

  static final _amountRegex = RegExp(
    r'(?:Rs\.?|INR|₹)\s*([\d,]+(?:\.\d{1,2})?)',
    caseSensitive: false,
  );

  static final _dueDateRegex = RegExp(
    r'(?:due\s*(?:on|by|date)?[:\s-]*)(\d{1,2}[-/\s](?:\d{1,2}|[A-Za-z]{3})[-/\s]\d{2,4})',
    caseSensitive: false,
  );

  static Future<List<ParsedSmsBill>> fetchAndParseBills() async {
    final List<dynamic> rawMessages = await _channel.invokeMethod('getInboxSms');
    final List<ParsedSmsBill> results = [];
    final Set<String> seenKeys = {};

    for (final item in rawMessages) {
      final map = Map<String, dynamic>.from(item as Map);
      final address = (map['address'] as String? ?? '').trim();
      final body = (map['body'] as String? ?? '').trim();
      final dateMs = (map['date'] as num?)?.toInt() ?? 0;
      final smsDate = DateTime.fromMillisecondsSinceEpoch(dateMs);

      if (body.isEmpty) continue;
      if (!_billKeywords.hasMatch(body)) continue;
      if (_ignoreKeywords.hasMatch(body)) continue;

      final amountMatch = _amountRegex.firstMatch(body);
      if (amountMatch == null) continue;

      final amountStr = amountMatch.group(1)!.replaceAll(',', '');
      final amountDouble = double.tryParse(amountStr);
      if (amountDouble == null || amountDouble <= 0) continue;

      final amountPaise = (amountDouble * 100).round();
      final dueDate = _extractDueDate(body, smsDate);
      final provider = _extractProvider(address, body);
      final isCreditCard = RegExp(r'credit\s*card|card\s*ending|statement|total\s*(?:amount\s*)?due|min(?:imum)?\s*due', caseSensitive: false).hasMatch(body);
      final category = isCreditCard ? 'Credit Card' : _extractCategory(body);
      final name = isCreditCard ? '$provider Credit Card' : '$provider $category';

      final dedupKey = '${name}_${amountPaise}_${dueDate.year}-${dueDate.month}-${dueDate.day}';
      if (seenKeys.contains(dedupKey)) continue;
      seenKeys.add(dedupKey);

      results.add(
        ParsedSmsBill(
          name: name,
          provider: provider,
          category: category,
          amountPaise: amountPaise,
          dueDate: dueDate,
          rawBody: body,
          smsDate: smsDate,
        ),
      );
    }

    return results;
  }

  static DateTime _extractDueDate(String body, DateTime smsDate) {
    final match = _dueDateRegex.firstMatch(body);
    if (match != null) {
      final rawDate = match.group(1)!.trim().replaceAll(RegExp(r'\s+'), '-').replaceAll('/', '-');
      final formats = [
        DateFormat('dd-MM-yyyy'),
        DateFormat('dd-MM-yy'),
        DateFormat('dd-MMM-yyyy'),
        DateFormat('dd-MMM-yy'),
        DateFormat('d-MMM-yyyy'),
        DateFormat('d-MMM-yy'),
      ];
      for (final fmt in formats) {
        try {
          return fmt.parseStrict(rawDate);
        } catch (_) {}
      }
    }
    return smsDate.add(const Duration(days: 7));
  }

  static String _extractProvider(String address, String body) {
    final knownProviders = [
      'HDFC',
      'ICICI',
      'SBI',
      'AXIS',
      'KOTAK',
      'AMEX',
      'CITI',
      'INDUSIND',
      'RBL',
      'YES BANK',
      'IDFC',
      'AIRTEL',
      'JIO',
      'BESCOM',
      'TATA',
      'ADANI',
      'BSES',
      'MSEDCL',
      'ACT',
    ];
    final combined = '${address.toUpperCase()} ${body.toUpperCase()}';
    for (final p in knownProviders) {
      if (combined.contains(p)) {
        return p;
      }
    }
    final cleaned = address.replaceAll(RegExp(r'^[A-Z]{2}-'), '').trim();
    return cleaned.isNotEmpty ? cleaned : 'Bank/Utility';
  }

  static String _extractCategory(String body) {
    final lower = body.toLowerCase();
    if (lower.contains('electricity') || lower.contains('bescom') || lower.contains('bses') || lower.contains('msedcl')) {
      return 'Electricity';
    }
    if (lower.contains('broadband') || lower.contains('wifi') || lower.contains('internet')) {
      return 'Internet';
    }
    if (lower.contains('postpaid') || lower.contains('mobile')) {
      return 'Mobile';
    }
    if (lower.contains('gas')) return 'Gas';
    if (lower.contains('water')) return 'Water';
    if (lower.contains('emi') || lower.contains('loan')) return 'EMI / Loan';
    return 'Utility';
  }
}
