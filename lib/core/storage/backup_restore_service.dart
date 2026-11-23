import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../database/app_database.dart';
import '../database/database_provider.dart';

final backupRestoreServiceProvider = Provider<BackupRestoreService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BackupRestoreService(db);
});

class BackupRestoreResult {
  final bool success;
  final String message;
  final String? backupFilePath;
  final int? recordsRestored;

  BackupRestoreResult({
    required this.success,
    required this.message,
    this.backupFilePath,
    this.recordsRestored,
  });
}

class BackupRestoreService {
  final AppDatabase _db;

  BackupRestoreService(this._db);

  static const String currentAppVersion = '1.0.0';
  static const int currentBackupFormatVersion = 1;

  /// Creates a complete offline backup payload
  Future<BackupRestoreResult> createBackup() async {
    try {
      final inventoryItems = await _db.select(_db.inventoryItems).get();
      final inventoryCategories = await _db.select(_db.inventoryCategories).get();
      final shoppingItems = await _db.select(_db.shoppingItems).get();
      final bills = await _db.select(_db.bills).get();
      final billPayments = await _db.select(_db.billPayments).get();
      final assets = await _db.select(_db.assets).get();
      final assetServices = await _db.select(_db.assetServices).get();
      final vehicles = await _db.select(_db.vehicles).get();
      final vehicleLogs = await _db.select(_db.vehicleLogs).get();
      final reminders = await _db.select(_db.reminders).get();
      final expenses = await _db.select(_db.expenses).get();
      final budgets = await _db.select(_db.budgets).get();
      final documents = await _db.select(_db.documents).get();

      final backupData = {
        'appName': 'HOMELY',
        'appVersion': currentAppVersion,
        'backupVersion': currentBackupFormatVersion,
        'createdAt': DateTime.now().toIso8601String(),
        'data': {
          'inventoryCategories': inventoryCategories.map((c) => {
            'id': c.id,
            'name': c.name,
            'iconName': c.iconName,
            'sortOrder': c.sortOrder,
          }).toList(),
          'inventoryItems': inventoryItems.map((i) => {
            'id': i.id,
            'name': i.name,
            'categoryId': i.categoryId,
            'brand': i.brand,
            'quantity': i.quantity,
            'unit': i.unit,
            'purchaseDate': i.purchaseDate?.toIso8601String(),
            'expiryDate': i.expiryDate?.toIso8601String(),
            'minStockThreshold': i.minStockThreshold,
            'approximatePricePaise': i.approximatePricePaise,
            'storageLocation': i.storageLocation,
            'notes': i.notes,
            'imagePath': i.imagePath,
            'isConsumed': i.isConsumed,
            'createdAt': i.createdAt.toIso8601String(),
            'updatedAt': i.updatedAt.toIso8601String(),
          }).toList(),
          'shoppingItems': shoppingItems.map((s) => {
            'id': s.id,
            'name': s.name,
            'category': s.category,
            'quantity': s.quantity,
            'unit': s.unit,
            'expectedPricePaise': s.expectedPricePaise,
            'priority': s.priority,
            'plannedPurchaseDate': s.plannedPurchaseDate.toIso8601String(),
            'reminderDateTime': s.reminderDateTime?.toIso8601String(),
            'notes': s.notes,
            'status': s.status,
            'isConvertedToInventory': s.isConvertedToInventory,
            'convertedInventoryItemId': s.convertedInventoryItemId,
            'purchasedDate': s.purchasedDate?.toIso8601String(),
            'createdAt': s.createdAt.toIso8601String(),
            'updatedAt': s.updatedAt.toIso8601String(),
          }).toList(),
          'bills': bills.map((b) => {
            'id': b.id,
            'name': b.name,
            'category': b.category,
            'provider': b.provider,
            'expectedAmountPaise': b.expectedAmountPaise,
            'dueDate': b.dueDate.toIso8601String(),
            'recurrence': b.recurrence,
            'reminderDaysBefore': b.reminderDaysBefore,
            'status': b.status,
            'notes': b.notes,
            'attachmentPath': b.attachmentPath,
            'isArchived': b.isArchived,
            'createdAt': b.createdAt.toIso8601String(),
            'updatedAt': b.updatedAt.toIso8601String(),
          }).toList(),
          'billPayments': billPayments.map((p) => {
            'id': p.id,
            'billId': p.billId,
            'paidAmountPaise': p.paidAmountPaise,
            'paymentDate': p.paymentDate.toIso8601String(),
            'paymentMethod': p.paymentMethod,
            'receiptAttachmentPath': p.receiptAttachmentPath,
            'notes': p.notes,
            'createdAt': p.createdAt.toIso8601String(),
          }).toList(),
          'assets': assets.map((a) => {
            'id': a.id,
            'name': a.name,
            'category': a.category,
            'brand': a.brand,
            'model': a.model,
            'serialNumber': a.serialNumber,
            'purchaseDate': a.purchaseDate.toIso8601String(),
            'purchasePricePaise': a.purchasePricePaise,
            'warrantyStartDate': a.warrantyStartDate?.toIso8601String(),
            'warrantyExpiryDate': a.warrantyExpiryDate.toIso8601String(),
            'seller': a.seller,
            'invoiceAttachmentPath': a.invoiceAttachmentPath,
            'warrantyDocPath': a.warrantyDocPath,
            'imagePath': a.imagePath,
            'serviceIntervalMonths': a.serviceIntervalMonths,
            'lastServiceDate': a.lastServiceDate?.toIso8601String(),
            'nextServiceDate': a.nextServiceDate?.toIso8601String(),
            'notes': a.notes,
            'createdAt': a.createdAt.toIso8601String(),
            'updatedAt': a.updatedAt.toIso8601String(),
          }).toList(),
          'assetServices': assetServices.map((as) => {
            'id': as.id,
            'assetId': as.assetId,
            'serviceDate': as.serviceDate.toIso8601String(),
            'serviceType': as.serviceType,
            'technicianName': as.technicianName,
            'technicianContact': as.technicianContact,
            'costPaise': as.costPaise,
            'notes': as.notes,
            'receiptAttachmentPath': as.receiptAttachmentPath,
            'createdAt': as.createdAt.toIso8601String(),
          }).toList(),
          'vehicles': vehicles.map((v) => {
            'id': v.id,
            'name': v.name,
            'registrationNumber': v.registrationNumber,
            'vehicleType': v.vehicleType,
            'brand': v.brand,
            'model': v.model,
            'purchaseDate': v.purchaseDate?.toIso8601String(),
            'currentOdometerKm': v.currentOdometerKm,
            'insuranceExpiry': v.insuranceExpiry.toIso8601String(),
            'pucExpiry': v.pucExpiry.toIso8601String(),
            'registrationExpiry': v.registrationExpiry?.toIso8601String(),
            'lastServiceDate': v.lastServiceDate?.toIso8601String(),
            'nextServiceDate': v.nextServiceDate?.toIso8601String(),
            'nextServiceOdometerKm': v.nextServiceOdometerKm,
            'imagePath': v.imagePath,
            'notes': v.notes,
            'createdAt': v.createdAt.toIso8601String(),
            'updatedAt': v.updatedAt.toIso8601String(),
          }).toList(),
          'vehicleLogs': vehicleLogs.map((vl) => {
            'id': vl.id,
            'vehicleId': vl.vehicleId,
            'logType': vl.logType,
            'date': vl.date.toIso8601String(),
            'odometerKm': vl.odometerKm,
            'costPaise': vl.costPaise,
            'fuelLitres': vl.fuelLitres,
            'serviceCentre': vl.serviceCentre,
            'notes': vl.notes,
            'receiptAttachmentPath': vl.receiptAttachmentPath,
            'createdAt': vl.createdAt.toIso8601String(),
          }).toList(),
          'reminders': reminders.map((r) => {
            'id': r.id,
            'title': r.title,
            'eventType': r.eventType,
            'dueDate': r.dueDate.toIso8601String(),
            'priority': r.priority,
            'isCompleted': r.isCompleted,
            'completedAt': r.completedAt?.toIso8601String(),
            'snoozedUntil': r.snoozedUntil?.toIso8601String(),
            'relatedEntityId': r.relatedEntityId,
            'relatedEntityType': r.relatedEntityType,
            'notes': r.notes,
            'notificationId': r.notificationId,
            'createdAt': r.createdAt.toIso8601String(),
            'updatedAt': r.updatedAt.toIso8601String(),
          }).toList(),
          'expenses': expenses.map((e) => {
            'id': e.id,
            'title': e.title,
            'category': e.category,
            'amountPaise': e.amountPaise,
            'date': e.date.toIso8601String(),
            'paymentMethod': e.paymentMethod,
            'notes': e.notes,
            'linkedEntityId': e.linkedEntityId,
            'linkedEntityType': e.linkedEntityType,
            'createdAt': e.createdAt.toIso8601String(),
          }).toList(),
          'documents': documents.map((d) => {
            'id': d.id,
            'title': d.title,
            'category': d.category,
            'localFilePath': d.localFilePath,
            'fileSizeBytes': d.fileSizeBytes,
            'mimeType': d.mimeType,
            'linkedEntityType': d.linkedEntityType,
            'linkedEntityId': d.linkedEntityId,
            'notes': d.notes,
            'createdAt': d.createdAt.toIso8601String(),
            'updatedAt': d.updatedAt.toIso8601String(),
          }).toList(),
        }
      };

      final jsonString = jsonEncode(backupData);
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-');
      final file = File('${directory.path}/homely_backup_$timestamp.json');
      await file.writeAsString(jsonString);

      return BackupRestoreResult(
        success: true,
        message: 'Backup created successfully',
        backupFilePath: file.path,
      );
    } catch (e) {
      return BackupRestoreResult(
        success: false,
        message: 'Backup failed: $e',
      );
    }
  }

  /// Validates and restores data from a JSON backup file
  Future<BackupRestoreResult> restoreFromBackup(String jsonContent) async {
    try {
      final decoded = jsonDecode(jsonContent) as Map<String, dynamic>;

      if (decoded['appName'] != 'HOMELY') {
        return BackupRestoreResult(
          success: false,
          message: 'Invalid backup file: Not a HOMELY database backup.',
        );
      }

      final backupVersion = decoded['backupVersion'] as int?;
      if (backupVersion == null || backupVersion > currentBackupFormatVersion) {
        return BackupRestoreResult(
          success: false,
          message: 'Incompatible backup format version ($backupVersion).',
        );
      }

      final data = decoded['data'] as Map<String, dynamic>?;
      if (data == null) {
        return BackupRestoreResult(
          success: false,
          message: 'Malformed backup data structure.',
        );
      }

      int totalRestored = 0;

      await _db.transaction(() async {
        // Clear existing records before restore
        await _db.delete(_db.inventoryItems).go();
        await _db.delete(_db.shoppingItems).go();
        await _db.delete(_db.billPayments).go();
        await _db.delete(_db.bills).go();
        await _db.delete(_db.assetServices).go();
        await _db.delete(_db.assets).go();
        await _db.delete(_db.vehicleLogs).go();
        await _db.delete(_db.vehicles).go();
        await _db.delete(_db.reminders).go();
        await _db.delete(_db.expenses).go();
        await _db.delete(_db.documents).go();

        // Restore Inventory Items
        if (data['inventoryItems'] is List) {
          for (final item in data['inventoryItems']) {
            await _db.into(_db.inventoryItems).insert(
              InventoryItemsCompanion.insert(
                id: item['id'],
                name: item['name'],
                categoryId: item['categoryId'] ?? 'cat_1',
                brand: Value(item['brand']),
                quantity: Value((item['quantity'] as num?)?.toDouble() ?? 1.0),
                unit: Value(item['unit'] ?? 'pcs'),
                purchaseDate: Value(item['purchaseDate'] != null ? DateTime.parse(item['purchaseDate']) : null),
                expiryDate: Value(item['expiryDate'] != null ? DateTime.parse(item['expiryDate']) : null),
                minStockThreshold: Value((item['minStockThreshold'] as num?)?.toDouble() ?? 1.0),
                approximatePricePaise: Value(item['approximatePricePaise']),
                storageLocation: Value(item['storageLocation']),
                notes: Value(item['notes']),
                imagePath: Value(item['imagePath']),
                isConsumed: Value(item['isConsumed'] ?? false),
                createdAt: DateTime.parse(item['createdAt']),
                updatedAt: DateTime.parse(item['updatedAt']),
              ),
            );
            totalRestored++;
          }
        }

        // Restore Bills
        if (data['bills'] is List) {
          for (final b in data['bills']) {
            await _db.into(_db.bills).insert(
              BillsCompanion.insert(
                id: b['id'],
                name: b['name'],
                category: b['category'],
                provider: b['provider'],
                expectedAmountPaise: b['expectedAmountPaise'],
                dueDate: DateTime.parse(b['dueDate']),
                recurrence: Value(b['recurrence'] ?? 'monthly'),
                reminderDaysBefore: Value(b['reminderDaysBefore'] ?? 3),
                status: Value(b['status'] ?? 'upcoming'),
                notes: Value(b['notes']),
                attachmentPath: Value(b['attachmentPath']),
                isArchived: Value(b['isArchived'] ?? false),
                createdAt: DateTime.parse(b['createdAt']),
                updatedAt: DateTime.parse(b['updatedAt']),
              ),
            );
            totalRestored++;
          }
        }

        // Restore Assets
        if (data['assets'] is List) {
          for (final a in data['assets']) {
            await _db.into(_db.assets).insert(
              AssetsCompanion.insert(
                id: a['id'],
                name: a['name'],
                category: a['category'],
                brand: Value(a['brand']),
                model: Value(a['model']),
                serialNumber: Value(a['serialNumber']),
                purchaseDate: DateTime.parse(a['purchaseDate']),
                purchasePricePaise: Value(a['purchasePricePaise']),
                warrantyStartDate: Value(a['warrantyStartDate'] != null ? DateTime.parse(a['warrantyStartDate']) : null),
                warrantyExpiryDate: DateTime.parse(a['warrantyExpiryDate']),
                seller: Value(a['seller']),
                invoiceAttachmentPath: Value(a['invoiceAttachmentPath']),
                warrantyDocPath: Value(a['warrantyDocPath']),
                imagePath: Value(a['imagePath']),
                serviceIntervalMonths: Value(a['serviceIntervalMonths']),
                lastServiceDate: Value(a['lastServiceDate'] != null ? DateTime.parse(a['lastServiceDate']) : null),
                nextServiceDate: Value(a['nextServiceDate'] != null ? DateTime.parse(a['nextServiceDate']) : null),
                notes: Value(a['notes']),
                createdAt: DateTime.parse(a['createdAt']),
                updatedAt: DateTime.parse(a['updatedAt']),
              ),
            );
            totalRestored++;
          }
        }

        // Restore Vehicles
        if (data['vehicles'] is List) {
          for (final v in data['vehicles']) {
            await _db.into(_db.vehicles).insert(
              VehiclesCompanion.insert(
                id: v['id'],
                name: v['name'],
                registrationNumber: v['registrationNumber'],
                vehicleType: v['vehicleType'],
                brand: v['brand'],
                model: v['model'],
                purchaseDate: Value(v['purchaseDate'] != null ? DateTime.parse(v['purchaseDate']) : null),
                currentOdometerKm: Value(v['currentOdometerKm'] ?? 0),
                insuranceExpiry: DateTime.parse(v['insuranceExpiry']),
                pucExpiry: DateTime.parse(v['pucExpiry']),
                registrationExpiry: Value(v['registrationExpiry'] != null ? DateTime.parse(v['registrationExpiry']) : null),
                lastServiceDate: Value(v['lastServiceDate'] != null ? DateTime.parse(v['lastServiceDate']) : null),
                nextServiceDate: Value(v['nextServiceDate'] != null ? DateTime.parse(v['nextServiceDate']) : null),
                nextServiceOdometerKm: Value(v['nextServiceOdometerKm']),
                imagePath: Value(v['imagePath']),
                notes: Value(v['notes']),
                createdAt: DateTime.parse(v['createdAt']),
                updatedAt: DateTime.parse(v['updatedAt']),
              ),
            );
            totalRestored++;
          }
        }

        // Restore Reminders
        if (data['reminders'] is List) {
          for (final r in data['reminders']) {
            await _db.into(_db.reminders).insert(
              RemindersCompanion.insert(
                id: r['id'],
                title: r['title'],
                eventType: Value(r['eventType'] ?? 'custom'),
                dueDate: DateTime.parse(r['dueDate']),
                priority: Value(r['priority'] ?? 'medium'),
                isCompleted: Value(r['isCompleted'] ?? false),
                completedAt: Value(r['completedAt'] != null ? DateTime.parse(r['completedAt']) : null),
                snoozedUntil: Value(r['snoozedUntil'] != null ? DateTime.parse(r['snoozedUntil']) : null),
                relatedEntityId: Value(r['relatedEntityId']),
                relatedEntityType: Value(r['relatedEntityType']),
                notes: Value(r['notes']),
                notificationId: Value(r['notificationId']),
                createdAt: DateTime.parse(r['createdAt']),
                updatedAt: DateTime.parse(r['updatedAt']),
              ),
            );
            totalRestored++;
          }
        }
      });

      return BackupRestoreResult(
        success: true,
        message: 'Database restored successfully ($totalRestored records).',
        recordsRestored: totalRestored,
      );
    } catch (e) {
      return BackupRestoreResult(
        success: false,
        message: 'Restore failed: $e',
      );
    }
  }
}
