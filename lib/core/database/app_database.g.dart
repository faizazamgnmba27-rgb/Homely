// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $InventoryCategoriesTable extends InventoryCategories
    with TableInfo<$InventoryCategoriesTable, InventoryCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, name, iconName, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_categories';
  @override
  VerificationContext validateIntegrity(Insertable<InventoryCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $InventoryCategoriesTable createAlias(String alias) {
    return $InventoryCategoriesTable(attachedDatabase, alias);
  }
}

class InventoryCategory extends DataClass
    implements Insertable<InventoryCategory> {
  final String id;
  final String name;
  final String? iconName;
  final int sortOrder;
  const InventoryCategory(
      {required this.id,
      required this.name,
      this.iconName,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  InventoryCategoriesCompanion toCompanion(bool nullToAbsent) {
    return InventoryCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      sortOrder: Value(sortOrder),
    );
  }

  factory InventoryCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryCategory(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String?>(iconName),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  InventoryCategory copyWith(
          {String? id,
          String? name,
          Value<String?> iconName = const Value.absent(),
          int? sortOrder}) =>
      InventoryCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        iconName: iconName.present ? iconName.value : this.iconName,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  InventoryCategory copyWithCompanion(InventoryCategoriesCompanion data) {
    return InventoryCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconName, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.sortOrder == this.sortOrder);
}

class InventoryCategoriesCompanion extends UpdateCompanion<InventoryCategory> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> iconName;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const InventoryCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryCategoriesCompanion.insert({
    required String id,
    required String name,
    this.iconName = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<InventoryCategory> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? iconName,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryCategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? iconName,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return InventoryCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES inventory_categories (id)'));
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pcs'));
  static const VerificationMeta _purchaseDateMeta =
      const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
      'purchase_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _expiryDateMeta =
      const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
      'expiry_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _minStockThresholdMeta =
      const VerificationMeta('minStockThreshold');
  @override
  late final GeneratedColumn<double> minStockThreshold =
      GeneratedColumn<double>('min_stock_threshold', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(1.0));
  static const VerificationMeta _approximatePricePaiseMeta =
      const VerificationMeta('approximatePricePaise');
  @override
  late final GeneratedColumn<int> approximatePricePaise = GeneratedColumn<int>(
      'approximate_price_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _storageLocationMeta =
      const VerificationMeta('storageLocation');
  @override
  late final GeneratedColumn<String> storageLocation = GeneratedColumn<String>(
      'storage_location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isConsumedMeta =
      const VerificationMeta('isConsumed');
  @override
  late final GeneratedColumn<bool> isConsumed = GeneratedColumn<bool>(
      'is_consumed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_consumed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        categoryId,
        brand,
        quantity,
        unit,
        purchaseDate,
        expiryDate,
        minStockThreshold,
        approximatePricePaise,
        storageLocation,
        notes,
        imagePath,
        isConsumed,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(Insertable<InventoryItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
          _purchaseDateMeta,
          purchaseDate.isAcceptableOrUnknown(
              data['purchase_date']!, _purchaseDateMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
          _expiryDateMeta,
          expiryDate.isAcceptableOrUnknown(
              data['expiry_date']!, _expiryDateMeta));
    }
    if (data.containsKey('min_stock_threshold')) {
      context.handle(
          _minStockThresholdMeta,
          minStockThreshold.isAcceptableOrUnknown(
              data['min_stock_threshold']!, _minStockThresholdMeta));
    }
    if (data.containsKey('approximate_price_paise')) {
      context.handle(
          _approximatePricePaiseMeta,
          approximatePricePaise.isAcceptableOrUnknown(
              data['approximate_price_paise']!, _approximatePricePaiseMeta));
    }
    if (data.containsKey('storage_location')) {
      context.handle(
          _storageLocationMeta,
          storageLocation.isAcceptableOrUnknown(
              data['storage_location']!, _storageLocationMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('is_consumed')) {
      context.handle(
          _isConsumedMeta,
          isConsumed.isAcceptableOrUnknown(
              data['is_consumed']!, _isConsumedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      purchaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}purchase_date']),
      expiryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expiry_date']),
      minStockThreshold: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}min_stock_threshold'])!,
      approximatePricePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}approximate_price_paise']),
      storageLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}storage_location']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      isConsumed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_consumed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String id;
  final String name;
  final String categoryId;
  final String? brand;
  final double quantity;
  final String unit;
  final DateTime? purchaseDate;
  final DateTime? expiryDate;
  final double minStockThreshold;
  final int? approximatePricePaise;
  final String? storageLocation;
  final String? notes;
  final String? imagePath;
  final bool isConsumed;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InventoryItem(
      {required this.id,
      required this.name,
      required this.categoryId,
      this.brand,
      required this.quantity,
      required this.unit,
      this.purchaseDate,
      this.expiryDate,
      required this.minStockThreshold,
      this.approximatePricePaise,
      this.storageLocation,
      this.notes,
      this.imagePath,
      required this.isConsumed,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    map['min_stock_threshold'] = Variable<double>(minStockThreshold);
    if (!nullToAbsent || approximatePricePaise != null) {
      map['approximate_price_paise'] = Variable<int>(approximatePricePaise);
    }
    if (!nullToAbsent || storageLocation != null) {
      map['storage_location'] = Variable<String>(storageLocation);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['is_consumed'] = Variable<bool>(isConsumed);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: Value(categoryId),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      quantity: Value(quantity),
      unit: Value(unit),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      minStockThreshold: Value(minStockThreshold),
      approximatePricePaise: approximatePricePaise == null && nullToAbsent
          ? const Value.absent()
          : Value(approximatePricePaise),
      storageLocation: storageLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(storageLocation),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      isConsumed: Value(isConsumed),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      brand: serializer.fromJson<String?>(json['brand']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      minStockThreshold: serializer.fromJson<double>(json['minStockThreshold']),
      approximatePricePaise:
          serializer.fromJson<int?>(json['approximatePricePaise']),
      storageLocation: serializer.fromJson<String?>(json['storageLocation']),
      notes: serializer.fromJson<String?>(json['notes']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      isConsumed: serializer.fromJson<bool>(json['isConsumed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<String>(categoryId),
      'brand': serializer.toJson<String?>(brand),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'minStockThreshold': serializer.toJson<double>(minStockThreshold),
      'approximatePricePaise': serializer.toJson<int?>(approximatePricePaise),
      'storageLocation': serializer.toJson<String?>(storageLocation),
      'notes': serializer.toJson<String?>(notes),
      'imagePath': serializer.toJson<String?>(imagePath),
      'isConsumed': serializer.toJson<bool>(isConsumed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InventoryItem copyWith(
          {String? id,
          String? name,
          String? categoryId,
          Value<String?> brand = const Value.absent(),
          double? quantity,
          String? unit,
          Value<DateTime?> purchaseDate = const Value.absent(),
          Value<DateTime?> expiryDate = const Value.absent(),
          double? minStockThreshold,
          Value<int?> approximatePricePaise = const Value.absent(),
          Value<String?> storageLocation = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          bool? isConsumed,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      InventoryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        brand: brand.present ? brand.value : this.brand,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        purchaseDate:
            purchaseDate.present ? purchaseDate.value : this.purchaseDate,
        expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
        minStockThreshold: minStockThreshold ?? this.minStockThreshold,
        approximatePricePaise: approximatePricePaise.present
            ? approximatePricePaise.value
            : this.approximatePricePaise,
        storageLocation: storageLocation.present
            ? storageLocation.value
            : this.storageLocation,
        notes: notes.present ? notes.value : this.notes,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        isConsumed: isConsumed ?? this.isConsumed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      brand: data.brand.present ? data.brand.value : this.brand,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      expiryDate:
          data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
      minStockThreshold: data.minStockThreshold.present
          ? data.minStockThreshold.value
          : this.minStockThreshold,
      approximatePricePaise: data.approximatePricePaise.present
          ? data.approximatePricePaise.value
          : this.approximatePricePaise,
      storageLocation: data.storageLocation.present
          ? data.storageLocation.value
          : this.storageLocation,
      notes: data.notes.present ? data.notes.value : this.notes,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isConsumed:
          data.isConsumed.present ? data.isConsumed.value : this.isConsumed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('brand: $brand, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('minStockThreshold: $minStockThreshold, ')
          ..write('approximatePricePaise: $approximatePricePaise, ')
          ..write('storageLocation: $storageLocation, ')
          ..write('notes: $notes, ')
          ..write('imagePath: $imagePath, ')
          ..write('isConsumed: $isConsumed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      categoryId,
      brand,
      quantity,
      unit,
      purchaseDate,
      expiryDate,
      minStockThreshold,
      approximatePricePaise,
      storageLocation,
      notes,
      imagePath,
      isConsumed,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.brand == this.brand &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.purchaseDate == this.purchaseDate &&
          other.expiryDate == this.expiryDate &&
          other.minStockThreshold == this.minStockThreshold &&
          other.approximatePricePaise == this.approximatePricePaise &&
          other.storageLocation == this.storageLocation &&
          other.notes == this.notes &&
          other.imagePath == this.imagePath &&
          other.isConsumed == this.isConsumed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> categoryId;
  final Value<String?> brand;
  final Value<double> quantity;
  final Value<String> unit;
  final Value<DateTime?> purchaseDate;
  final Value<DateTime?> expiryDate;
  final Value<double> minStockThreshold;
  final Value<int?> approximatePricePaise;
  final Value<String?> storageLocation;
  final Value<String?> notes;
  final Value<String?> imagePath;
  final Value<bool> isConsumed;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.brand = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.minStockThreshold = const Value.absent(),
    this.approximatePricePaise = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.notes = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isConsumed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    required String id,
    required String name,
    required String categoryId,
    this.brand = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.minStockThreshold = const Value.absent(),
    this.approximatePricePaise = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.notes = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isConsumed = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        categoryId = Value(categoryId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<InventoryItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? categoryId,
    Expression<String>? brand,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<DateTime>? purchaseDate,
    Expression<DateTime>? expiryDate,
    Expression<double>? minStockThreshold,
    Expression<int>? approximatePricePaise,
    Expression<String>? storageLocation,
    Expression<String>? notes,
    Expression<String>? imagePath,
    Expression<bool>? isConsumed,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (brand != null) 'brand': brand,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (minStockThreshold != null) 'min_stock_threshold': minStockThreshold,
      if (approximatePricePaise != null)
        'approximate_price_paise': approximatePricePaise,
      if (storageLocation != null) 'storage_location': storageLocation,
      if (notes != null) 'notes': notes,
      if (imagePath != null) 'image_path': imagePath,
      if (isConsumed != null) 'is_consumed': isConsumed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? categoryId,
      Value<String?>? brand,
      Value<double>? quantity,
      Value<String>? unit,
      Value<DateTime?>? purchaseDate,
      Value<DateTime?>? expiryDate,
      Value<double>? minStockThreshold,
      Value<int?>? approximatePricePaise,
      Value<String?>? storageLocation,
      Value<String?>? notes,
      Value<String?>? imagePath,
      Value<bool>? isConsumed,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      minStockThreshold: minStockThreshold ?? this.minStockThreshold,
      approximatePricePaise:
          approximatePricePaise ?? this.approximatePricePaise,
      storageLocation: storageLocation ?? this.storageLocation,
      notes: notes ?? this.notes,
      imagePath: imagePath ?? this.imagePath,
      isConsumed: isConsumed ?? this.isConsumed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (minStockThreshold.present) {
      map['min_stock_threshold'] = Variable<double>(minStockThreshold.value);
    }
    if (approximatePricePaise.present) {
      map['approximate_price_paise'] =
          Variable<int>(approximatePricePaise.value);
    }
    if (storageLocation.present) {
      map['storage_location'] = Variable<String>(storageLocation.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isConsumed.present) {
      map['is_consumed'] = Variable<bool>(isConsumed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('brand: $brand, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('minStockThreshold: $minStockThreshold, ')
          ..write('approximatePricePaise: $approximatePricePaise, ')
          ..write('storageLocation: $storageLocation, ')
          ..write('notes: $notes, ')
          ..write('imagePath: $imagePath, ')
          ..write('isConsumed: $isConsumed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShoppingItemsTable extends ShoppingItems
    with TableInfo<$ShoppingItemsTable, ShoppingItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pcs'));
  static const VerificationMeta _expectedPricePaiseMeta =
      const VerificationMeta('expectedPricePaise');
  @override
  late final GeneratedColumn<int> expectedPricePaise = GeneratedColumn<int>(
      'expected_price_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _plannedPurchaseDateMeta =
      const VerificationMeta('plannedPurchaseDate');
  @override
  late final GeneratedColumn<DateTime> plannedPurchaseDate =
      GeneratedColumn<DateTime>('planned_purchase_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _reminderDateTimeMeta =
      const VerificationMeta('reminderDateTime');
  @override
  late final GeneratedColumn<DateTime> reminderDateTime =
      GeneratedColumn<DateTime>('reminder_date_time', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('planned'));
  static const VerificationMeta _isConvertedToInventoryMeta =
      const VerificationMeta('isConvertedToInventory');
  @override
  late final GeneratedColumn<bool> isConvertedToInventory =
      GeneratedColumn<bool>('is_converted_to_inventory', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("is_converted_to_inventory" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _convertedInventoryItemIdMeta =
      const VerificationMeta('convertedInventoryItemId');
  @override
  late final GeneratedColumn<String> convertedInventoryItemId =
      GeneratedColumn<String>('converted_inventory_item_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _purchasedDateMeta =
      const VerificationMeta('purchasedDate');
  @override
  late final GeneratedColumn<DateTime> purchasedDate =
      GeneratedColumn<DateTime>('purchased_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        quantity,
        unit,
        expectedPricePaise,
        priority,
        plannedPurchaseDate,
        reminderDateTime,
        notes,
        status,
        isConvertedToInventory,
        convertedInventoryItemId,
        purchasedDate,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_items';
  @override
  VerificationContext validateIntegrity(Insertable<ShoppingItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('expected_price_paise')) {
      context.handle(
          _expectedPricePaiseMeta,
          expectedPricePaise.isAcceptableOrUnknown(
              data['expected_price_paise']!, _expectedPricePaiseMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('planned_purchase_date')) {
      context.handle(
          _plannedPurchaseDateMeta,
          plannedPurchaseDate.isAcceptableOrUnknown(
              data['planned_purchase_date']!, _plannedPurchaseDateMeta));
    } else if (isInserting) {
      context.missing(_plannedPurchaseDateMeta);
    }
    if (data.containsKey('reminder_date_time')) {
      context.handle(
          _reminderDateTimeMeta,
          reminderDateTime.isAcceptableOrUnknown(
              data['reminder_date_time']!, _reminderDateTimeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('is_converted_to_inventory')) {
      context.handle(
          _isConvertedToInventoryMeta,
          isConvertedToInventory.isAcceptableOrUnknown(
              data['is_converted_to_inventory']!, _isConvertedToInventoryMeta));
    }
    if (data.containsKey('converted_inventory_item_id')) {
      context.handle(
          _convertedInventoryItemIdMeta,
          convertedInventoryItemId.isAcceptableOrUnknown(
              data['converted_inventory_item_id']!,
              _convertedInventoryItemIdMeta));
    }
    if (data.containsKey('purchased_date')) {
      context.handle(
          _purchasedDateMeta,
          purchasedDate.isAcceptableOrUnknown(
              data['purchased_date']!, _purchasedDateMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      expectedPricePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}expected_price_paise']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      plannedPurchaseDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}planned_purchase_date'])!,
      reminderDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}reminder_date_time']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      isConvertedToInventory: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}is_converted_to_inventory'])!,
      convertedInventoryItemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}converted_inventory_item_id']),
      purchasedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}purchased_date']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ShoppingItemsTable createAlias(String alias) {
    return $ShoppingItemsTable(attachedDatabase, alias);
  }
}

class ShoppingItem extends DataClass implements Insertable<ShoppingItem> {
  final String id;
  final String name;
  final String category;
  final double quantity;
  final String unit;
  final int? expectedPricePaise;
  final String priority;
  final DateTime plannedPurchaseDate;
  final DateTime? reminderDateTime;
  final String? notes;
  final String status;
  final bool isConvertedToInventory;
  final String? convertedInventoryItemId;
  final DateTime? purchasedDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ShoppingItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.quantity,
      required this.unit,
      this.expectedPricePaise,
      required this.priority,
      required this.plannedPurchaseDate,
      this.reminderDateTime,
      this.notes,
      required this.status,
      required this.isConvertedToInventory,
      this.convertedInventoryItemId,
      this.purchasedDate,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || expectedPricePaise != null) {
      map['expected_price_paise'] = Variable<int>(expectedPricePaise);
    }
    map['priority'] = Variable<String>(priority);
    map['planned_purchase_date'] = Variable<DateTime>(plannedPurchaseDate);
    if (!nullToAbsent || reminderDateTime != null) {
      map['reminder_date_time'] = Variable<DateTime>(reminderDateTime);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['is_converted_to_inventory'] = Variable<bool>(isConvertedToInventory);
    if (!nullToAbsent || convertedInventoryItemId != null) {
      map['converted_inventory_item_id'] =
          Variable<String>(convertedInventoryItemId);
    }
    if (!nullToAbsent || purchasedDate != null) {
      map['purchased_date'] = Variable<DateTime>(purchasedDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShoppingItemsCompanion toCompanion(bool nullToAbsent) {
    return ShoppingItemsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      quantity: Value(quantity),
      unit: Value(unit),
      expectedPricePaise: expectedPricePaise == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedPricePaise),
      priority: Value(priority),
      plannedPurchaseDate: Value(plannedPurchaseDate),
      reminderDateTime: reminderDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDateTime),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      isConvertedToInventory: Value(isConvertedToInventory),
      convertedInventoryItemId: convertedInventoryItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(convertedInventoryItemId),
      purchasedDate: purchasedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasedDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
      expectedPricePaise: serializer.fromJson<int?>(json['expectedPricePaise']),
      priority: serializer.fromJson<String>(json['priority']),
      plannedPurchaseDate:
          serializer.fromJson<DateTime>(json['plannedPurchaseDate']),
      reminderDateTime:
          serializer.fromJson<DateTime?>(json['reminderDateTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      isConvertedToInventory:
          serializer.fromJson<bool>(json['isConvertedToInventory']),
      convertedInventoryItemId:
          serializer.fromJson<String?>(json['convertedInventoryItemId']),
      purchasedDate: serializer.fromJson<DateTime?>(json['purchasedDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
      'expectedPricePaise': serializer.toJson<int?>(expectedPricePaise),
      'priority': serializer.toJson<String>(priority),
      'plannedPurchaseDate': serializer.toJson<DateTime>(plannedPurchaseDate),
      'reminderDateTime': serializer.toJson<DateTime?>(reminderDateTime),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'isConvertedToInventory': serializer.toJson<bool>(isConvertedToInventory),
      'convertedInventoryItemId':
          serializer.toJson<String?>(convertedInventoryItemId),
      'purchasedDate': serializer.toJson<DateTime?>(purchasedDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ShoppingItem copyWith(
          {String? id,
          String? name,
          String? category,
          double? quantity,
          String? unit,
          Value<int?> expectedPricePaise = const Value.absent(),
          String? priority,
          DateTime? plannedPurchaseDate,
          Value<DateTime?> reminderDateTime = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? status,
          bool? isConvertedToInventory,
          Value<String?> convertedInventoryItemId = const Value.absent(),
          Value<DateTime?> purchasedDate = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ShoppingItem(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        expectedPricePaise: expectedPricePaise.present
            ? expectedPricePaise.value
            : this.expectedPricePaise,
        priority: priority ?? this.priority,
        plannedPurchaseDate: plannedPurchaseDate ?? this.plannedPurchaseDate,
        reminderDateTime: reminderDateTime.present
            ? reminderDateTime.value
            : this.reminderDateTime,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        isConvertedToInventory:
            isConvertedToInventory ?? this.isConvertedToInventory,
        convertedInventoryItemId: convertedInventoryItemId.present
            ? convertedInventoryItemId.value
            : this.convertedInventoryItemId,
        purchasedDate:
            purchasedDate.present ? purchasedDate.value : this.purchasedDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ShoppingItem copyWithCompanion(ShoppingItemsCompanion data) {
    return ShoppingItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      expectedPricePaise: data.expectedPricePaise.present
          ? data.expectedPricePaise.value
          : this.expectedPricePaise,
      priority: data.priority.present ? data.priority.value : this.priority,
      plannedPurchaseDate: data.plannedPurchaseDate.present
          ? data.plannedPurchaseDate.value
          : this.plannedPurchaseDate,
      reminderDateTime: data.reminderDateTime.present
          ? data.reminderDateTime.value
          : this.reminderDateTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      isConvertedToInventory: data.isConvertedToInventory.present
          ? data.isConvertedToInventory.value
          : this.isConvertedToInventory,
      convertedInventoryItemId: data.convertedInventoryItemId.present
          ? data.convertedInventoryItemId.value
          : this.convertedInventoryItemId,
      purchasedDate: data.purchasedDate.present
          ? data.purchasedDate.value
          : this.purchasedDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('expectedPricePaise: $expectedPricePaise, ')
          ..write('priority: $priority, ')
          ..write('plannedPurchaseDate: $plannedPurchaseDate, ')
          ..write('reminderDateTime: $reminderDateTime, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('isConvertedToInventory: $isConvertedToInventory, ')
          ..write('convertedInventoryItemId: $convertedInventoryItemId, ')
          ..write('purchasedDate: $purchasedDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      category,
      quantity,
      unit,
      expectedPricePaise,
      priority,
      plannedPurchaseDate,
      reminderDateTime,
      notes,
      status,
      isConvertedToInventory,
      convertedInventoryItemId,
      purchasedDate,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.expectedPricePaise == this.expectedPricePaise &&
          other.priority == this.priority &&
          other.plannedPurchaseDate == this.plannedPurchaseDate &&
          other.reminderDateTime == this.reminderDateTime &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.isConvertedToInventory == this.isConvertedToInventory &&
          other.convertedInventoryItemId == this.convertedInventoryItemId &&
          other.purchasedDate == this.purchasedDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ShoppingItemsCompanion extends UpdateCompanion<ShoppingItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<double> quantity;
  final Value<String> unit;
  final Value<int?> expectedPricePaise;
  final Value<String> priority;
  final Value<DateTime> plannedPurchaseDate;
  final Value<DateTime?> reminderDateTime;
  final Value<String?> notes;
  final Value<String> status;
  final Value<bool> isConvertedToInventory;
  final Value<String?> convertedInventoryItemId;
  final Value<DateTime?> purchasedDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ShoppingItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.expectedPricePaise = const Value.absent(),
    this.priority = const Value.absent(),
    this.plannedPurchaseDate = const Value.absent(),
    this.reminderDateTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.isConvertedToInventory = const Value.absent(),
    this.convertedInventoryItemId = const Value.absent(),
    this.purchasedDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShoppingItemsCompanion.insert({
    required String id,
    required String name,
    required String category,
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.expectedPricePaise = const Value.absent(),
    this.priority = const Value.absent(),
    required DateTime plannedPurchaseDate,
    this.reminderDateTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.isConvertedToInventory = const Value.absent(),
    this.convertedInventoryItemId = const Value.absent(),
    this.purchasedDate = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        category = Value(category),
        plannedPurchaseDate = Value(plannedPurchaseDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ShoppingItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<int>? expectedPricePaise,
    Expression<String>? priority,
    Expression<DateTime>? plannedPurchaseDate,
    Expression<DateTime>? reminderDateTime,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<bool>? isConvertedToInventory,
    Expression<String>? convertedInventoryItemId,
    Expression<DateTime>? purchasedDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (expectedPricePaise != null)
        'expected_price_paise': expectedPricePaise,
      if (priority != null) 'priority': priority,
      if (plannedPurchaseDate != null)
        'planned_purchase_date': plannedPurchaseDate,
      if (reminderDateTime != null) 'reminder_date_time': reminderDateTime,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (isConvertedToInventory != null)
        'is_converted_to_inventory': isConvertedToInventory,
      if (convertedInventoryItemId != null)
        'converted_inventory_item_id': convertedInventoryItemId,
      if (purchasedDate != null) 'purchased_date': purchasedDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShoppingItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? category,
      Value<double>? quantity,
      Value<String>? unit,
      Value<int?>? expectedPricePaise,
      Value<String>? priority,
      Value<DateTime>? plannedPurchaseDate,
      Value<DateTime?>? reminderDateTime,
      Value<String?>? notes,
      Value<String>? status,
      Value<bool>? isConvertedToInventory,
      Value<String?>? convertedInventoryItemId,
      Value<DateTime?>? purchasedDate,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ShoppingItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      expectedPricePaise: expectedPricePaise ?? this.expectedPricePaise,
      priority: priority ?? this.priority,
      plannedPurchaseDate: plannedPurchaseDate ?? this.plannedPurchaseDate,
      reminderDateTime: reminderDateTime ?? this.reminderDateTime,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      isConvertedToInventory:
          isConvertedToInventory ?? this.isConvertedToInventory,
      convertedInventoryItemId:
          convertedInventoryItemId ?? this.convertedInventoryItemId,
      purchasedDate: purchasedDate ?? this.purchasedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (expectedPricePaise.present) {
      map['expected_price_paise'] = Variable<int>(expectedPricePaise.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (plannedPurchaseDate.present) {
      map['planned_purchase_date'] =
          Variable<DateTime>(plannedPurchaseDate.value);
    }
    if (reminderDateTime.present) {
      map['reminder_date_time'] = Variable<DateTime>(reminderDateTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isConvertedToInventory.present) {
      map['is_converted_to_inventory'] =
          Variable<bool>(isConvertedToInventory.value);
    }
    if (convertedInventoryItemId.present) {
      map['converted_inventory_item_id'] =
          Variable<String>(convertedInventoryItemId.value);
    }
    if (purchasedDate.present) {
      map['purchased_date'] = Variable<DateTime>(purchasedDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('expectedPricePaise: $expectedPricePaise, ')
          ..write('priority: $priority, ')
          ..write('plannedPurchaseDate: $plannedPurchaseDate, ')
          ..write('reminderDateTime: $reminderDateTime, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('isConvertedToInventory: $isConvertedToInventory, ')
          ..write('convertedInventoryItemId: $convertedInventoryItemId, ')
          ..write('purchasedDate: $purchasedDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, Bill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerMeta =
      const VerificationMeta('provider');
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
      'provider', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expectedAmountPaiseMeta =
      const VerificationMeta('expectedAmountPaise');
  @override
  late final GeneratedColumn<int> expectedAmountPaise = GeneratedColumn<int>(
      'expected_amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _recurrenceMeta =
      const VerificationMeta('recurrence');
  @override
  late final GeneratedColumn<String> recurrence = GeneratedColumn<String>(
      'recurrence', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monthly'));
  static const VerificationMeta _reminderDaysBeforeMeta =
      const VerificationMeta('reminderDaysBefore');
  @override
  late final GeneratedColumn<int> reminderDaysBefore = GeneratedColumn<int>(
      'reminder_days_before', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('upcoming'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _attachmentPathMeta =
      const VerificationMeta('attachmentPath');
  @override
  late final GeneratedColumn<String> attachmentPath = GeneratedColumn<String>(
      'attachment_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        provider,
        expectedAmountPaise,
        dueDate,
        recurrence,
        reminderDaysBefore,
        status,
        notes,
        attachmentPath,
        isArchived,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills';
  @override
  VerificationContext validateIntegrity(Insertable<Bill> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(_providerMeta,
          provider.isAcceptableOrUnknown(data['provider']!, _providerMeta));
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('expected_amount_paise')) {
      context.handle(
          _expectedAmountPaiseMeta,
          expectedAmountPaise.isAcceptableOrUnknown(
              data['expected_amount_paise']!, _expectedAmountPaiseMeta));
    } else if (isInserting) {
      context.missing(_expectedAmountPaiseMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('recurrence')) {
      context.handle(
          _recurrenceMeta,
          recurrence.isAcceptableOrUnknown(
              data['recurrence']!, _recurrenceMeta));
    }
    if (data.containsKey('reminder_days_before')) {
      context.handle(
          _reminderDaysBeforeMeta,
          reminderDaysBefore.isAcceptableOrUnknown(
              data['reminder_days_before']!, _reminderDaysBeforeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('attachment_path')) {
      context.handle(
          _attachmentPathMeta,
          attachmentPath.isAcceptableOrUnknown(
              data['attachment_path']!, _attachmentPathMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bill(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      provider: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider'])!,
      expectedAmountPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}expected_amount_paise'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      recurrence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurrence'])!,
      reminderDaysBefore: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}reminder_days_before'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      attachmentPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attachment_path']),
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(attachedDatabase, alias);
  }
}

class Bill extends DataClass implements Insertable<Bill> {
  final String id;
  final String name;
  final String category;
  final String provider;
  final int expectedAmountPaise;
  final DateTime dueDate;
  final String recurrence;
  final int reminderDaysBefore;
  final String status;
  final String? notes;
  final String? attachmentPath;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Bill(
      {required this.id,
      required this.name,
      required this.category,
      required this.provider,
      required this.expectedAmountPaise,
      required this.dueDate,
      required this.recurrence,
      required this.reminderDaysBefore,
      required this.status,
      this.notes,
      this.attachmentPath,
      required this.isArchived,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['provider'] = Variable<String>(provider);
    map['expected_amount_paise'] = Variable<int>(expectedAmountPaise);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['recurrence'] = Variable<String>(recurrence);
    map['reminder_days_before'] = Variable<int>(reminderDaysBefore);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || attachmentPath != null) {
      map['attachment_path'] = Variable<String>(attachmentPath);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      provider: Value(provider),
      expectedAmountPaise: Value(expectedAmountPaise),
      dueDate: Value(dueDate),
      recurrence: Value(recurrence),
      reminderDaysBefore: Value(reminderDaysBefore),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      attachmentPath: attachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentPath),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Bill.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bill(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      provider: serializer.fromJson<String>(json['provider']),
      expectedAmountPaise:
          serializer.fromJson<int>(json['expectedAmountPaise']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      recurrence: serializer.fromJson<String>(json['recurrence']),
      reminderDaysBefore: serializer.fromJson<int>(json['reminderDaysBefore']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      attachmentPath: serializer.fromJson<String?>(json['attachmentPath']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'provider': serializer.toJson<String>(provider),
      'expectedAmountPaise': serializer.toJson<int>(expectedAmountPaise),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'recurrence': serializer.toJson<String>(recurrence),
      'reminderDaysBefore': serializer.toJson<int>(reminderDaysBefore),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'attachmentPath': serializer.toJson<String?>(attachmentPath),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Bill copyWith(
          {String? id,
          String? name,
          String? category,
          String? provider,
          int? expectedAmountPaise,
          DateTime? dueDate,
          String? recurrence,
          int? reminderDaysBefore,
          String? status,
          Value<String?> notes = const Value.absent(),
          Value<String?> attachmentPath = const Value.absent(),
          bool? isArchived,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Bill(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        provider: provider ?? this.provider,
        expectedAmountPaise: expectedAmountPaise ?? this.expectedAmountPaise,
        dueDate: dueDate ?? this.dueDate,
        recurrence: recurrence ?? this.recurrence,
        reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        attachmentPath:
            attachmentPath.present ? attachmentPath.value : this.attachmentPath,
        isArchived: isArchived ?? this.isArchived,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Bill copyWithCompanion(BillsCompanion data) {
    return Bill(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      provider: data.provider.present ? data.provider.value : this.provider,
      expectedAmountPaise: data.expectedAmountPaise.present
          ? data.expectedAmountPaise.value
          : this.expectedAmountPaise,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      recurrence:
          data.recurrence.present ? data.recurrence.value : this.recurrence,
      reminderDaysBefore: data.reminderDaysBefore.present
          ? data.reminderDaysBefore.value
          : this.reminderDaysBefore,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      attachmentPath: data.attachmentPath.present
          ? data.attachmentPath.value
          : this.attachmentPath,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bill(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('provider: $provider, ')
          ..write('expectedAmountPaise: $expectedAmountPaise, ')
          ..write('dueDate: $dueDate, ')
          ..write('recurrence: $recurrence, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      category,
      provider,
      expectedAmountPaise,
      dueDate,
      recurrence,
      reminderDaysBefore,
      status,
      notes,
      attachmentPath,
      isArchived,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.provider == this.provider &&
          other.expectedAmountPaise == this.expectedAmountPaise &&
          other.dueDate == this.dueDate &&
          other.recurrence == this.recurrence &&
          other.reminderDaysBefore == this.reminderDaysBefore &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.attachmentPath == this.attachmentPath &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillsCompanion extends UpdateCompanion<Bill> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> provider;
  final Value<int> expectedAmountPaise;
  final Value<DateTime> dueDate;
  final Value<String> recurrence;
  final Value<int> reminderDaysBefore;
  final Value<String> status;
  final Value<String?> notes;
  final Value<String?> attachmentPath;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.provider = const Value.absent(),
    this.expectedAmountPaise = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillsCompanion.insert({
    required String id,
    required String name,
    required String category,
    required String provider,
    required int expectedAmountPaise,
    required DateTime dueDate,
    this.recurrence = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        category = Value(category),
        provider = Value(provider),
        expectedAmountPaise = Value(expectedAmountPaise),
        dueDate = Value(dueDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Bill> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? provider,
    Expression<int>? expectedAmountPaise,
    Expression<DateTime>? dueDate,
    Expression<String>? recurrence,
    Expression<int>? reminderDaysBefore,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<String>? attachmentPath,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (provider != null) 'provider': provider,
      if (expectedAmountPaise != null)
        'expected_amount_paise': expectedAmountPaise,
      if (dueDate != null) 'due_date': dueDate,
      if (recurrence != null) 'recurrence': recurrence,
      if (reminderDaysBefore != null)
        'reminder_days_before': reminderDaysBefore,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (attachmentPath != null) 'attachment_path': attachmentPath,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? provider,
      Value<int>? expectedAmountPaise,
      Value<DateTime>? dueDate,
      Value<String>? recurrence,
      Value<int>? reminderDaysBefore,
      Value<String>? status,
      Value<String?>? notes,
      Value<String?>? attachmentPath,
      Value<bool>? isArchived,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return BillsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      provider: provider ?? this.provider,
      expectedAmountPaise: expectedAmountPaise ?? this.expectedAmountPaise,
      dueDate: dueDate ?? this.dueDate,
      recurrence: recurrence ?? this.recurrence,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (expectedAmountPaise.present) {
      map['expected_amount_paise'] = Variable<int>(expectedAmountPaise.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (recurrence.present) {
      map['recurrence'] = Variable<String>(recurrence.value);
    }
    if (reminderDaysBefore.present) {
      map['reminder_days_before'] = Variable<int>(reminderDaysBefore.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (attachmentPath.present) {
      map['attachment_path'] = Variable<String>(attachmentPath.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('provider: $provider, ')
          ..write('expectedAmountPaise: $expectedAmountPaise, ')
          ..write('dueDate: $dueDate, ')
          ..write('recurrence: $recurrence, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillPaymentsTable extends BillPayments
    with TableInfo<$BillPaymentsTable, BillPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
      'bill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bills (id)'));
  static const VerificationMeta _paidAmountPaiseMeta =
      const VerificationMeta('paidAmountPaise');
  @override
  late final GeneratedColumn<int> paidAmountPaise = GeneratedColumn<int>(
      'paid_amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('UPI'));
  static const VerificationMeta _receiptAttachmentPathMeta =
      const VerificationMeta('receiptAttachmentPath');
  @override
  late final GeneratedColumn<String> receiptAttachmentPath =
      GeneratedColumn<String>('receipt_attachment_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        billId,
        paidAmountPaise,
        paymentDate,
        paymentMethod,
        receiptAttachmentPath,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_payments';
  @override
  VerificationContext validateIntegrity(Insertable<BillPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('bill_id')) {
      context.handle(_billIdMeta,
          billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta));
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('paid_amount_paise')) {
      context.handle(
          _paidAmountPaiseMeta,
          paidAmountPaise.isAcceptableOrUnknown(
              data['paid_amount_paise']!, _paidAmountPaiseMeta));
    } else if (isInserting) {
      context.missing(_paidAmountPaiseMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('receipt_attachment_path')) {
      context.handle(
          _receiptAttachmentPathMeta,
          receiptAttachmentPath.isAcceptableOrUnknown(
              data['receipt_attachment_path']!, _receiptAttachmentPathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillPayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      billId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bill_id'])!,
      paidAmountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paid_amount_paise'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      receiptAttachmentPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}receipt_attachment_path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BillPaymentsTable createAlias(String alias) {
    return $BillPaymentsTable(attachedDatabase, alias);
  }
}

class BillPayment extends DataClass implements Insertable<BillPayment> {
  final String id;
  final String billId;
  final int paidAmountPaise;
  final DateTime paymentDate;
  final String paymentMethod;
  final String? receiptAttachmentPath;
  final String? notes;
  final DateTime createdAt;
  const BillPayment(
      {required this.id,
      required this.billId,
      required this.paidAmountPaise,
      required this.paymentDate,
      required this.paymentMethod,
      this.receiptAttachmentPath,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bill_id'] = Variable<String>(billId);
    map['paid_amount_paise'] = Variable<int>(paidAmountPaise);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || receiptAttachmentPath != null) {
      map['receipt_attachment_path'] = Variable<String>(receiptAttachmentPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BillPaymentsCompanion toCompanion(bool nullToAbsent) {
    return BillPaymentsCompanion(
      id: Value(id),
      billId: Value(billId),
      paidAmountPaise: Value(paidAmountPaise),
      paymentDate: Value(paymentDate),
      paymentMethod: Value(paymentMethod),
      receiptAttachmentPath: receiptAttachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptAttachmentPath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory BillPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillPayment(
      id: serializer.fromJson<String>(json['id']),
      billId: serializer.fromJson<String>(json['billId']),
      paidAmountPaise: serializer.fromJson<int>(json['paidAmountPaise']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      receiptAttachmentPath:
          serializer.fromJson<String?>(json['receiptAttachmentPath']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'billId': serializer.toJson<String>(billId),
      'paidAmountPaise': serializer.toJson<int>(paidAmountPaise),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'receiptAttachmentPath':
          serializer.toJson<String?>(receiptAttachmentPath),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BillPayment copyWith(
          {String? id,
          String? billId,
          int? paidAmountPaise,
          DateTime? paymentDate,
          String? paymentMethod,
          Value<String?> receiptAttachmentPath = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      BillPayment(
        id: id ?? this.id,
        billId: billId ?? this.billId,
        paidAmountPaise: paidAmountPaise ?? this.paidAmountPaise,
        paymentDate: paymentDate ?? this.paymentDate,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        receiptAttachmentPath: receiptAttachmentPath.present
            ? receiptAttachmentPath.value
            : this.receiptAttachmentPath,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  BillPayment copyWithCompanion(BillPaymentsCompanion data) {
    return BillPayment(
      id: data.id.present ? data.id.value : this.id,
      billId: data.billId.present ? data.billId.value : this.billId,
      paidAmountPaise: data.paidAmountPaise.present
          ? data.paidAmountPaise.value
          : this.paidAmountPaise,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      receiptAttachmentPath: data.receiptAttachmentPath.present
          ? data.receiptAttachmentPath.value
          : this.receiptAttachmentPath,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillPayment(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('paidAmountPaise: $paidAmountPaise, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('receiptAttachmentPath: $receiptAttachmentPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, billId, paidAmountPaise, paymentDate,
      paymentMethod, receiptAttachmentPath, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillPayment &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.paidAmountPaise == this.paidAmountPaise &&
          other.paymentDate == this.paymentDate &&
          other.paymentMethod == this.paymentMethod &&
          other.receiptAttachmentPath == this.receiptAttachmentPath &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class BillPaymentsCompanion extends UpdateCompanion<BillPayment> {
  final Value<String> id;
  final Value<String> billId;
  final Value<int> paidAmountPaise;
  final Value<DateTime> paymentDate;
  final Value<String> paymentMethod;
  final Value<String?> receiptAttachmentPath;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BillPaymentsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.paidAmountPaise = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.receiptAttachmentPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillPaymentsCompanion.insert({
    required String id,
    required String billId,
    required int paidAmountPaise,
    required DateTime paymentDate,
    this.paymentMethod = const Value.absent(),
    this.receiptAttachmentPath = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        billId = Value(billId),
        paidAmountPaise = Value(paidAmountPaise),
        paymentDate = Value(paymentDate),
        createdAt = Value(createdAt);
  static Insertable<BillPayment> custom({
    Expression<String>? id,
    Expression<String>? billId,
    Expression<int>? paidAmountPaise,
    Expression<DateTime>? paymentDate,
    Expression<String>? paymentMethod,
    Expression<String>? receiptAttachmentPath,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (paidAmountPaise != null) 'paid_amount_paise': paidAmountPaise,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (receiptAttachmentPath != null)
        'receipt_attachment_path': receiptAttachmentPath,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillPaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? billId,
      Value<int>? paidAmountPaise,
      Value<DateTime>? paymentDate,
      Value<String>? paymentMethod,
      Value<String?>? receiptAttachmentPath,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return BillPaymentsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      paidAmountPaise: paidAmountPaise ?? this.paidAmountPaise,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      receiptAttachmentPath:
          receiptAttachmentPath ?? this.receiptAttachmentPath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (paidAmountPaise.present) {
      map['paid_amount_paise'] = Variable<int>(paidAmountPaise.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (receiptAttachmentPath.present) {
      map['receipt_attachment_path'] =
          Variable<String>(receiptAttachmentPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('paidAmountPaise: $paidAmountPaise, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('receiptAttachmentPath: $receiptAttachmentPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetsTable extends Assets with TableInfo<$AssetsTable, Asset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serialNumberMeta =
      const VerificationMeta('serialNumber');
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
      'serial_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _purchaseDateMeta =
      const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
      'purchase_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _purchasePricePaiseMeta =
      const VerificationMeta('purchasePricePaise');
  @override
  late final GeneratedColumn<int> purchasePricePaise = GeneratedColumn<int>(
      'purchase_price_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _warrantyStartDateMeta =
      const VerificationMeta('warrantyStartDate');
  @override
  late final GeneratedColumn<DateTime> warrantyStartDate =
      GeneratedColumn<DateTime>('warranty_start_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _warrantyExpiryDateMeta =
      const VerificationMeta('warrantyExpiryDate');
  @override
  late final GeneratedColumn<DateTime> warrantyExpiryDate =
      GeneratedColumn<DateTime>('warranty_expiry_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sellerMeta = const VerificationMeta('seller');
  @override
  late final GeneratedColumn<String> seller = GeneratedColumn<String>(
      'seller', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _invoiceAttachmentPathMeta =
      const VerificationMeta('invoiceAttachmentPath');
  @override
  late final GeneratedColumn<String> invoiceAttachmentPath =
      GeneratedColumn<String>('invoice_attachment_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _warrantyDocPathMeta =
      const VerificationMeta('warrantyDocPath');
  @override
  late final GeneratedColumn<String> warrantyDocPath = GeneratedColumn<String>(
      'warranty_doc_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serviceIntervalMonthsMeta =
      const VerificationMeta('serviceIntervalMonths');
  @override
  late final GeneratedColumn<int> serviceIntervalMonths = GeneratedColumn<int>(
      'service_interval_months', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastServiceDateMeta =
      const VerificationMeta('lastServiceDate');
  @override
  late final GeneratedColumn<DateTime> lastServiceDate =
      GeneratedColumn<DateTime>('last_service_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nextServiceDateMeta =
      const VerificationMeta('nextServiceDate');
  @override
  late final GeneratedColumn<DateTime> nextServiceDate =
      GeneratedColumn<DateTime>('next_service_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        brand,
        model,
        serialNumber,
        purchaseDate,
        purchasePricePaise,
        warrantyStartDate,
        warrantyExpiryDate,
        seller,
        invoiceAttachmentPath,
        warrantyDocPath,
        imagePath,
        serviceIntervalMonths,
        lastServiceDate,
        nextServiceDate,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(Insertable<Asset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    }
    if (data.containsKey('serial_number')) {
      context.handle(
          _serialNumberMeta,
          serialNumber.isAcceptableOrUnknown(
              data['serial_number']!, _serialNumberMeta));
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
          _purchaseDateMeta,
          purchaseDate.isAcceptableOrUnknown(
              data['purchase_date']!, _purchaseDateMeta));
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('purchase_price_paise')) {
      context.handle(
          _purchasePricePaiseMeta,
          purchasePricePaise.isAcceptableOrUnknown(
              data['purchase_price_paise']!, _purchasePricePaiseMeta));
    }
    if (data.containsKey('warranty_start_date')) {
      context.handle(
          _warrantyStartDateMeta,
          warrantyStartDate.isAcceptableOrUnknown(
              data['warranty_start_date']!, _warrantyStartDateMeta));
    }
    if (data.containsKey('warranty_expiry_date')) {
      context.handle(
          _warrantyExpiryDateMeta,
          warrantyExpiryDate.isAcceptableOrUnknown(
              data['warranty_expiry_date']!, _warrantyExpiryDateMeta));
    } else if (isInserting) {
      context.missing(_warrantyExpiryDateMeta);
    }
    if (data.containsKey('seller')) {
      context.handle(_sellerMeta,
          seller.isAcceptableOrUnknown(data['seller']!, _sellerMeta));
    }
    if (data.containsKey('invoice_attachment_path')) {
      context.handle(
          _invoiceAttachmentPathMeta,
          invoiceAttachmentPath.isAcceptableOrUnknown(
              data['invoice_attachment_path']!, _invoiceAttachmentPathMeta));
    }
    if (data.containsKey('warranty_doc_path')) {
      context.handle(
          _warrantyDocPathMeta,
          warrantyDocPath.isAcceptableOrUnknown(
              data['warranty_doc_path']!, _warrantyDocPathMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('service_interval_months')) {
      context.handle(
          _serviceIntervalMonthsMeta,
          serviceIntervalMonths.isAcceptableOrUnknown(
              data['service_interval_months']!, _serviceIntervalMonthsMeta));
    }
    if (data.containsKey('last_service_date')) {
      context.handle(
          _lastServiceDateMeta,
          lastServiceDate.isAcceptableOrUnknown(
              data['last_service_date']!, _lastServiceDateMeta));
    }
    if (data.containsKey('next_service_date')) {
      context.handle(
          _nextServiceDateMeta,
          nextServiceDate.isAcceptableOrUnknown(
              data['next_service_date']!, _nextServiceDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Asset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Asset(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model']),
      serialNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}serial_number']),
      purchaseDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}purchase_date'])!,
      purchasePricePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}purchase_price_paise']),
      warrantyStartDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}warranty_start_date']),
      warrantyExpiryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}warranty_expiry_date'])!,
      seller: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seller']),
      invoiceAttachmentPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}invoice_attachment_path']),
      warrantyDocPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}warranty_doc_path']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      serviceIntervalMonths: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}service_interval_months']),
      lastServiceDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_service_date']),
      nextServiceDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_service_date']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AssetsTable createAlias(String alias) {
    return $AssetsTable(attachedDatabase, alias);
  }
}

class Asset extends DataClass implements Insertable<Asset> {
  final String id;
  final String name;
  final String category;
  final String? brand;
  final String? model;
  final String? serialNumber;
  final DateTime purchaseDate;
  final int? purchasePricePaise;
  final DateTime? warrantyStartDate;
  final DateTime warrantyExpiryDate;
  final String? seller;
  final String? invoiceAttachmentPath;
  final String? warrantyDocPath;
  final String? imagePath;
  final int? serviceIntervalMonths;
  final DateTime? lastServiceDate;
  final DateTime? nextServiceDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Asset(
      {required this.id,
      required this.name,
      required this.category,
      this.brand,
      this.model,
      this.serialNumber,
      required this.purchaseDate,
      this.purchasePricePaise,
      this.warrantyStartDate,
      required this.warrantyExpiryDate,
      this.seller,
      this.invoiceAttachmentPath,
      this.warrantyDocPath,
      this.imagePath,
      this.serviceIntervalMonths,
      this.lastServiceDate,
      this.nextServiceDate,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    if (!nullToAbsent || purchasePricePaise != null) {
      map['purchase_price_paise'] = Variable<int>(purchasePricePaise);
    }
    if (!nullToAbsent || warrantyStartDate != null) {
      map['warranty_start_date'] = Variable<DateTime>(warrantyStartDate);
    }
    map['warranty_expiry_date'] = Variable<DateTime>(warrantyExpiryDate);
    if (!nullToAbsent || seller != null) {
      map['seller'] = Variable<String>(seller);
    }
    if (!nullToAbsent || invoiceAttachmentPath != null) {
      map['invoice_attachment_path'] = Variable<String>(invoiceAttachmentPath);
    }
    if (!nullToAbsent || warrantyDocPath != null) {
      map['warranty_doc_path'] = Variable<String>(warrantyDocPath);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || serviceIntervalMonths != null) {
      map['service_interval_months'] = Variable<int>(serviceIntervalMonths);
    }
    if (!nullToAbsent || lastServiceDate != null) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate);
    }
    if (!nullToAbsent || nextServiceDate != null) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AssetsCompanion toCompanion(bool nullToAbsent) {
    return AssetsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      serialNumber: serialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(serialNumber),
      purchaseDate: Value(purchaseDate),
      purchasePricePaise: purchasePricePaise == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePricePaise),
      warrantyStartDate: warrantyStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyStartDate),
      warrantyExpiryDate: Value(warrantyExpiryDate),
      seller:
          seller == null && nullToAbsent ? const Value.absent() : Value(seller),
      invoiceAttachmentPath: invoiceAttachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceAttachmentPath),
      warrantyDocPath: warrantyDocPath == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyDocPath),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      serviceIntervalMonths: serviceIntervalMonths == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceIntervalMonths),
      lastServiceDate: lastServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastServiceDate),
      nextServiceDate: nextServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Asset.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Asset(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      brand: serializer.fromJson<String?>(json['brand']),
      model: serializer.fromJson<String?>(json['model']),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      purchasePricePaise: serializer.fromJson<int?>(json['purchasePricePaise']),
      warrantyStartDate:
          serializer.fromJson<DateTime?>(json['warrantyStartDate']),
      warrantyExpiryDate:
          serializer.fromJson<DateTime>(json['warrantyExpiryDate']),
      seller: serializer.fromJson<String?>(json['seller']),
      invoiceAttachmentPath:
          serializer.fromJson<String?>(json['invoiceAttachmentPath']),
      warrantyDocPath: serializer.fromJson<String?>(json['warrantyDocPath']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      serviceIntervalMonths:
          serializer.fromJson<int?>(json['serviceIntervalMonths']),
      lastServiceDate: serializer.fromJson<DateTime?>(json['lastServiceDate']),
      nextServiceDate: serializer.fromJson<DateTime?>(json['nextServiceDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'brand': serializer.toJson<String?>(brand),
      'model': serializer.toJson<String?>(model),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'purchasePricePaise': serializer.toJson<int?>(purchasePricePaise),
      'warrantyStartDate': serializer.toJson<DateTime?>(warrantyStartDate),
      'warrantyExpiryDate': serializer.toJson<DateTime>(warrantyExpiryDate),
      'seller': serializer.toJson<String?>(seller),
      'invoiceAttachmentPath':
          serializer.toJson<String?>(invoiceAttachmentPath),
      'warrantyDocPath': serializer.toJson<String?>(warrantyDocPath),
      'imagePath': serializer.toJson<String?>(imagePath),
      'serviceIntervalMonths': serializer.toJson<int?>(serviceIntervalMonths),
      'lastServiceDate': serializer.toJson<DateTime?>(lastServiceDate),
      'nextServiceDate': serializer.toJson<DateTime?>(nextServiceDate),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Asset copyWith(
          {String? id,
          String? name,
          String? category,
          Value<String?> brand = const Value.absent(),
          Value<String?> model = const Value.absent(),
          Value<String?> serialNumber = const Value.absent(),
          DateTime? purchaseDate,
          Value<int?> purchasePricePaise = const Value.absent(),
          Value<DateTime?> warrantyStartDate = const Value.absent(),
          DateTime? warrantyExpiryDate,
          Value<String?> seller = const Value.absent(),
          Value<String?> invoiceAttachmentPath = const Value.absent(),
          Value<String?> warrantyDocPath = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          Value<int?> serviceIntervalMonths = const Value.absent(),
          Value<DateTime?> lastServiceDate = const Value.absent(),
          Value<DateTime?> nextServiceDate = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Asset(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        brand: brand.present ? brand.value : this.brand,
        model: model.present ? model.value : this.model,
        serialNumber:
            serialNumber.present ? serialNumber.value : this.serialNumber,
        purchaseDate: purchaseDate ?? this.purchaseDate,
        purchasePricePaise: purchasePricePaise.present
            ? purchasePricePaise.value
            : this.purchasePricePaise,
        warrantyStartDate: warrantyStartDate.present
            ? warrantyStartDate.value
            : this.warrantyStartDate,
        warrantyExpiryDate: warrantyExpiryDate ?? this.warrantyExpiryDate,
        seller: seller.present ? seller.value : this.seller,
        invoiceAttachmentPath: invoiceAttachmentPath.present
            ? invoiceAttachmentPath.value
            : this.invoiceAttachmentPath,
        warrantyDocPath: warrantyDocPath.present
            ? warrantyDocPath.value
            : this.warrantyDocPath,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        serviceIntervalMonths: serviceIntervalMonths.present
            ? serviceIntervalMonths.value
            : this.serviceIntervalMonths,
        lastServiceDate: lastServiceDate.present
            ? lastServiceDate.value
            : this.lastServiceDate,
        nextServiceDate: nextServiceDate.present
            ? nextServiceDate.value
            : this.nextServiceDate,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Asset copyWithCompanion(AssetsCompanion data) {
    return Asset(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      purchasePricePaise: data.purchasePricePaise.present
          ? data.purchasePricePaise.value
          : this.purchasePricePaise,
      warrantyStartDate: data.warrantyStartDate.present
          ? data.warrantyStartDate.value
          : this.warrantyStartDate,
      warrantyExpiryDate: data.warrantyExpiryDate.present
          ? data.warrantyExpiryDate.value
          : this.warrantyExpiryDate,
      seller: data.seller.present ? data.seller.value : this.seller,
      invoiceAttachmentPath: data.invoiceAttachmentPath.present
          ? data.invoiceAttachmentPath.value
          : this.invoiceAttachmentPath,
      warrantyDocPath: data.warrantyDocPath.present
          ? data.warrantyDocPath.value
          : this.warrantyDocPath,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      serviceIntervalMonths: data.serviceIntervalMonths.present
          ? data.serviceIntervalMonths.value
          : this.serviceIntervalMonths,
      lastServiceDate: data.lastServiceDate.present
          ? data.lastServiceDate.value
          : this.lastServiceDate,
      nextServiceDate: data.nextServiceDate.present
          ? data.nextServiceDate.value
          : this.nextServiceDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Asset(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePricePaise: $purchasePricePaise, ')
          ..write('warrantyStartDate: $warrantyStartDate, ')
          ..write('warrantyExpiryDate: $warrantyExpiryDate, ')
          ..write('seller: $seller, ')
          ..write('invoiceAttachmentPath: $invoiceAttachmentPath, ')
          ..write('warrantyDocPath: $warrantyDocPath, ')
          ..write('imagePath: $imagePath, ')
          ..write('serviceIntervalMonths: $serviceIntervalMonths, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      category,
      brand,
      model,
      serialNumber,
      purchaseDate,
      purchasePricePaise,
      warrantyStartDate,
      warrantyExpiryDate,
      seller,
      invoiceAttachmentPath,
      warrantyDocPath,
      imagePath,
      serviceIntervalMonths,
      lastServiceDate,
      nextServiceDate,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Asset &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.serialNumber == this.serialNumber &&
          other.purchaseDate == this.purchaseDate &&
          other.purchasePricePaise == this.purchasePricePaise &&
          other.warrantyStartDate == this.warrantyStartDate &&
          other.warrantyExpiryDate == this.warrantyExpiryDate &&
          other.seller == this.seller &&
          other.invoiceAttachmentPath == this.invoiceAttachmentPath &&
          other.warrantyDocPath == this.warrantyDocPath &&
          other.imagePath == this.imagePath &&
          other.serviceIntervalMonths == this.serviceIntervalMonths &&
          other.lastServiceDate == this.lastServiceDate &&
          other.nextServiceDate == this.nextServiceDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AssetsCompanion extends UpdateCompanion<Asset> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> brand;
  final Value<String?> model;
  final Value<String?> serialNumber;
  final Value<DateTime> purchaseDate;
  final Value<int?> purchasePricePaise;
  final Value<DateTime?> warrantyStartDate;
  final Value<DateTime> warrantyExpiryDate;
  final Value<String?> seller;
  final Value<String?> invoiceAttachmentPath;
  final Value<String?> warrantyDocPath;
  final Value<String?> imagePath;
  final Value<int?> serviceIntervalMonths;
  final Value<DateTime?> lastServiceDate;
  final Value<DateTime?> nextServiceDate;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AssetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePricePaise = const Value.absent(),
    this.warrantyStartDate = const Value.absent(),
    this.warrantyExpiryDate = const Value.absent(),
    this.seller = const Value.absent(),
    this.invoiceAttachmentPath = const Value.absent(),
    this.warrantyDocPath = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.serviceIntervalMonths = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetsCompanion.insert({
    required String id,
    required String name,
    required String category,
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    required DateTime purchaseDate,
    this.purchasePricePaise = const Value.absent(),
    this.warrantyStartDate = const Value.absent(),
    required DateTime warrantyExpiryDate,
    this.seller = const Value.absent(),
    this.invoiceAttachmentPath = const Value.absent(),
    this.warrantyDocPath = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.serviceIntervalMonths = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        category = Value(category),
        purchaseDate = Value(purchaseDate),
        warrantyExpiryDate = Value(warrantyExpiryDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Asset> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<String>? serialNumber,
    Expression<DateTime>? purchaseDate,
    Expression<int>? purchasePricePaise,
    Expression<DateTime>? warrantyStartDate,
    Expression<DateTime>? warrantyExpiryDate,
    Expression<String>? seller,
    Expression<String>? invoiceAttachmentPath,
    Expression<String>? warrantyDocPath,
    Expression<String>? imagePath,
    Expression<int>? serviceIntervalMonths,
    Expression<DateTime>? lastServiceDate,
    Expression<DateTime>? nextServiceDate,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (purchasePricePaise != null)
        'purchase_price_paise': purchasePricePaise,
      if (warrantyStartDate != null) 'warranty_start_date': warrantyStartDate,
      if (warrantyExpiryDate != null)
        'warranty_expiry_date': warrantyExpiryDate,
      if (seller != null) 'seller': seller,
      if (invoiceAttachmentPath != null)
        'invoice_attachment_path': invoiceAttachmentPath,
      if (warrantyDocPath != null) 'warranty_doc_path': warrantyDocPath,
      if (imagePath != null) 'image_path': imagePath,
      if (serviceIntervalMonths != null)
        'service_interval_months': serviceIntervalMonths,
      if (lastServiceDate != null) 'last_service_date': lastServiceDate,
      if (nextServiceDate != null) 'next_service_date': nextServiceDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String?>? brand,
      Value<String?>? model,
      Value<String?>? serialNumber,
      Value<DateTime>? purchaseDate,
      Value<int?>? purchasePricePaise,
      Value<DateTime?>? warrantyStartDate,
      Value<DateTime>? warrantyExpiryDate,
      Value<String?>? seller,
      Value<String?>? invoiceAttachmentPath,
      Value<String?>? warrantyDocPath,
      Value<String?>? imagePath,
      Value<int?>? serviceIntervalMonths,
      Value<DateTime?>? lastServiceDate,
      Value<DateTime?>? nextServiceDate,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AssetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePricePaise: purchasePricePaise ?? this.purchasePricePaise,
      warrantyStartDate: warrantyStartDate ?? this.warrantyStartDate,
      warrantyExpiryDate: warrantyExpiryDate ?? this.warrantyExpiryDate,
      seller: seller ?? this.seller,
      invoiceAttachmentPath:
          invoiceAttachmentPath ?? this.invoiceAttachmentPath,
      warrantyDocPath: warrantyDocPath ?? this.warrantyDocPath,
      imagePath: imagePath ?? this.imagePath,
      serviceIntervalMonths:
          serviceIntervalMonths ?? this.serviceIntervalMonths,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (purchasePricePaise.present) {
      map['purchase_price_paise'] = Variable<int>(purchasePricePaise.value);
    }
    if (warrantyStartDate.present) {
      map['warranty_start_date'] = Variable<DateTime>(warrantyStartDate.value);
    }
    if (warrantyExpiryDate.present) {
      map['warranty_expiry_date'] =
          Variable<DateTime>(warrantyExpiryDate.value);
    }
    if (seller.present) {
      map['seller'] = Variable<String>(seller.value);
    }
    if (invoiceAttachmentPath.present) {
      map['invoice_attachment_path'] =
          Variable<String>(invoiceAttachmentPath.value);
    }
    if (warrantyDocPath.present) {
      map['warranty_doc_path'] = Variable<String>(warrantyDocPath.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (serviceIntervalMonths.present) {
      map['service_interval_months'] =
          Variable<int>(serviceIntervalMonths.value);
    }
    if (lastServiceDate.present) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate.value);
    }
    if (nextServiceDate.present) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePricePaise: $purchasePricePaise, ')
          ..write('warrantyStartDate: $warrantyStartDate, ')
          ..write('warrantyExpiryDate: $warrantyExpiryDate, ')
          ..write('seller: $seller, ')
          ..write('invoiceAttachmentPath: $invoiceAttachmentPath, ')
          ..write('warrantyDocPath: $warrantyDocPath, ')
          ..write('imagePath: $imagePath, ')
          ..write('serviceIntervalMonths: $serviceIntervalMonths, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetServicesTable extends AssetServices
    with TableInfo<$AssetServicesTable, AssetService> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES assets (id)'));
  static const VerificationMeta _serviceDateMeta =
      const VerificationMeta('serviceDate');
  @override
  late final GeneratedColumn<DateTime> serviceDate = GeneratedColumn<DateTime>(
      'service_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _serviceTypeMeta =
      const VerificationMeta('serviceType');
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
      'service_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _technicianNameMeta =
      const VerificationMeta('technicianName');
  @override
  late final GeneratedColumn<String> technicianName = GeneratedColumn<String>(
      'technician_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _technicianContactMeta =
      const VerificationMeta('technicianContact');
  @override
  late final GeneratedColumn<String> technicianContact =
      GeneratedColumn<String>('technician_contact', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _costPaiseMeta =
      const VerificationMeta('costPaise');
  @override
  late final GeneratedColumn<int> costPaise = GeneratedColumn<int>(
      'cost_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receiptAttachmentPathMeta =
      const VerificationMeta('receiptAttachmentPath');
  @override
  late final GeneratedColumn<String> receiptAttachmentPath =
      GeneratedColumn<String>('receipt_attachment_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        assetId,
        serviceDate,
        serviceType,
        technicianName,
        technicianContact,
        costPaise,
        notes,
        receiptAttachmentPath,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'asset_services';
  @override
  VerificationContext validateIntegrity(Insertable<AssetService> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('service_date')) {
      context.handle(
          _serviceDateMeta,
          serviceDate.isAcceptableOrUnknown(
              data['service_date']!, _serviceDateMeta));
    } else if (isInserting) {
      context.missing(_serviceDateMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
          _serviceTypeMeta,
          serviceType.isAcceptableOrUnknown(
              data['service_type']!, _serviceTypeMeta));
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('technician_name')) {
      context.handle(
          _technicianNameMeta,
          technicianName.isAcceptableOrUnknown(
              data['technician_name']!, _technicianNameMeta));
    }
    if (data.containsKey('technician_contact')) {
      context.handle(
          _technicianContactMeta,
          technicianContact.isAcceptableOrUnknown(
              data['technician_contact']!, _technicianContactMeta));
    }
    if (data.containsKey('cost_paise')) {
      context.handle(_costPaiseMeta,
          costPaise.isAcceptableOrUnknown(data['cost_paise']!, _costPaiseMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('receipt_attachment_path')) {
      context.handle(
          _receiptAttachmentPathMeta,
          receiptAttachmentPath.isAcceptableOrUnknown(
              data['receipt_attachment_path']!, _receiptAttachmentPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetService map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetService(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      serviceDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}service_date'])!,
      serviceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_type'])!,
      technicianName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}technician_name']),
      technicianContact: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}technician_contact']),
      costPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cost_paise'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      receiptAttachmentPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}receipt_attachment_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AssetServicesTable createAlias(String alias) {
    return $AssetServicesTable(attachedDatabase, alias);
  }
}

class AssetService extends DataClass implements Insertable<AssetService> {
  final String id;
  final String assetId;
  final DateTime serviceDate;
  final String serviceType;
  final String? technicianName;
  final String? technicianContact;
  final int costPaise;
  final String? notes;
  final String? receiptAttachmentPath;
  final DateTime createdAt;
  const AssetService(
      {required this.id,
      required this.assetId,
      required this.serviceDate,
      required this.serviceType,
      this.technicianName,
      this.technicianContact,
      required this.costPaise,
      this.notes,
      this.receiptAttachmentPath,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['asset_id'] = Variable<String>(assetId);
    map['service_date'] = Variable<DateTime>(serviceDate);
    map['service_type'] = Variable<String>(serviceType);
    if (!nullToAbsent || technicianName != null) {
      map['technician_name'] = Variable<String>(technicianName);
    }
    if (!nullToAbsent || technicianContact != null) {
      map['technician_contact'] = Variable<String>(technicianContact);
    }
    map['cost_paise'] = Variable<int>(costPaise);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || receiptAttachmentPath != null) {
      map['receipt_attachment_path'] = Variable<String>(receiptAttachmentPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AssetServicesCompanion toCompanion(bool nullToAbsent) {
    return AssetServicesCompanion(
      id: Value(id),
      assetId: Value(assetId),
      serviceDate: Value(serviceDate),
      serviceType: Value(serviceType),
      technicianName: technicianName == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianName),
      technicianContact: technicianContact == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianContact),
      costPaise: Value(costPaise),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      receiptAttachmentPath: receiptAttachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptAttachmentPath),
      createdAt: Value(createdAt),
    );
  }

  factory AssetService.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetService(
      id: serializer.fromJson<String>(json['id']),
      assetId: serializer.fromJson<String>(json['assetId']),
      serviceDate: serializer.fromJson<DateTime>(json['serviceDate']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      technicianName: serializer.fromJson<String?>(json['technicianName']),
      technicianContact:
          serializer.fromJson<String?>(json['technicianContact']),
      costPaise: serializer.fromJson<int>(json['costPaise']),
      notes: serializer.fromJson<String?>(json['notes']),
      receiptAttachmentPath:
          serializer.fromJson<String?>(json['receiptAttachmentPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assetId': serializer.toJson<String>(assetId),
      'serviceDate': serializer.toJson<DateTime>(serviceDate),
      'serviceType': serializer.toJson<String>(serviceType),
      'technicianName': serializer.toJson<String?>(technicianName),
      'technicianContact': serializer.toJson<String?>(technicianContact),
      'costPaise': serializer.toJson<int>(costPaise),
      'notes': serializer.toJson<String?>(notes),
      'receiptAttachmentPath':
          serializer.toJson<String?>(receiptAttachmentPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AssetService copyWith(
          {String? id,
          String? assetId,
          DateTime? serviceDate,
          String? serviceType,
          Value<String?> technicianName = const Value.absent(),
          Value<String?> technicianContact = const Value.absent(),
          int? costPaise,
          Value<String?> notes = const Value.absent(),
          Value<String?> receiptAttachmentPath = const Value.absent(),
          DateTime? createdAt}) =>
      AssetService(
        id: id ?? this.id,
        assetId: assetId ?? this.assetId,
        serviceDate: serviceDate ?? this.serviceDate,
        serviceType: serviceType ?? this.serviceType,
        technicianName:
            technicianName.present ? technicianName.value : this.technicianName,
        technicianContact: technicianContact.present
            ? technicianContact.value
            : this.technicianContact,
        costPaise: costPaise ?? this.costPaise,
        notes: notes.present ? notes.value : this.notes,
        receiptAttachmentPath: receiptAttachmentPath.present
            ? receiptAttachmentPath.value
            : this.receiptAttachmentPath,
        createdAt: createdAt ?? this.createdAt,
      );
  AssetService copyWithCompanion(AssetServicesCompanion data) {
    return AssetService(
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      serviceDate:
          data.serviceDate.present ? data.serviceDate.value : this.serviceDate,
      serviceType:
          data.serviceType.present ? data.serviceType.value : this.serviceType,
      technicianName: data.technicianName.present
          ? data.technicianName.value
          : this.technicianName,
      technicianContact: data.technicianContact.present
          ? data.technicianContact.value
          : this.technicianContact,
      costPaise: data.costPaise.present ? data.costPaise.value : this.costPaise,
      notes: data.notes.present ? data.notes.value : this.notes,
      receiptAttachmentPath: data.receiptAttachmentPath.present
          ? data.receiptAttachmentPath.value
          : this.receiptAttachmentPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetService(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('serviceType: $serviceType, ')
          ..write('technicianName: $technicianName, ')
          ..write('technicianContact: $technicianContact, ')
          ..write('costPaise: $costPaise, ')
          ..write('notes: $notes, ')
          ..write('receiptAttachmentPath: $receiptAttachmentPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      assetId,
      serviceDate,
      serviceType,
      technicianName,
      technicianContact,
      costPaise,
      notes,
      receiptAttachmentPath,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetService &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.serviceDate == this.serviceDate &&
          other.serviceType == this.serviceType &&
          other.technicianName == this.technicianName &&
          other.technicianContact == this.technicianContact &&
          other.costPaise == this.costPaise &&
          other.notes == this.notes &&
          other.receiptAttachmentPath == this.receiptAttachmentPath &&
          other.createdAt == this.createdAt);
}

class AssetServicesCompanion extends UpdateCompanion<AssetService> {
  final Value<String> id;
  final Value<String> assetId;
  final Value<DateTime> serviceDate;
  final Value<String> serviceType;
  final Value<String?> technicianName;
  final Value<String?> technicianContact;
  final Value<int> costPaise;
  final Value<String?> notes;
  final Value<String?> receiptAttachmentPath;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AssetServicesCompanion({
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.technicianName = const Value.absent(),
    this.technicianContact = const Value.absent(),
    this.costPaise = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptAttachmentPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetServicesCompanion.insert({
    required String id,
    required String assetId,
    required DateTime serviceDate,
    required String serviceType,
    this.technicianName = const Value.absent(),
    this.technicianContact = const Value.absent(),
    this.costPaise = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptAttachmentPath = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        assetId = Value(assetId),
        serviceDate = Value(serviceDate),
        serviceType = Value(serviceType),
        createdAt = Value(createdAt);
  static Insertable<AssetService> custom({
    Expression<String>? id,
    Expression<String>? assetId,
    Expression<DateTime>? serviceDate,
    Expression<String>? serviceType,
    Expression<String>? technicianName,
    Expression<String>? technicianContact,
    Expression<int>? costPaise,
    Expression<String>? notes,
    Expression<String>? receiptAttachmentPath,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (serviceDate != null) 'service_date': serviceDate,
      if (serviceType != null) 'service_type': serviceType,
      if (technicianName != null) 'technician_name': technicianName,
      if (technicianContact != null) 'technician_contact': technicianContact,
      if (costPaise != null) 'cost_paise': costPaise,
      if (notes != null) 'notes': notes,
      if (receiptAttachmentPath != null)
        'receipt_attachment_path': receiptAttachmentPath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetServicesCompanion copyWith(
      {Value<String>? id,
      Value<String>? assetId,
      Value<DateTime>? serviceDate,
      Value<String>? serviceType,
      Value<String?>? technicianName,
      Value<String?>? technicianContact,
      Value<int>? costPaise,
      Value<String?>? notes,
      Value<String?>? receiptAttachmentPath,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AssetServicesCompanion(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      serviceDate: serviceDate ?? this.serviceDate,
      serviceType: serviceType ?? this.serviceType,
      technicianName: technicianName ?? this.technicianName,
      technicianContact: technicianContact ?? this.technicianContact,
      costPaise: costPaise ?? this.costPaise,
      notes: notes ?? this.notes,
      receiptAttachmentPath:
          receiptAttachmentPath ?? this.receiptAttachmentPath,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<DateTime>(serviceDate.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (technicianName.present) {
      map['technician_name'] = Variable<String>(technicianName.value);
    }
    if (technicianContact.present) {
      map['technician_contact'] = Variable<String>(technicianContact.value);
    }
    if (costPaise.present) {
      map['cost_paise'] = Variable<int>(costPaise.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (receiptAttachmentPath.present) {
      map['receipt_attachment_path'] =
          Variable<String>(receiptAttachmentPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetServicesCompanion(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('serviceType: $serviceType, ')
          ..write('technicianName: $technicianName, ')
          ..write('technicianContact: $technicianContact, ')
          ..write('costPaise: $costPaise, ')
          ..write('notes: $notes, ')
          ..write('receiptAttachmentPath: $receiptAttachmentPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _registrationNumberMeta =
      const VerificationMeta('registrationNumber');
  @override
  late final GeneratedColumn<String> registrationNumber =
      GeneratedColumn<String>('registration_number', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 50),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _vehicleTypeMeta =
      const VerificationMeta('vehicleType');
  @override
  late final GeneratedColumn<String> vehicleType = GeneratedColumn<String>(
      'vehicle_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _purchaseDateMeta =
      const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
      'purchase_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _currentOdometerKmMeta =
      const VerificationMeta('currentOdometerKm');
  @override
  late final GeneratedColumn<int> currentOdometerKm = GeneratedColumn<int>(
      'current_odometer_km', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _insuranceExpiryMeta =
      const VerificationMeta('insuranceExpiry');
  @override
  late final GeneratedColumn<DateTime> insuranceExpiry =
      GeneratedColumn<DateTime>('insurance_expiry', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _pucExpiryMeta =
      const VerificationMeta('pucExpiry');
  @override
  late final GeneratedColumn<DateTime> pucExpiry = GeneratedColumn<DateTime>(
      'puc_expiry', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _registrationExpiryMeta =
      const VerificationMeta('registrationExpiry');
  @override
  late final GeneratedColumn<DateTime> registrationExpiry =
      GeneratedColumn<DateTime>('registration_expiry', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastServiceDateMeta =
      const VerificationMeta('lastServiceDate');
  @override
  late final GeneratedColumn<DateTime> lastServiceDate =
      GeneratedColumn<DateTime>('last_service_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nextServiceDateMeta =
      const VerificationMeta('nextServiceDate');
  @override
  late final GeneratedColumn<DateTime> nextServiceDate =
      GeneratedColumn<DateTime>('next_service_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nextServiceOdometerKmMeta =
      const VerificationMeta('nextServiceOdometerKm');
  @override
  late final GeneratedColumn<int> nextServiceOdometerKm = GeneratedColumn<int>(
      'next_service_odometer_km', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        registrationNumber,
        vehicleType,
        brand,
        model,
        purchaseDate,
        currentOdometerKm,
        insuranceExpiry,
        pucExpiry,
        registrationExpiry,
        lastServiceDate,
        nextServiceDate,
        nextServiceOdometerKm,
        imagePath,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(Insertable<Vehicle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('registration_number')) {
      context.handle(
          _registrationNumberMeta,
          registrationNumber.isAcceptableOrUnknown(
              data['registration_number']!, _registrationNumberMeta));
    } else if (isInserting) {
      context.missing(_registrationNumberMeta);
    }
    if (data.containsKey('vehicle_type')) {
      context.handle(
          _vehicleTypeMeta,
          vehicleType.isAcceptableOrUnknown(
              data['vehicle_type']!, _vehicleTypeMeta));
    } else if (isInserting) {
      context.missing(_vehicleTypeMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
          _purchaseDateMeta,
          purchaseDate.isAcceptableOrUnknown(
              data['purchase_date']!, _purchaseDateMeta));
    }
    if (data.containsKey('current_odometer_km')) {
      context.handle(
          _currentOdometerKmMeta,
          currentOdometerKm.isAcceptableOrUnknown(
              data['current_odometer_km']!, _currentOdometerKmMeta));
    }
    if (data.containsKey('insurance_expiry')) {
      context.handle(
          _insuranceExpiryMeta,
          insuranceExpiry.isAcceptableOrUnknown(
              data['insurance_expiry']!, _insuranceExpiryMeta));
    } else if (isInserting) {
      context.missing(_insuranceExpiryMeta);
    }
    if (data.containsKey('puc_expiry')) {
      context.handle(_pucExpiryMeta,
          pucExpiry.isAcceptableOrUnknown(data['puc_expiry']!, _pucExpiryMeta));
    } else if (isInserting) {
      context.missing(_pucExpiryMeta);
    }
    if (data.containsKey('registration_expiry')) {
      context.handle(
          _registrationExpiryMeta,
          registrationExpiry.isAcceptableOrUnknown(
              data['registration_expiry']!, _registrationExpiryMeta));
    }
    if (data.containsKey('last_service_date')) {
      context.handle(
          _lastServiceDateMeta,
          lastServiceDate.isAcceptableOrUnknown(
              data['last_service_date']!, _lastServiceDateMeta));
    }
    if (data.containsKey('next_service_date')) {
      context.handle(
          _nextServiceDateMeta,
          nextServiceDate.isAcceptableOrUnknown(
              data['next_service_date']!, _nextServiceDateMeta));
    }
    if (data.containsKey('next_service_odometer_km')) {
      context.handle(
          _nextServiceOdometerKmMeta,
          nextServiceOdometerKm.isAcceptableOrUnknown(
              data['next_service_odometer_km']!, _nextServiceOdometerKmMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      registrationNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}registration_number'])!,
      vehicleType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_type'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model'])!,
      purchaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}purchase_date']),
      currentOdometerKm: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}current_odometer_km'])!,
      insuranceExpiry: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}insurance_expiry'])!,
      pucExpiry: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}puc_expiry'])!,
      registrationExpiry: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}registration_expiry']),
      lastServiceDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_service_date']),
      nextServiceDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_service_date']),
      nextServiceOdometerKm: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}next_service_odometer_km']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final String id;
  final String name;
  final String registrationNumber;
  final String vehicleType;
  final String brand;
  final String model;
  final DateTime? purchaseDate;
  final int currentOdometerKm;
  final DateTime insuranceExpiry;
  final DateTime pucExpiry;
  final DateTime? registrationExpiry;
  final DateTime? lastServiceDate;
  final DateTime? nextServiceDate;
  final int? nextServiceOdometerKm;
  final String? imagePath;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Vehicle(
      {required this.id,
      required this.name,
      required this.registrationNumber,
      required this.vehicleType,
      required this.brand,
      required this.model,
      this.purchaseDate,
      required this.currentOdometerKm,
      required this.insuranceExpiry,
      required this.pucExpiry,
      this.registrationExpiry,
      this.lastServiceDate,
      this.nextServiceDate,
      this.nextServiceOdometerKm,
      this.imagePath,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['registration_number'] = Variable<String>(registrationNumber);
    map['vehicle_type'] = Variable<String>(vehicleType);
    map['brand'] = Variable<String>(brand);
    map['model'] = Variable<String>(model);
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    map['current_odometer_km'] = Variable<int>(currentOdometerKm);
    map['insurance_expiry'] = Variable<DateTime>(insuranceExpiry);
    map['puc_expiry'] = Variable<DateTime>(pucExpiry);
    if (!nullToAbsent || registrationExpiry != null) {
      map['registration_expiry'] = Variable<DateTime>(registrationExpiry);
    }
    if (!nullToAbsent || lastServiceDate != null) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate);
    }
    if (!nullToAbsent || nextServiceDate != null) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate);
    }
    if (!nullToAbsent || nextServiceOdometerKm != null) {
      map['next_service_odometer_km'] = Variable<int>(nextServiceOdometerKm);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      name: Value(name),
      registrationNumber: Value(registrationNumber),
      vehicleType: Value(vehicleType),
      brand: Value(brand),
      model: Value(model),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      currentOdometerKm: Value(currentOdometerKm),
      insuranceExpiry: Value(insuranceExpiry),
      pucExpiry: Value(pucExpiry),
      registrationExpiry: registrationExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationExpiry),
      lastServiceDate: lastServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastServiceDate),
      nextServiceDate: nextServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDate),
      nextServiceOdometerKm: nextServiceOdometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceOdometerKm),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Vehicle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      registrationNumber:
          serializer.fromJson<String>(json['registrationNumber']),
      vehicleType: serializer.fromJson<String>(json['vehicleType']),
      brand: serializer.fromJson<String>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      currentOdometerKm: serializer.fromJson<int>(json['currentOdometerKm']),
      insuranceExpiry: serializer.fromJson<DateTime>(json['insuranceExpiry']),
      pucExpiry: serializer.fromJson<DateTime>(json['pucExpiry']),
      registrationExpiry:
          serializer.fromJson<DateTime?>(json['registrationExpiry']),
      lastServiceDate: serializer.fromJson<DateTime?>(json['lastServiceDate']),
      nextServiceDate: serializer.fromJson<DateTime?>(json['nextServiceDate']),
      nextServiceOdometerKm:
          serializer.fromJson<int?>(json['nextServiceOdometerKm']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'registrationNumber': serializer.toJson<String>(registrationNumber),
      'vehicleType': serializer.toJson<String>(vehicleType),
      'brand': serializer.toJson<String>(brand),
      'model': serializer.toJson<String>(model),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'currentOdometerKm': serializer.toJson<int>(currentOdometerKm),
      'insuranceExpiry': serializer.toJson<DateTime>(insuranceExpiry),
      'pucExpiry': serializer.toJson<DateTime>(pucExpiry),
      'registrationExpiry': serializer.toJson<DateTime?>(registrationExpiry),
      'lastServiceDate': serializer.toJson<DateTime?>(lastServiceDate),
      'nextServiceDate': serializer.toJson<DateTime?>(nextServiceDate),
      'nextServiceOdometerKm': serializer.toJson<int?>(nextServiceOdometerKm),
      'imagePath': serializer.toJson<String?>(imagePath),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Vehicle copyWith(
          {String? id,
          String? name,
          String? registrationNumber,
          String? vehicleType,
          String? brand,
          String? model,
          Value<DateTime?> purchaseDate = const Value.absent(),
          int? currentOdometerKm,
          DateTime? insuranceExpiry,
          DateTime? pucExpiry,
          Value<DateTime?> registrationExpiry = const Value.absent(),
          Value<DateTime?> lastServiceDate = const Value.absent(),
          Value<DateTime?> nextServiceDate = const Value.absent(),
          Value<int?> nextServiceOdometerKm = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Vehicle(
        id: id ?? this.id,
        name: name ?? this.name,
        registrationNumber: registrationNumber ?? this.registrationNumber,
        vehicleType: vehicleType ?? this.vehicleType,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        purchaseDate:
            purchaseDate.present ? purchaseDate.value : this.purchaseDate,
        currentOdometerKm: currentOdometerKm ?? this.currentOdometerKm,
        insuranceExpiry: insuranceExpiry ?? this.insuranceExpiry,
        pucExpiry: pucExpiry ?? this.pucExpiry,
        registrationExpiry: registrationExpiry.present
            ? registrationExpiry.value
            : this.registrationExpiry,
        lastServiceDate: lastServiceDate.present
            ? lastServiceDate.value
            : this.lastServiceDate,
        nextServiceDate: nextServiceDate.present
            ? nextServiceDate.value
            : this.nextServiceDate,
        nextServiceOdometerKm: nextServiceOdometerKm.present
            ? nextServiceOdometerKm.value
            : this.nextServiceOdometerKm,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      registrationNumber: data.registrationNumber.present
          ? data.registrationNumber.value
          : this.registrationNumber,
      vehicleType:
          data.vehicleType.present ? data.vehicleType.value : this.vehicleType,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      currentOdometerKm: data.currentOdometerKm.present
          ? data.currentOdometerKm.value
          : this.currentOdometerKm,
      insuranceExpiry: data.insuranceExpiry.present
          ? data.insuranceExpiry.value
          : this.insuranceExpiry,
      pucExpiry: data.pucExpiry.present ? data.pucExpiry.value : this.pucExpiry,
      registrationExpiry: data.registrationExpiry.present
          ? data.registrationExpiry.value
          : this.registrationExpiry,
      lastServiceDate: data.lastServiceDate.present
          ? data.lastServiceDate.value
          : this.lastServiceDate,
      nextServiceDate: data.nextServiceDate.present
          ? data.nextServiceDate.value
          : this.nextServiceDate,
      nextServiceOdometerKm: data.nextServiceOdometerKm.present
          ? data.nextServiceOdometerKm.value
          : this.nextServiceOdometerKm,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('currentOdometerKm: $currentOdometerKm, ')
          ..write('insuranceExpiry: $insuranceExpiry, ')
          ..write('pucExpiry: $pucExpiry, ')
          ..write('registrationExpiry: $registrationExpiry, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('nextServiceOdometerKm: $nextServiceOdometerKm, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      registrationNumber,
      vehicleType,
      brand,
      model,
      purchaseDate,
      currentOdometerKm,
      insuranceExpiry,
      pucExpiry,
      registrationExpiry,
      lastServiceDate,
      nextServiceDate,
      nextServiceOdometerKm,
      imagePath,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.name == this.name &&
          other.registrationNumber == this.registrationNumber &&
          other.vehicleType == this.vehicleType &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.purchaseDate == this.purchaseDate &&
          other.currentOdometerKm == this.currentOdometerKm &&
          other.insuranceExpiry == this.insuranceExpiry &&
          other.pucExpiry == this.pucExpiry &&
          other.registrationExpiry == this.registrationExpiry &&
          other.lastServiceDate == this.lastServiceDate &&
          other.nextServiceDate == this.nextServiceDate &&
          other.nextServiceOdometerKm == this.nextServiceOdometerKm &&
          other.imagePath == this.imagePath &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> registrationNumber;
  final Value<String> vehicleType;
  final Value<String> brand;
  final Value<String> model;
  final Value<DateTime?> purchaseDate;
  final Value<int> currentOdometerKm;
  final Value<DateTime> insuranceExpiry;
  final Value<DateTime> pucExpiry;
  final Value<DateTime?> registrationExpiry;
  final Value<DateTime?> lastServiceDate;
  final Value<DateTime?> nextServiceDate;
  final Value<int?> nextServiceOdometerKm;
  final Value<String?> imagePath;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.currentOdometerKm = const Value.absent(),
    this.insuranceExpiry = const Value.absent(),
    this.pucExpiry = const Value.absent(),
    this.registrationExpiry = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.nextServiceOdometerKm = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    required String id,
    required String name,
    required String registrationNumber,
    required String vehicleType,
    required String brand,
    required String model,
    this.purchaseDate = const Value.absent(),
    this.currentOdometerKm = const Value.absent(),
    required DateTime insuranceExpiry,
    required DateTime pucExpiry,
    this.registrationExpiry = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.nextServiceOdometerKm = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        registrationNumber = Value(registrationNumber),
        vehicleType = Value(vehicleType),
        brand = Value(brand),
        model = Value(model),
        insuranceExpiry = Value(insuranceExpiry),
        pucExpiry = Value(pucExpiry),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Vehicle> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? registrationNumber,
    Expression<String>? vehicleType,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<DateTime>? purchaseDate,
    Expression<int>? currentOdometerKm,
    Expression<DateTime>? insuranceExpiry,
    Expression<DateTime>? pucExpiry,
    Expression<DateTime>? registrationExpiry,
    Expression<DateTime>? lastServiceDate,
    Expression<DateTime>? nextServiceDate,
    Expression<int>? nextServiceOdometerKm,
    Expression<String>? imagePath,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (registrationNumber != null) 'registration_number': registrationNumber,
      if (vehicleType != null) 'vehicle_type': vehicleType,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (currentOdometerKm != null) 'current_odometer_km': currentOdometerKm,
      if (insuranceExpiry != null) 'insurance_expiry': insuranceExpiry,
      if (pucExpiry != null) 'puc_expiry': pucExpiry,
      if (registrationExpiry != null) 'registration_expiry': registrationExpiry,
      if (lastServiceDate != null) 'last_service_date': lastServiceDate,
      if (nextServiceDate != null) 'next_service_date': nextServiceDate,
      if (nextServiceOdometerKm != null)
        'next_service_odometer_km': nextServiceOdometerKm,
      if (imagePath != null) 'image_path': imagePath,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? registrationNumber,
      Value<String>? vehicleType,
      Value<String>? brand,
      Value<String>? model,
      Value<DateTime?>? purchaseDate,
      Value<int>? currentOdometerKm,
      Value<DateTime>? insuranceExpiry,
      Value<DateTime>? pucExpiry,
      Value<DateTime?>? registrationExpiry,
      Value<DateTime?>? lastServiceDate,
      Value<DateTime?>? nextServiceDate,
      Value<int?>? nextServiceOdometerKm,
      Value<String?>? imagePath,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return VehiclesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      vehicleType: vehicleType ?? this.vehicleType,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      currentOdometerKm: currentOdometerKm ?? this.currentOdometerKm,
      insuranceExpiry: insuranceExpiry ?? this.insuranceExpiry,
      pucExpiry: pucExpiry ?? this.pucExpiry,
      registrationExpiry: registrationExpiry ?? this.registrationExpiry,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      nextServiceOdometerKm:
          nextServiceOdometerKm ?? this.nextServiceOdometerKm,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (registrationNumber.present) {
      map['registration_number'] = Variable<String>(registrationNumber.value);
    }
    if (vehicleType.present) {
      map['vehicle_type'] = Variable<String>(vehicleType.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (currentOdometerKm.present) {
      map['current_odometer_km'] = Variable<int>(currentOdometerKm.value);
    }
    if (insuranceExpiry.present) {
      map['insurance_expiry'] = Variable<DateTime>(insuranceExpiry.value);
    }
    if (pucExpiry.present) {
      map['puc_expiry'] = Variable<DateTime>(pucExpiry.value);
    }
    if (registrationExpiry.present) {
      map['registration_expiry'] = Variable<DateTime>(registrationExpiry.value);
    }
    if (lastServiceDate.present) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate.value);
    }
    if (nextServiceDate.present) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate.value);
    }
    if (nextServiceOdometerKm.present) {
      map['next_service_odometer_km'] =
          Variable<int>(nextServiceOdometerKm.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('currentOdometerKm: $currentOdometerKm, ')
          ..write('insuranceExpiry: $insuranceExpiry, ')
          ..write('pucExpiry: $pucExpiry, ')
          ..write('registrationExpiry: $registrationExpiry, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('nextServiceOdometerKm: $nextServiceOdometerKm, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehicleLogsTable extends VehicleLogs
    with TableInfo<$VehicleLogsTable, VehicleLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vehicleIdMeta =
      const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
      'vehicle_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES vehicles (id)'));
  static const VerificationMeta _logTypeMeta =
      const VerificationMeta('logType');
  @override
  late final GeneratedColumn<String> logType = GeneratedColumn<String>(
      'log_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _odometerKmMeta =
      const VerificationMeta('odometerKm');
  @override
  late final GeneratedColumn<int> odometerKm = GeneratedColumn<int>(
      'odometer_km', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _costPaiseMeta =
      const VerificationMeta('costPaise');
  @override
  late final GeneratedColumn<int> costPaise = GeneratedColumn<int>(
      'cost_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fuelLitresMeta =
      const VerificationMeta('fuelLitres');
  @override
  late final GeneratedColumn<double> fuelLitres = GeneratedColumn<double>(
      'fuel_litres', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _serviceCentreMeta =
      const VerificationMeta('serviceCentre');
  @override
  late final GeneratedColumn<String> serviceCentre = GeneratedColumn<String>(
      'service_centre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receiptAttachmentPathMeta =
      const VerificationMeta('receiptAttachmentPath');
  @override
  late final GeneratedColumn<String> receiptAttachmentPath =
      GeneratedColumn<String>('receipt_attachment_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        vehicleId,
        logType,
        date,
        odometerKm,
        costPaise,
        fuelLitres,
        serviceCentre,
        notes,
        receiptAttachmentPath,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_logs';
  @override
  VerificationContext validateIntegrity(Insertable<VehicleLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('log_type')) {
      context.handle(_logTypeMeta,
          logType.isAcceptableOrUnknown(data['log_type']!, _logTypeMeta));
    } else if (isInserting) {
      context.missing(_logTypeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
          _odometerKmMeta,
          odometerKm.isAcceptableOrUnknown(
              data['odometer_km']!, _odometerKmMeta));
    }
    if (data.containsKey('cost_paise')) {
      context.handle(_costPaiseMeta,
          costPaise.isAcceptableOrUnknown(data['cost_paise']!, _costPaiseMeta));
    } else if (isInserting) {
      context.missing(_costPaiseMeta);
    }
    if (data.containsKey('fuel_litres')) {
      context.handle(
          _fuelLitresMeta,
          fuelLitres.isAcceptableOrUnknown(
              data['fuel_litres']!, _fuelLitresMeta));
    }
    if (data.containsKey('service_centre')) {
      context.handle(
          _serviceCentreMeta,
          serviceCentre.isAcceptableOrUnknown(
              data['service_centre']!, _serviceCentreMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('receipt_attachment_path')) {
      context.handle(
          _receiptAttachmentPathMeta,
          receiptAttachmentPath.isAcceptableOrUnknown(
              data['receipt_attachment_path']!, _receiptAttachmentPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      vehicleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_id'])!,
      logType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}log_type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      odometerKm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}odometer_km']),
      costPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cost_paise'])!,
      fuelLitres: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fuel_litres']),
      serviceCentre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_centre']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      receiptAttachmentPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}receipt_attachment_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $VehicleLogsTable createAlias(String alias) {
    return $VehicleLogsTable(attachedDatabase, alias);
  }
}

class VehicleLog extends DataClass implements Insertable<VehicleLog> {
  final String id;
  final String vehicleId;
  final String logType;
  final DateTime date;
  final int? odometerKm;
  final int costPaise;
  final double? fuelLitres;
  final String? serviceCentre;
  final String? notes;
  final String? receiptAttachmentPath;
  final DateTime createdAt;
  const VehicleLog(
      {required this.id,
      required this.vehicleId,
      required this.logType,
      required this.date,
      this.odometerKm,
      required this.costPaise,
      this.fuelLitres,
      this.serviceCentre,
      this.notes,
      this.receiptAttachmentPath,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['log_type'] = Variable<String>(logType);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || odometerKm != null) {
      map['odometer_km'] = Variable<int>(odometerKm);
    }
    map['cost_paise'] = Variable<int>(costPaise);
    if (!nullToAbsent || fuelLitres != null) {
      map['fuel_litres'] = Variable<double>(fuelLitres);
    }
    if (!nullToAbsent || serviceCentre != null) {
      map['service_centre'] = Variable<String>(serviceCentre);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || receiptAttachmentPath != null) {
      map['receipt_attachment_path'] = Variable<String>(receiptAttachmentPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VehicleLogsCompanion toCompanion(bool nullToAbsent) {
    return VehicleLogsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      logType: Value(logType),
      date: Value(date),
      odometerKm: odometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(odometerKm),
      costPaise: Value(costPaise),
      fuelLitres: fuelLitres == null && nullToAbsent
          ? const Value.absent()
          : Value(fuelLitres),
      serviceCentre: serviceCentre == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceCentre),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      receiptAttachmentPath: receiptAttachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptAttachmentPath),
      createdAt: Value(createdAt),
    );
  }

  factory VehicleLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleLog(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      logType: serializer.fromJson<String>(json['logType']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometerKm: serializer.fromJson<int?>(json['odometerKm']),
      costPaise: serializer.fromJson<int>(json['costPaise']),
      fuelLitres: serializer.fromJson<double?>(json['fuelLitres']),
      serviceCentre: serializer.fromJson<String?>(json['serviceCentre']),
      notes: serializer.fromJson<String?>(json['notes']),
      receiptAttachmentPath:
          serializer.fromJson<String?>(json['receiptAttachmentPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'logType': serializer.toJson<String>(logType),
      'date': serializer.toJson<DateTime>(date),
      'odometerKm': serializer.toJson<int?>(odometerKm),
      'costPaise': serializer.toJson<int>(costPaise),
      'fuelLitres': serializer.toJson<double?>(fuelLitres),
      'serviceCentre': serializer.toJson<String?>(serviceCentre),
      'notes': serializer.toJson<String?>(notes),
      'receiptAttachmentPath':
          serializer.toJson<String?>(receiptAttachmentPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VehicleLog copyWith(
          {String? id,
          String? vehicleId,
          String? logType,
          DateTime? date,
          Value<int?> odometerKm = const Value.absent(),
          int? costPaise,
          Value<double?> fuelLitres = const Value.absent(),
          Value<String?> serviceCentre = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> receiptAttachmentPath = const Value.absent(),
          DateTime? createdAt}) =>
      VehicleLog(
        id: id ?? this.id,
        vehicleId: vehicleId ?? this.vehicleId,
        logType: logType ?? this.logType,
        date: date ?? this.date,
        odometerKm: odometerKm.present ? odometerKm.value : this.odometerKm,
        costPaise: costPaise ?? this.costPaise,
        fuelLitres: fuelLitres.present ? fuelLitres.value : this.fuelLitres,
        serviceCentre:
            serviceCentre.present ? serviceCentre.value : this.serviceCentre,
        notes: notes.present ? notes.value : this.notes,
        receiptAttachmentPath: receiptAttachmentPath.present
            ? receiptAttachmentPath.value
            : this.receiptAttachmentPath,
        createdAt: createdAt ?? this.createdAt,
      );
  VehicleLog copyWithCompanion(VehicleLogsCompanion data) {
    return VehicleLog(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      logType: data.logType.present ? data.logType.value : this.logType,
      date: data.date.present ? data.date.value : this.date,
      odometerKm:
          data.odometerKm.present ? data.odometerKm.value : this.odometerKm,
      costPaise: data.costPaise.present ? data.costPaise.value : this.costPaise,
      fuelLitres:
          data.fuelLitres.present ? data.fuelLitres.value : this.fuelLitres,
      serviceCentre: data.serviceCentre.present
          ? data.serviceCentre.value
          : this.serviceCentre,
      notes: data.notes.present ? data.notes.value : this.notes,
      receiptAttachmentPath: data.receiptAttachmentPath.present
          ? data.receiptAttachmentPath.value
          : this.receiptAttachmentPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleLog(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('logType: $logType, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('costPaise: $costPaise, ')
          ..write('fuelLitres: $fuelLitres, ')
          ..write('serviceCentre: $serviceCentre, ')
          ..write('notes: $notes, ')
          ..write('receiptAttachmentPath: $receiptAttachmentPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      vehicleId,
      logType,
      date,
      odometerKm,
      costPaise,
      fuelLitres,
      serviceCentre,
      notes,
      receiptAttachmentPath,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleLog &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.logType == this.logType &&
          other.date == this.date &&
          other.odometerKm == this.odometerKm &&
          other.costPaise == this.costPaise &&
          other.fuelLitres == this.fuelLitres &&
          other.serviceCentre == this.serviceCentre &&
          other.notes == this.notes &&
          other.receiptAttachmentPath == this.receiptAttachmentPath &&
          other.createdAt == this.createdAt);
}

class VehicleLogsCompanion extends UpdateCompanion<VehicleLog> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> logType;
  final Value<DateTime> date;
  final Value<int?> odometerKm;
  final Value<int> costPaise;
  final Value<double?> fuelLitres;
  final Value<String?> serviceCentre;
  final Value<String?> notes;
  final Value<String?> receiptAttachmentPath;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const VehicleLogsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.logType = const Value.absent(),
    this.date = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.costPaise = const Value.absent(),
    this.fuelLitres = const Value.absent(),
    this.serviceCentre = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptAttachmentPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehicleLogsCompanion.insert({
    required String id,
    required String vehicleId,
    required String logType,
    required DateTime date,
    this.odometerKm = const Value.absent(),
    required int costPaise,
    this.fuelLitres = const Value.absent(),
    this.serviceCentre = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptAttachmentPath = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        vehicleId = Value(vehicleId),
        logType = Value(logType),
        date = Value(date),
        costPaise = Value(costPaise),
        createdAt = Value(createdAt);
  static Insertable<VehicleLog> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? logType,
    Expression<DateTime>? date,
    Expression<int>? odometerKm,
    Expression<int>? costPaise,
    Expression<double>? fuelLitres,
    Expression<String>? serviceCentre,
    Expression<String>? notes,
    Expression<String>? receiptAttachmentPath,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (logType != null) 'log_type': logType,
      if (date != null) 'date': date,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (costPaise != null) 'cost_paise': costPaise,
      if (fuelLitres != null) 'fuel_litres': fuelLitres,
      if (serviceCentre != null) 'service_centre': serviceCentre,
      if (notes != null) 'notes': notes,
      if (receiptAttachmentPath != null)
        'receipt_attachment_path': receiptAttachmentPath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehicleLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? vehicleId,
      Value<String>? logType,
      Value<DateTime>? date,
      Value<int?>? odometerKm,
      Value<int>? costPaise,
      Value<double?>? fuelLitres,
      Value<String?>? serviceCentre,
      Value<String?>? notes,
      Value<String?>? receiptAttachmentPath,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return VehicleLogsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      logType: logType ?? this.logType,
      date: date ?? this.date,
      odometerKm: odometerKm ?? this.odometerKm,
      costPaise: costPaise ?? this.costPaise,
      fuelLitres: fuelLitres ?? this.fuelLitres,
      serviceCentre: serviceCentre ?? this.serviceCentre,
      notes: notes ?? this.notes,
      receiptAttachmentPath:
          receiptAttachmentPath ?? this.receiptAttachmentPath,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (logType.present) {
      map['log_type'] = Variable<String>(logType.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<int>(odometerKm.value);
    }
    if (costPaise.present) {
      map['cost_paise'] = Variable<int>(costPaise.value);
    }
    if (fuelLitres.present) {
      map['fuel_litres'] = Variable<double>(fuelLitres.value);
    }
    if (serviceCentre.present) {
      map['service_centre'] = Variable<String>(serviceCentre.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (receiptAttachmentPath.present) {
      map['receipt_attachment_path'] =
          Variable<String>(receiptAttachmentPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleLogsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('logType: $logType, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('costPaise: $costPaise, ')
          ..write('fuelLitres: $fuelLitres, ')
          ..write('serviceCentre: $serviceCentre, ')
          ..write('notes: $notes, ')
          ..write('receiptAttachmentPath: $receiptAttachmentPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 250),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
      'event_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('custom'));
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _snoozedUntilMeta =
      const VerificationMeta('snoozedUntil');
  @override
  late final GeneratedColumn<DateTime> snoozedUntil = GeneratedColumn<DateTime>(
      'snoozed_until', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _relatedEntityIdMeta =
      const VerificationMeta('relatedEntityId');
  @override
  late final GeneratedColumn<String> relatedEntityId = GeneratedColumn<String>(
      'related_entity_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _relatedEntityTypeMeta =
      const VerificationMeta('relatedEntityType');
  @override
  late final GeneratedColumn<String> relatedEntityType =
      GeneratedColumn<String>('related_entity_type', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notificationIdMeta =
      const VerificationMeta('notificationId');
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
      'notification_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        eventType,
        dueDate,
        priority,
        isCompleted,
        completedAt,
        snoozedUntil,
        relatedEntityId,
        relatedEntityType,
        notes,
        notificationId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(Insertable<Reminder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('snoozed_until')) {
      context.handle(
          _snoozedUntilMeta,
          snoozedUntil.isAcceptableOrUnknown(
              data['snoozed_until']!, _snoozedUntilMeta));
    }
    if (data.containsKey('related_entity_id')) {
      context.handle(
          _relatedEntityIdMeta,
          relatedEntityId.isAcceptableOrUnknown(
              data['related_entity_id']!, _relatedEntityIdMeta));
    }
    if (data.containsKey('related_entity_type')) {
      context.handle(
          _relatedEntityTypeMeta,
          relatedEntityType.isAcceptableOrUnknown(
              data['related_entity_type']!, _relatedEntityTypeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('notification_id')) {
      context.handle(
          _notificationIdMeta,
          notificationId.isAcceptableOrUnknown(
              data['notification_id']!, _notificationIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      eventType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      snoozedUntil: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}snoozed_until']),
      relatedEntityId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}related_entity_id']),
      relatedEntityType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}related_entity_type']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      notificationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}notification_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final String title;
  final String eventType;
  final DateTime dueDate;
  final String priority;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime? snoozedUntil;
  final String? relatedEntityId;
  final String? relatedEntityType;
  final String? notes;
  final int? notificationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Reminder(
      {required this.id,
      required this.title,
      required this.eventType,
      required this.dueDate,
      required this.priority,
      required this.isCompleted,
      this.completedAt,
      this.snoozedUntil,
      this.relatedEntityId,
      this.relatedEntityType,
      this.notes,
      this.notificationId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['event_type'] = Variable<String>(eventType);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['priority'] = Variable<String>(priority);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || snoozedUntil != null) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil);
    }
    if (!nullToAbsent || relatedEntityId != null) {
      map['related_entity_id'] = Variable<String>(relatedEntityId);
    }
    if (!nullToAbsent || relatedEntityType != null) {
      map['related_entity_type'] = Variable<String>(relatedEntityType);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || notificationId != null) {
      map['notification_id'] = Variable<int>(notificationId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      title: Value(title),
      eventType: Value(eventType),
      dueDate: Value(dueDate),
      priority: Value(priority),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      snoozedUntil: snoozedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozedUntil),
      relatedEntityId: relatedEntityId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedEntityId),
      relatedEntityType: relatedEntityType == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedEntityType),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      notificationId: notificationId == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      eventType: serializer.fromJson<String>(json['eventType']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      priority: serializer.fromJson<String>(json['priority']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      snoozedUntil: serializer.fromJson<DateTime?>(json['snoozedUntil']),
      relatedEntityId: serializer.fromJson<String?>(json['relatedEntityId']),
      relatedEntityType:
          serializer.fromJson<String?>(json['relatedEntityType']),
      notes: serializer.fromJson<String?>(json['notes']),
      notificationId: serializer.fromJson<int?>(json['notificationId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'eventType': serializer.toJson<String>(eventType),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'priority': serializer.toJson<String>(priority),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'snoozedUntil': serializer.toJson<DateTime?>(snoozedUntil),
      'relatedEntityId': serializer.toJson<String?>(relatedEntityId),
      'relatedEntityType': serializer.toJson<String?>(relatedEntityType),
      'notes': serializer.toJson<String?>(notes),
      'notificationId': serializer.toJson<int?>(notificationId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Reminder copyWith(
          {String? id,
          String? title,
          String? eventType,
          DateTime? dueDate,
          String? priority,
          bool? isCompleted,
          Value<DateTime?> completedAt = const Value.absent(),
          Value<DateTime?> snoozedUntil = const Value.absent(),
          Value<String?> relatedEntityId = const Value.absent(),
          Value<String?> relatedEntityType = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<int?> notificationId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Reminder(
        id: id ?? this.id,
        title: title ?? this.title,
        eventType: eventType ?? this.eventType,
        dueDate: dueDate ?? this.dueDate,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        snoozedUntil:
            snoozedUntil.present ? snoozedUntil.value : this.snoozedUntil,
        relatedEntityId: relatedEntityId.present
            ? relatedEntityId.value
            : this.relatedEntityId,
        relatedEntityType: relatedEntityType.present
            ? relatedEntityType.value
            : this.relatedEntityType,
        notes: notes.present ? notes.value : this.notes,
        notificationId:
            notificationId.present ? notificationId.value : this.notificationId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      snoozedUntil: data.snoozedUntil.present
          ? data.snoozedUntil.value
          : this.snoozedUntil,
      relatedEntityId: data.relatedEntityId.present
          ? data.relatedEntityId.value
          : this.relatedEntityId,
      relatedEntityType: data.relatedEntityType.present
          ? data.relatedEntityType.value
          : this.relatedEntityType,
      notes: data.notes.present ? data.notes.value : this.notes,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('eventType: $eventType, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('relatedEntityId: $relatedEntityId, ')
          ..write('relatedEntityType: $relatedEntityType, ')
          ..write('notes: $notes, ')
          ..write('notificationId: $notificationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      eventType,
      dueDate,
      priority,
      isCompleted,
      completedAt,
      snoozedUntil,
      relatedEntityId,
      relatedEntityType,
      notes,
      notificationId,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.title == this.title &&
          other.eventType == this.eventType &&
          other.dueDate == this.dueDate &&
          other.priority == this.priority &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.snoozedUntil == this.snoozedUntil &&
          other.relatedEntityId == this.relatedEntityId &&
          other.relatedEntityType == this.relatedEntityType &&
          other.notes == this.notes &&
          other.notificationId == this.notificationId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> eventType;
  final Value<DateTime> dueDate;
  final Value<String> priority;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> snoozedUntil;
  final Value<String?> relatedEntityId;
  final Value<String?> relatedEntityType;
  final Value<String?> notes;
  final Value<int?> notificationId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.eventType = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.relatedEntityId = const Value.absent(),
    this.relatedEntityType = const Value.absent(),
    this.notes = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String title,
    this.eventType = const Value.absent(),
    required DateTime dueDate,
    this.priority = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.relatedEntityId = const Value.absent(),
    this.relatedEntityType = const Value.absent(),
    this.notes = const Value.absent(),
    this.notificationId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        dueDate = Value(dueDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? eventType,
    Expression<DateTime>? dueDate,
    Expression<String>? priority,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? snoozedUntil,
    Expression<String>? relatedEntityId,
    Expression<String>? relatedEntityType,
    Expression<String>? notes,
    Expression<int>? notificationId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (eventType != null) 'event_type': eventType,
      if (dueDate != null) 'due_date': dueDate,
      if (priority != null) 'priority': priority,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (snoozedUntil != null) 'snoozed_until': snoozedUntil,
      if (relatedEntityId != null) 'related_entity_id': relatedEntityId,
      if (relatedEntityType != null) 'related_entity_type': relatedEntityType,
      if (notes != null) 'notes': notes,
      if (notificationId != null) 'notification_id': notificationId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? eventType,
      Value<DateTime>? dueDate,
      Value<String>? priority,
      Value<bool>? isCompleted,
      Value<DateTime?>? completedAt,
      Value<DateTime?>? snoozedUntil,
      Value<String?>? relatedEntityId,
      Value<String?>? relatedEntityType,
      Value<String?>? notes,
      Value<int?>? notificationId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return RemindersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      eventType: eventType ?? this.eventType,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      relatedEntityType: relatedEntityType ?? this.relatedEntityType,
      notes: notes ?? this.notes,
      notificationId: notificationId ?? this.notificationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (snoozedUntil.present) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil.value);
    }
    if (relatedEntityId.present) {
      map['related_entity_id'] = Variable<String>(relatedEntityId.value);
    }
    if (relatedEntityType.present) {
      map['related_entity_type'] = Variable<String>(relatedEntityType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('eventType: $eventType, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('relatedEntityId: $relatedEntityId, ')
          ..write('relatedEntityType: $relatedEntityType, ')
          ..write('notes: $notes, ')
          ..write('notificationId: $notificationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountPaiseMeta =
      const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
      'amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('UPI'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedEntityIdMeta =
      const VerificationMeta('linkedEntityId');
  @override
  late final GeneratedColumn<String> linkedEntityId = GeneratedColumn<String>(
      'linked_entity_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedEntityTypeMeta =
      const VerificationMeta('linkedEntityType');
  @override
  late final GeneratedColumn<String> linkedEntityType = GeneratedColumn<String>(
      'linked_entity_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        category,
        amountPaise,
        date,
        paymentMethod,
        notes,
        linkedEntityId,
        linkedEntityType,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
          _amountPaiseMeta,
          amountPaise.isAcceptableOrUnknown(
              data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('linked_entity_id')) {
      context.handle(
          _linkedEntityIdMeta,
          linkedEntityId.isAcceptableOrUnknown(
              data['linked_entity_id']!, _linkedEntityIdMeta));
    }
    if (data.containsKey('linked_entity_type')) {
      context.handle(
          _linkedEntityTypeMeta,
          linkedEntityType.isAcceptableOrUnknown(
              data['linked_entity_type']!, _linkedEntityTypeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      amountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      linkedEntityId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_entity_id']),
      linkedEntityType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_entity_type']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final String title;
  final String category;
  final int amountPaise;
  final DateTime date;
  final String paymentMethod;
  final String? notes;
  final String? linkedEntityId;
  final String? linkedEntityType;
  final DateTime createdAt;
  const Expense(
      {required this.id,
      required this.title,
      required this.category,
      required this.amountPaise,
      required this.date,
      required this.paymentMethod,
      this.notes,
      this.linkedEntityId,
      this.linkedEntityType,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['amount_paise'] = Variable<int>(amountPaise);
    map['date'] = Variable<DateTime>(date);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || linkedEntityId != null) {
      map['linked_entity_id'] = Variable<String>(linkedEntityId);
    }
    if (!nullToAbsent || linkedEntityType != null) {
      map['linked_entity_type'] = Variable<String>(linkedEntityType);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      amountPaise: Value(amountPaise),
      date: Value(date),
      paymentMethod: Value(paymentMethod),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      linkedEntityId: linkedEntityId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedEntityId),
      linkedEntityType: linkedEntityType == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedEntityType),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      date: serializer.fromJson<DateTime>(json['date']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      linkedEntityId: serializer.fromJson<String?>(json['linkedEntityId']),
      linkedEntityType: serializer.fromJson<String?>(json['linkedEntityType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'date': serializer.toJson<DateTime>(date),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'linkedEntityId': serializer.toJson<String?>(linkedEntityId),
      'linkedEntityType': serializer.toJson<String?>(linkedEntityType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith(
          {String? id,
          String? title,
          String? category,
          int? amountPaise,
          DateTime? date,
          String? paymentMethod,
          Value<String?> notes = const Value.absent(),
          Value<String?> linkedEntityId = const Value.absent(),
          Value<String?> linkedEntityType = const Value.absent(),
          DateTime? createdAt}) =>
      Expense(
        id: id ?? this.id,
        title: title ?? this.title,
        category: category ?? this.category,
        amountPaise: amountPaise ?? this.amountPaise,
        date: date ?? this.date,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        notes: notes.present ? notes.value : this.notes,
        linkedEntityId:
            linkedEntityId.present ? linkedEntityId.value : this.linkedEntityId,
        linkedEntityType: linkedEntityType.present
            ? linkedEntityType.value
            : this.linkedEntityType,
        createdAt: createdAt ?? this.createdAt,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      amountPaise:
          data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      date: data.date.present ? data.date.value : this.date,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      linkedEntityId: data.linkedEntityId.present
          ? data.linkedEntityId.value
          : this.linkedEntityId,
      linkedEntityType: data.linkedEntityType.present
          ? data.linkedEntityType.value
          : this.linkedEntityType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('linkedEntityId: $linkedEntityId, ')
          ..write('linkedEntityType: $linkedEntityType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, category, amountPaise, date,
      paymentMethod, notes, linkedEntityId, linkedEntityType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.amountPaise == this.amountPaise &&
          other.date == this.date &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.linkedEntityId == this.linkedEntityId &&
          other.linkedEntityType == this.linkedEntityType &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> category;
  final Value<int> amountPaise;
  final Value<DateTime> date;
  final Value<String> paymentMethod;
  final Value<String?> notes;
  final Value<String?> linkedEntityId;
  final Value<String?> linkedEntityType;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.date = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.linkedEntityId = const Value.absent(),
    this.linkedEntityType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required String title,
    required String category,
    required int amountPaise,
    required DateTime date,
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.linkedEntityId = const Value.absent(),
    this.linkedEntityType = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        category = Value(category),
        amountPaise = Value(amountPaise),
        date = Value(date),
        createdAt = Value(createdAt);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<int>? amountPaise,
    Expression<DateTime>? date,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<String>? linkedEntityId,
    Expression<String>? linkedEntityType,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (date != null) 'date': date,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (linkedEntityId != null) 'linked_entity_id': linkedEntityId,
      if (linkedEntityType != null) 'linked_entity_type': linkedEntityType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? category,
      Value<int>? amountPaise,
      Value<DateTime>? date,
      Value<String>? paymentMethod,
      Value<String?>? notes,
      Value<String?>? linkedEntityId,
      Value<String?>? linkedEntityType,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      amountPaise: amountPaise ?? this.amountPaise,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      linkedEntityId: linkedEntityId ?? this.linkedEntityId,
      linkedEntityType: linkedEntityType ?? this.linkedEntityType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (linkedEntityId.present) {
      map['linked_entity_id'] = Variable<String>(linkedEntityId.value);
    }
    if (linkedEntityType.present) {
      map['linked_entity_type'] = Variable<String>(linkedEntityType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('linkedEntityId: $linkedEntityId, ')
          ..write('linkedEntityType: $linkedEntityType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, Budget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthlyBudgetPaiseMeta =
      const VerificationMeta('monthlyBudgetPaise');
  @override
  late final GeneratedColumn<int> monthlyBudgetPaise = GeneratedColumn<int>(
      'monthly_budget_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5000000));
  static const VerificationMeta _categoryAllocationsJsonMeta =
      const VerificationMeta('categoryAllocationsJson');
  @override
  late final GeneratedColumn<String> categoryAllocationsJson =
      GeneratedColumn<String>('category_allocations_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, month, year, monthlyBudgetPaise, categoryAllocationsJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(Insertable<Budget> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('monthly_budget_paise')) {
      context.handle(
          _monthlyBudgetPaiseMeta,
          monthlyBudgetPaise.isAcceptableOrUnknown(
              data['monthly_budget_paise']!, _monthlyBudgetPaiseMeta));
    }
    if (data.containsKey('category_allocations_json')) {
      context.handle(
          _categoryAllocationsJsonMeta,
          categoryAllocationsJson.isAcceptableOrUnknown(
              data['category_allocations_json']!,
              _categoryAllocationsJsonMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Budget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Budget(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      monthlyBudgetPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}monthly_budget_paise'])!,
      categoryAllocationsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category_allocations_json']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }
}

class Budget extends DataClass implements Insertable<Budget> {
  final String id;
  final int month;
  final int year;
  final int monthlyBudgetPaise;
  final String? categoryAllocationsJson;
  final DateTime updatedAt;
  const Budget(
      {required this.id,
      required this.month,
      required this.year,
      required this.monthlyBudgetPaise,
      this.categoryAllocationsJson,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['month'] = Variable<int>(month);
    map['year'] = Variable<int>(year);
    map['monthly_budget_paise'] = Variable<int>(monthlyBudgetPaise);
    if (!nullToAbsent || categoryAllocationsJson != null) {
      map['category_allocations_json'] =
          Variable<String>(categoryAllocationsJson);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      month: Value(month),
      year: Value(year),
      monthlyBudgetPaise: Value(monthlyBudgetPaise),
      categoryAllocationsJson: categoryAllocationsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryAllocationsJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory Budget.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Budget(
      id: serializer.fromJson<String>(json['id']),
      month: serializer.fromJson<int>(json['month']),
      year: serializer.fromJson<int>(json['year']),
      monthlyBudgetPaise: serializer.fromJson<int>(json['monthlyBudgetPaise']),
      categoryAllocationsJson:
          serializer.fromJson<String?>(json['categoryAllocationsJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'month': serializer.toJson<int>(month),
      'year': serializer.toJson<int>(year),
      'monthlyBudgetPaise': serializer.toJson<int>(monthlyBudgetPaise),
      'categoryAllocationsJson':
          serializer.toJson<String?>(categoryAllocationsJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Budget copyWith(
          {String? id,
          int? month,
          int? year,
          int? monthlyBudgetPaise,
          Value<String?> categoryAllocationsJson = const Value.absent(),
          DateTime? updatedAt}) =>
      Budget(
        id: id ?? this.id,
        month: month ?? this.month,
        year: year ?? this.year,
        monthlyBudgetPaise: monthlyBudgetPaise ?? this.monthlyBudgetPaise,
        categoryAllocationsJson: categoryAllocationsJson.present
            ? categoryAllocationsJson.value
            : this.categoryAllocationsJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Budget copyWithCompanion(BudgetsCompanion data) {
    return Budget(
      id: data.id.present ? data.id.value : this.id,
      month: data.month.present ? data.month.value : this.month,
      year: data.year.present ? data.year.value : this.year,
      monthlyBudgetPaise: data.monthlyBudgetPaise.present
          ? data.monthlyBudgetPaise.value
          : this.monthlyBudgetPaise,
      categoryAllocationsJson: data.categoryAllocationsJson.present
          ? data.categoryAllocationsJson.value
          : this.categoryAllocationsJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Budget(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('monthlyBudgetPaise: $monthlyBudgetPaise, ')
          ..write('categoryAllocationsJson: $categoryAllocationsJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, month, year, monthlyBudgetPaise, categoryAllocationsJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Budget &&
          other.id == this.id &&
          other.month == this.month &&
          other.year == this.year &&
          other.monthlyBudgetPaise == this.monthlyBudgetPaise &&
          other.categoryAllocationsJson == this.categoryAllocationsJson &&
          other.updatedAt == this.updatedAt);
}

class BudgetsCompanion extends UpdateCompanion<Budget> {
  final Value<String> id;
  final Value<int> month;
  final Value<int> year;
  final Value<int> monthlyBudgetPaise;
  final Value<String?> categoryAllocationsJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.monthlyBudgetPaise = const Value.absent(),
    this.categoryAllocationsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsCompanion.insert({
    required String id,
    required int month,
    required int year,
    this.monthlyBudgetPaise = const Value.absent(),
    this.categoryAllocationsJson = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        month = Value(month),
        year = Value(year),
        updatedAt = Value(updatedAt);
  static Insertable<Budget> custom({
    Expression<String>? id,
    Expression<int>? month,
    Expression<int>? year,
    Expression<int>? monthlyBudgetPaise,
    Expression<String>? categoryAllocationsJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (monthlyBudgetPaise != null)
        'monthly_budget_paise': monthlyBudgetPaise,
      if (categoryAllocationsJson != null)
        'category_allocations_json': categoryAllocationsJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsCompanion copyWith(
      {Value<String>? id,
      Value<int>? month,
      Value<int>? year,
      Value<int>? monthlyBudgetPaise,
      Value<String?>? categoryAllocationsJson,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return BudgetsCompanion(
      id: id ?? this.id,
      month: month ?? this.month,
      year: year ?? this.year,
      monthlyBudgetPaise: monthlyBudgetPaise ?? this.monthlyBudgetPaise,
      categoryAllocationsJson:
          categoryAllocationsJson ?? this.categoryAllocationsJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (monthlyBudgetPaise.present) {
      map['monthly_budget_paise'] = Variable<int>(monthlyBudgetPaise.value);
    }
    if (categoryAllocationsJson.present) {
      map['category_allocations_json'] =
          Variable<String>(categoryAllocationsJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('monthlyBudgetPaise: $monthlyBudgetPaise, ')
          ..write('categoryAllocationsJson: $categoryAllocationsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 250),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localFilePathMeta =
      const VerificationMeta('localFilePath');
  @override
  late final GeneratedColumn<String> localFilePath = GeneratedColumn<String>(
      'local_file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileSizeBytesMeta =
      const VerificationMeta('fileSizeBytes');
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
      'file_size_bytes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedEntityTypeMeta =
      const VerificationMeta('linkedEntityType');
  @override
  late final GeneratedColumn<String> linkedEntityType = GeneratedColumn<String>(
      'linked_entity_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedEntityIdMeta =
      const VerificationMeta('linkedEntityId');
  @override
  late final GeneratedColumn<String> linkedEntityId = GeneratedColumn<String>(
      'linked_entity_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        category,
        localFilePath,
        fileSizeBytes,
        mimeType,
        linkedEntityType,
        linkedEntityId,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(Insertable<Document> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('local_file_path')) {
      context.handle(
          _localFilePathMeta,
          localFilePath.isAcceptableOrUnknown(
              data['local_file_path']!, _localFilePathMeta));
    } else if (isInserting) {
      context.missing(_localFilePathMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
          _fileSizeBytesMeta,
          fileSizeBytes.isAcceptableOrUnknown(
              data['file_size_bytes']!, _fileSizeBytesMeta));
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    }
    if (data.containsKey('linked_entity_type')) {
      context.handle(
          _linkedEntityTypeMeta,
          linkedEntityType.isAcceptableOrUnknown(
              data['linked_entity_type']!, _linkedEntityTypeMeta));
    }
    if (data.containsKey('linked_entity_id')) {
      context.handle(
          _linkedEntityIdMeta,
          linkedEntityId.isAcceptableOrUnknown(
              data['linked_entity_id']!, _linkedEntityIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      localFilePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}local_file_path'])!,
      fileSizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size_bytes']),
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type']),
      linkedEntityType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_entity_type']),
      linkedEntityId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_entity_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final String id;
  final String title;
  final String category;
  final String localFilePath;
  final int? fileSizeBytes;
  final String? mimeType;
  final String? linkedEntityType;
  final String? linkedEntityId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Document(
      {required this.id,
      required this.title,
      required this.category,
      required this.localFilePath,
      this.fileSizeBytes,
      this.mimeType,
      this.linkedEntityType,
      this.linkedEntityId,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['local_file_path'] = Variable<String>(localFilePath);
    if (!nullToAbsent || fileSizeBytes != null) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    }
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || linkedEntityType != null) {
      map['linked_entity_type'] = Variable<String>(linkedEntityType);
    }
    if (!nullToAbsent || linkedEntityId != null) {
      map['linked_entity_id'] = Variable<String>(linkedEntityId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      localFilePath: Value(localFilePath),
      fileSizeBytes: fileSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSizeBytes),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      linkedEntityType: linkedEntityType == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedEntityType),
      linkedEntityId: linkedEntityId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedEntityId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Document.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      localFilePath: serializer.fromJson<String>(json['localFilePath']),
      fileSizeBytes: serializer.fromJson<int?>(json['fileSizeBytes']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      linkedEntityType: serializer.fromJson<String?>(json['linkedEntityType']),
      linkedEntityId: serializer.fromJson<String?>(json['linkedEntityId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'localFilePath': serializer.toJson<String>(localFilePath),
      'fileSizeBytes': serializer.toJson<int?>(fileSizeBytes),
      'mimeType': serializer.toJson<String?>(mimeType),
      'linkedEntityType': serializer.toJson<String?>(linkedEntityType),
      'linkedEntityId': serializer.toJson<String?>(linkedEntityId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Document copyWith(
          {String? id,
          String? title,
          String? category,
          String? localFilePath,
          Value<int?> fileSizeBytes = const Value.absent(),
          Value<String?> mimeType = const Value.absent(),
          Value<String?> linkedEntityType = const Value.absent(),
          Value<String?> linkedEntityId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Document(
        id: id ?? this.id,
        title: title ?? this.title,
        category: category ?? this.category,
        localFilePath: localFilePath ?? this.localFilePath,
        fileSizeBytes:
            fileSizeBytes.present ? fileSizeBytes.value : this.fileSizeBytes,
        mimeType: mimeType.present ? mimeType.value : this.mimeType,
        linkedEntityType: linkedEntityType.present
            ? linkedEntityType.value
            : this.linkedEntityType,
        linkedEntityId:
            linkedEntityId.present ? linkedEntityId.value : this.linkedEntityId,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      localFilePath: data.localFilePath.present
          ? data.localFilePath.value
          : this.localFilePath,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      linkedEntityType: data.linkedEntityType.present
          ? data.linkedEntityType.value
          : this.linkedEntityType,
      linkedEntityId: data.linkedEntityId.present
          ? data.linkedEntityId.value
          : this.linkedEntityId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('mimeType: $mimeType, ')
          ..write('linkedEntityType: $linkedEntityType, ')
          ..write('linkedEntityId: $linkedEntityId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      category,
      localFilePath,
      fileSizeBytes,
      mimeType,
      linkedEntityType,
      linkedEntityId,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.localFilePath == this.localFilePath &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.mimeType == this.mimeType &&
          other.linkedEntityType == this.linkedEntityType &&
          other.linkedEntityId == this.linkedEntityId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> category;
  final Value<String> localFilePath;
  final Value<int?> fileSizeBytes;
  final Value<String?> mimeType;
  final Value<String?> linkedEntityType;
  final Value<String?> linkedEntityId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.localFilePath = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.linkedEntityType = const Value.absent(),
    this.linkedEntityId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    required String title,
    required String category,
    required String localFilePath,
    this.fileSizeBytes = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.linkedEntityType = const Value.absent(),
    this.linkedEntityId = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        category = Value(category),
        localFilePath = Value(localFilePath),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Document> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<String>? localFilePath,
    Expression<int>? fileSizeBytes,
    Expression<String>? mimeType,
    Expression<String>? linkedEntityType,
    Expression<String>? linkedEntityId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (localFilePath != null) 'local_file_path': localFilePath,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (mimeType != null) 'mime_type': mimeType,
      if (linkedEntityType != null) 'linked_entity_type': linkedEntityType,
      if (linkedEntityId != null) 'linked_entity_id': linkedEntityId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? category,
      Value<String>? localFilePath,
      Value<int?>? fileSizeBytes,
      Value<String?>? mimeType,
      Value<String?>? linkedEntityType,
      Value<String?>? linkedEntityId,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return DocumentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      localFilePath: localFilePath ?? this.localFilePath,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      mimeType: mimeType ?? this.mimeType,
      linkedEntityType: linkedEntityType ?? this.linkedEntityType,
      linkedEntityId: linkedEntityId ?? this.linkedEntityId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (localFilePath.present) {
      map['local_file_path'] = Variable<String>(localFilePath.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (linkedEntityType.present) {
      map['linked_entity_type'] = Variable<String>(linkedEntityType.value);
    }
    if (linkedEntityId.present) {
      map['linked_entity_id'] = Variable<String>(linkedEntityId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('mimeType: $mimeType, ')
          ..write('linkedEntityType: $linkedEntityType, ')
          ..write('linkedEntityId: $linkedEntityId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AppSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsTableData extends DataClass
    implements Insertable<AppSettingsTableData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSettingsTableData(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingsTableData copyWith(
          {String? key, String? value, DateTime? updatedAt}) =>
      AppSettingsTableData(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSettingsTableData copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsTableData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        updatedAt = Value(updatedAt);
  static Insertable<AppSettingsTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTableCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AppSettingsTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $InventoryCategoriesTable inventoryCategories =
      $InventoryCategoriesTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $ShoppingItemsTable shoppingItems = $ShoppingItemsTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $BillPaymentsTable billPayments = $BillPaymentsTable(this);
  late final $AssetsTable assets = $AssetsTable(this);
  late final $AssetServicesTable assetServices = $AssetServicesTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $VehicleLogsTable vehicleLogs = $VehicleLogsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $AppSettingsTableTable appSettingsTable =
      $AppSettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        inventoryCategories,
        inventoryItems,
        shoppingItems,
        bills,
        billPayments,
        assets,
        assetServices,
        vehicles,
        vehicleLogs,
        reminders,
        expenses,
        budgets,
        documents,
        appSettingsTable
      ];
}

typedef $$InventoryCategoriesTableCreateCompanionBuilder
    = InventoryCategoriesCompanion Function({
  required String id,
  required String name,
  Value<String?> iconName,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$InventoryCategoriesTableUpdateCompanionBuilder
    = InventoryCategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> iconName,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$InventoryCategoriesTableReferences extends BaseReferences<
    _$AppDatabase, $InventoryCategoriesTable, InventoryCategory> {
  $$InventoryCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InventoryItemsTable, List<InventoryItem>>
      _inventoryItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.inventoryItems,
              aliasName:
                  'inventory_categories__id__inventory_items__category_id');

  $$InventoryItemsTableProcessedTableManager get inventoryItemsRefs {
    final manager = $$InventoryItemsTableTableManager($_db, $_db.inventoryItems)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$InventoryCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryCategoriesTable> {
  $$InventoryCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> inventoryItemsRefs(
      Expression<bool> Function($$InventoryItemsTableFilterComposer f) f) {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.inventoryItems,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InventoryItemsTableFilterComposer(
              $db: $db,
              $table: $db.inventoryItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$InventoryCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryCategoriesTable> {
  $$InventoryCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$InventoryCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryCategoriesTable> {
  $$InventoryCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> inventoryItemsRefs<T extends Object>(
      Expression<T> Function($$InventoryItemsTableAnnotationComposer a) f) {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.inventoryItems,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InventoryItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.inventoryItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$InventoryCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventoryCategoriesTable,
    InventoryCategory,
    $$InventoryCategoriesTableFilterComposer,
    $$InventoryCategoriesTableOrderingComposer,
    $$InventoryCategoriesTableAnnotationComposer,
    $$InventoryCategoriesTableCreateCompanionBuilder,
    $$InventoryCategoriesTableUpdateCompanionBuilder,
    (InventoryCategory, $$InventoryCategoriesTableReferences),
    InventoryCategory,
    PrefetchHooks Function({bool inventoryItemsRefs})> {
  $$InventoryCategoriesTableTableManager(
      _$AppDatabase db, $InventoryCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryCategoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> iconName = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryCategoriesCompanion(
            id: id,
            name: name,
            iconName: iconName,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> iconName = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryCategoriesCompanion.insert(
            id: id,
            name: name,
            iconName: iconName,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$InventoryCategoriesTable, InventoryCategory>(
                        table),
                    $$InventoryCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({inventoryItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (inventoryItemsRefs) db.inventoryItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (inventoryItemsRefs)
                    await $_getPrefetchedDataByColumns<
                            InventoryCategory,
                            $InventoryCategoriesTable,
                            InventoryItem,
                            $InventoryItemsTable>(
                        currentTable: table,
                        referencedTable: $$InventoryCategoriesTableReferences
                            ._inventoryItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$InventoryCategoriesTableReferences(db, table, p0)
                                .inventoryItemsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'category_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$InventoryCategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventoryCategoriesTable,
    InventoryCategory,
    $$InventoryCategoriesTableFilterComposer,
    $$InventoryCategoriesTableOrderingComposer,
    $$InventoryCategoriesTableAnnotationComposer,
    $$InventoryCategoriesTableCreateCompanionBuilder,
    $$InventoryCategoriesTableUpdateCompanionBuilder,
    (InventoryCategory, $$InventoryCategoriesTableReferences),
    InventoryCategory,
    PrefetchHooks Function({bool inventoryItemsRefs})>;
typedef $$InventoryItemsTableCreateCompanionBuilder = InventoryItemsCompanion
    Function({
  required String id,
  required String name,
  required String categoryId,
  Value<String?> brand,
  Value<double> quantity,
  Value<String> unit,
  Value<DateTime?> purchaseDate,
  Value<DateTime?> expiryDate,
  Value<double> minStockThreshold,
  Value<int?> approximatePricePaise,
  Value<String?> storageLocation,
  Value<String?> notes,
  Value<String?> imagePath,
  Value<bool> isConsumed,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$InventoryItemsTableUpdateCompanionBuilder = InventoryItemsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> categoryId,
  Value<String?> brand,
  Value<double> quantity,
  Value<String> unit,
  Value<DateTime?> purchaseDate,
  Value<DateTime?> expiryDate,
  Value<double> minStockThreshold,
  Value<int?> approximatePricePaise,
  Value<String?> storageLocation,
  Value<String?> notes,
  Value<String?> imagePath,
  Value<bool> isConsumed,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$InventoryItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem> {
  $$InventoryItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $InventoryCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .inventoryCategories
      .createAlias('inventory_items__category_id__inventory_categories__id');

  $$InventoryCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager =
        $$InventoryCategoriesTableTableManager($_db, $_db.inventoryCategories)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minStockThreshold => $composableBuilder(
      column: $table.minStockThreshold,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get approximatePricePaise => $composableBuilder(
      column: $table.approximatePricePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isConsumed => $composableBuilder(
      column: $table.isConsumed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$InventoryCategoriesTableFilterComposer get categoryId {
    final $$InventoryCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.inventoryCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InventoryCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.inventoryCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minStockThreshold => $composableBuilder(
      column: $table.minStockThreshold,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get approximatePricePaise => $composableBuilder(
      column: $table.approximatePricePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isConsumed => $composableBuilder(
      column: $table.isConsumed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$InventoryCategoriesTableOrderingComposer get categoryId {
    final $$InventoryCategoriesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.inventoryCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$InventoryCategoriesTableOrderingComposer(
                  $db: $db,
                  $table: $db.inventoryCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => column);

  GeneratedColumn<double> get minStockThreshold => $composableBuilder(
      column: $table.minStockThreshold, builder: (column) => column);

  GeneratedColumn<int> get approximatePricePaise => $composableBuilder(
      column: $table.approximatePricePaise, builder: (column) => column);

  GeneratedColumn<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<bool> get isConsumed => $composableBuilder(
      column: $table.isConsumed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$InventoryCategoriesTableAnnotationComposer get categoryId {
    final $$InventoryCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.inventoryCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$InventoryCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.inventoryCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$InventoryItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventoryItemsTable,
    InventoryItem,
    $$InventoryItemsTableFilterComposer,
    $$InventoryItemsTableOrderingComposer,
    $$InventoryItemsTableAnnotationComposer,
    $$InventoryItemsTableCreateCompanionBuilder,
    $$InventoryItemsTableUpdateCompanionBuilder,
    (InventoryItem, $$InventoryItemsTableReferences),
    InventoryItem,
    PrefetchHooks Function({bool categoryId})> {
  $$InventoryItemsTableTableManager(
      _$AppDatabase db, $InventoryItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            Value<double> minStockThreshold = const Value.absent(),
            Value<int?> approximatePricePaise = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<bool> isConsumed = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryItemsCompanion(
            id: id,
            name: name,
            categoryId: categoryId,
            brand: brand,
            quantity: quantity,
            unit: unit,
            purchaseDate: purchaseDate,
            expiryDate: expiryDate,
            minStockThreshold: minStockThreshold,
            approximatePricePaise: approximatePricePaise,
            storageLocation: storageLocation,
            notes: notes,
            imagePath: imagePath,
            isConsumed: isConsumed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String categoryId,
            Value<String?> brand = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            Value<double> minStockThreshold = const Value.absent(),
            Value<int?> approximatePricePaise = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<bool> isConsumed = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryItemsCompanion.insert(
            id: id,
            name: name,
            categoryId: categoryId,
            brand: brand,
            quantity: quantity,
            unit: unit,
            purchaseDate: purchaseDate,
            expiryDate: expiryDate,
            minStockThreshold: minStockThreshold,
            approximatePricePaise: approximatePricePaise,
            storageLocation: storageLocation,
            notes: notes,
            imagePath: imagePath,
            isConsumed: isConsumed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$InventoryItemsTable, InventoryItem>(table),
                    $$InventoryItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$InventoryItemsTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$InventoryItemsTableReferences._categoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InventoryItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventoryItemsTable,
    InventoryItem,
    $$InventoryItemsTableFilterComposer,
    $$InventoryItemsTableOrderingComposer,
    $$InventoryItemsTableAnnotationComposer,
    $$InventoryItemsTableCreateCompanionBuilder,
    $$InventoryItemsTableUpdateCompanionBuilder,
    (InventoryItem, $$InventoryItemsTableReferences),
    InventoryItem,
    PrefetchHooks Function({bool categoryId})>;
typedef $$ShoppingItemsTableCreateCompanionBuilder = ShoppingItemsCompanion
    Function({
  required String id,
  required String name,
  required String category,
  Value<double> quantity,
  Value<String> unit,
  Value<int?> expectedPricePaise,
  Value<String> priority,
  required DateTime plannedPurchaseDate,
  Value<DateTime?> reminderDateTime,
  Value<String?> notes,
  Value<String> status,
  Value<bool> isConvertedToInventory,
  Value<String?> convertedInventoryItemId,
  Value<DateTime?> purchasedDate,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ShoppingItemsTableUpdateCompanionBuilder = ShoppingItemsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<double> quantity,
  Value<String> unit,
  Value<int?> expectedPricePaise,
  Value<String> priority,
  Value<DateTime> plannedPurchaseDate,
  Value<DateTime?> reminderDateTime,
  Value<String?> notes,
  Value<String> status,
  Value<bool> isConvertedToInventory,
  Value<String?> convertedInventoryItemId,
  Value<DateTime?> purchasedDate,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ShoppingItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get expectedPricePaise => $composableBuilder(
      column: $table.expectedPricePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get plannedPurchaseDate => $composableBuilder(
      column: $table.plannedPurchaseDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reminderDateTime => $composableBuilder(
      column: $table.reminderDateTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isConvertedToInventory => $composableBuilder(
      column: $table.isConvertedToInventory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get convertedInventoryItemId => $composableBuilder(
      column: $table.convertedInventoryItemId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchasedDate => $composableBuilder(
      column: $table.purchasedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ShoppingItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get expectedPricePaise => $composableBuilder(
      column: $table.expectedPricePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get plannedPurchaseDate => $composableBuilder(
      column: $table.plannedPurchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reminderDateTime => $composableBuilder(
      column: $table.reminderDateTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isConvertedToInventory => $composableBuilder(
      column: $table.isConvertedToInventory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get convertedInventoryItemId => $composableBuilder(
      column: $table.convertedInventoryItemId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchasedDate => $composableBuilder(
      column: $table.purchasedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ShoppingItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingItemsTable> {
  $$ShoppingItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get expectedPricePaise => $composableBuilder(
      column: $table.expectedPricePaise, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedPurchaseDate => $composableBuilder(
      column: $table.plannedPurchaseDate, builder: (column) => column);

  GeneratedColumn<DateTime> get reminderDateTime => $composableBuilder(
      column: $table.reminderDateTime, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isConvertedToInventory => $composableBuilder(
      column: $table.isConvertedToInventory, builder: (column) => column);

  GeneratedColumn<String> get convertedInventoryItemId => $composableBuilder(
      column: $table.convertedInventoryItemId, builder: (column) => column);

  GeneratedColumn<DateTime> get purchasedDate => $composableBuilder(
      column: $table.purchasedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShoppingItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ShoppingItemsTable,
    ShoppingItem,
    $$ShoppingItemsTableFilterComposer,
    $$ShoppingItemsTableOrderingComposer,
    $$ShoppingItemsTableAnnotationComposer,
    $$ShoppingItemsTableCreateCompanionBuilder,
    $$ShoppingItemsTableUpdateCompanionBuilder,
    (
      ShoppingItem,
      BaseReferences<_$AppDatabase, $ShoppingItemsTable, ShoppingItem>
    ),
    ShoppingItem,
    PrefetchHooks Function()> {
  $$ShoppingItemsTableTableManager(_$AppDatabase db, $ShoppingItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<int?> expectedPricePaise = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<DateTime> plannedPurchaseDate = const Value.absent(),
            Value<DateTime?> reminderDateTime = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isConvertedToInventory = const Value.absent(),
            Value<String?> convertedInventoryItemId = const Value.absent(),
            Value<DateTime?> purchasedDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShoppingItemsCompanion(
            id: id,
            name: name,
            category: category,
            quantity: quantity,
            unit: unit,
            expectedPricePaise: expectedPricePaise,
            priority: priority,
            plannedPurchaseDate: plannedPurchaseDate,
            reminderDateTime: reminderDateTime,
            notes: notes,
            status: status,
            isConvertedToInventory: isConvertedToInventory,
            convertedInventoryItemId: convertedInventoryItemId,
            purchasedDate: purchasedDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String category,
            Value<double> quantity = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<int?> expectedPricePaise = const Value.absent(),
            Value<String> priority = const Value.absent(),
            required DateTime plannedPurchaseDate,
            Value<DateTime?> reminderDateTime = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isConvertedToInventory = const Value.absent(),
            Value<String?> convertedInventoryItemId = const Value.absent(),
            Value<DateTime?> purchasedDate = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ShoppingItemsCompanion.insert(
            id: id,
            name: name,
            category: category,
            quantity: quantity,
            unit: unit,
            expectedPricePaise: expectedPricePaise,
            priority: priority,
            plannedPurchaseDate: plannedPurchaseDate,
            reminderDateTime: reminderDateTime,
            notes: notes,
            status: status,
            isConvertedToInventory: isConvertedToInventory,
            convertedInventoryItemId: convertedInventoryItemId,
            purchasedDate: purchasedDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ShoppingItemsTable, ShoppingItem>(table),
                    BaseReferences<_$AppDatabase, $ShoppingItemsTable,
                        ShoppingItem>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ShoppingItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ShoppingItemsTable,
    ShoppingItem,
    $$ShoppingItemsTableFilterComposer,
    $$ShoppingItemsTableOrderingComposer,
    $$ShoppingItemsTableAnnotationComposer,
    $$ShoppingItemsTableCreateCompanionBuilder,
    $$ShoppingItemsTableUpdateCompanionBuilder,
    (
      ShoppingItem,
      BaseReferences<_$AppDatabase, $ShoppingItemsTable, ShoppingItem>
    ),
    ShoppingItem,
    PrefetchHooks Function()>;
typedef $$BillsTableCreateCompanionBuilder = BillsCompanion Function({
  required String id,
  required String name,
  required String category,
  required String provider,
  required int expectedAmountPaise,
  required DateTime dueDate,
  Value<String> recurrence,
  Value<int> reminderDaysBefore,
  Value<String> status,
  Value<String?> notes,
  Value<String?> attachmentPath,
  Value<bool> isArchived,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BillsTableUpdateCompanionBuilder = BillsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<String> provider,
  Value<int> expectedAmountPaise,
  Value<DateTime> dueDate,
  Value<String> recurrence,
  Value<int> reminderDaysBefore,
  Value<String> status,
  Value<String?> notes,
  Value<String?> attachmentPath,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$BillsTableReferences
    extends BaseReferences<_$AppDatabase, $BillsTable, Bill> {
  $$BillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BillPaymentsTable, List<BillPayment>>
      _billPaymentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.billPayments,
              aliasName: 'bills__id__bill_payments__bill_id');

  $$BillPaymentsTableProcessedTableManager get billPaymentsRefs {
    final manager = $$BillPaymentsTableTableManager($_db, $_db.billPayments)
        .filter((f) => f.billId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_billPaymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BillsTableFilterComposer extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get provider => $composableBuilder(
      column: $table.provider, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get expectedAmountPaise => $composableBuilder(
      column: $table.expectedAmountPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurrence => $composableBuilder(
      column: $table.recurrence, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderDaysBefore => $composableBuilder(
      column: $table.reminderDaysBefore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attachmentPath => $composableBuilder(
      column: $table.attachmentPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> billPaymentsRefs(
      Expression<bool> Function($$BillPaymentsTableFilterComposer f) f) {
    final $$BillPaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.billPayments,
        getReferencedColumn: (t) => t.billId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BillPaymentsTableFilterComposer(
              $db: $db,
              $table: $db.billPayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BillsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get provider => $composableBuilder(
      column: $table.provider, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get expectedAmountPaise => $composableBuilder(
      column: $table.expectedAmountPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurrence => $composableBuilder(
      column: $table.recurrence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderDaysBefore => $composableBuilder(
      column: $table.reminderDaysBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attachmentPath => $composableBuilder(
      column: $table.attachmentPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<int> get expectedAmountPaise => $composableBuilder(
      column: $table.expectedAmountPaise, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get recurrence => $composableBuilder(
      column: $table.recurrence, builder: (column) => column);

  GeneratedColumn<int> get reminderDaysBefore => $composableBuilder(
      column: $table.reminderDaysBefore, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get attachmentPath => $composableBuilder(
      column: $table.attachmentPath, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> billPaymentsRefs<T extends Object>(
      Expression<T> Function($$BillPaymentsTableAnnotationComposer a) f) {
    final $$BillPaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.billPayments,
        getReferencedColumn: (t) => t.billId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BillPaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.billPayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BillsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BillsTable,
    Bill,
    $$BillsTableFilterComposer,
    $$BillsTableOrderingComposer,
    $$BillsTableAnnotationComposer,
    $$BillsTableCreateCompanionBuilder,
    $$BillsTableUpdateCompanionBuilder,
    (Bill, $$BillsTableReferences),
    Bill,
    PrefetchHooks Function({bool billPaymentsRefs})> {
  $$BillsTableTableManager(_$AppDatabase db, $BillsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> provider = const Value.absent(),
            Value<int> expectedAmountPaise = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<String> recurrence = const Value.absent(),
            Value<int> reminderDaysBefore = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> attachmentPath = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BillsCompanion(
            id: id,
            name: name,
            category: category,
            provider: provider,
            expectedAmountPaise: expectedAmountPaise,
            dueDate: dueDate,
            recurrence: recurrence,
            reminderDaysBefore: reminderDaysBefore,
            status: status,
            notes: notes,
            attachmentPath: attachmentPath,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String category,
            required String provider,
            required int expectedAmountPaise,
            required DateTime dueDate,
            Value<String> recurrence = const Value.absent(),
            Value<int> reminderDaysBefore = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> attachmentPath = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BillsCompanion.insert(
            id: id,
            name: name,
            category: category,
            provider: provider,
            expectedAmountPaise: expectedAmountPaise,
            dueDate: dueDate,
            recurrence: recurrence,
            reminderDaysBefore: reminderDaysBefore,
            status: status,
            notes: notes,
            attachmentPath: attachmentPath,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BillsTable, Bill>(table),
                    $$BillsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({billPaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (billPaymentsRefs) db.billPayments],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (billPaymentsRefs)
                    await $_getPrefetchedDataByColumns<Bill, $BillsTable,
                            BillPayment, $BillPaymentsTable>(
                        currentTable: table,
                        referencedTable:
                            $$BillsTableReferences._billPaymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BillsTableReferences(db, table, p0)
                                .billPaymentsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'bill_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BillsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BillsTable,
    Bill,
    $$BillsTableFilterComposer,
    $$BillsTableOrderingComposer,
    $$BillsTableAnnotationComposer,
    $$BillsTableCreateCompanionBuilder,
    $$BillsTableUpdateCompanionBuilder,
    (Bill, $$BillsTableReferences),
    Bill,
    PrefetchHooks Function({bool billPaymentsRefs})>;
typedef $$BillPaymentsTableCreateCompanionBuilder = BillPaymentsCompanion
    Function({
  required String id,
  required String billId,
  required int paidAmountPaise,
  required DateTime paymentDate,
  Value<String> paymentMethod,
  Value<String?> receiptAttachmentPath,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$BillPaymentsTableUpdateCompanionBuilder = BillPaymentsCompanion
    Function({
  Value<String> id,
  Value<String> billId,
  Value<int> paidAmountPaise,
  Value<DateTime> paymentDate,
  Value<String> paymentMethod,
  Value<String?> receiptAttachmentPath,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$BillPaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $BillPaymentsTable, BillPayment> {
  $$BillPaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BillsTable _billIdTable(_$AppDatabase db) =>
      db.bills.createAlias('bill_payments__bill_id__bills__id');

  $$BillsTableProcessedTableManager get billId {
    final $_column = $_itemColumn<String>('bill_id')!;

    final manager = $$BillsTableTableManager($_db, $_db.bills)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BillPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $BillPaymentsTable> {
  $$BillPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paidAmountPaise => $composableBuilder(
      column: $table.paidAmountPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BillsTableFilterComposer get billId {
    final $$BillsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.billId,
        referencedTable: $db.bills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BillsTableFilterComposer(
              $db: $db,
              $table: $db.bills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BillPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillPaymentsTable> {
  $$BillPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paidAmountPaise => $composableBuilder(
      column: $table.paidAmountPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BillsTableOrderingComposer get billId {
    final $$BillsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.billId,
        referencedTable: $db.bills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BillsTableOrderingComposer(
              $db: $db,
              $table: $db.bills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BillPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillPaymentsTable> {
  $$BillPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get paidAmountPaise => $composableBuilder(
      column: $table.paidAmountPaise, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BillsTableAnnotationComposer get billId {
    final $$BillsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.billId,
        referencedTable: $db.bills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BillsTableAnnotationComposer(
              $db: $db,
              $table: $db.bills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BillPaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BillPaymentsTable,
    BillPayment,
    $$BillPaymentsTableFilterComposer,
    $$BillPaymentsTableOrderingComposer,
    $$BillPaymentsTableAnnotationComposer,
    $$BillPaymentsTableCreateCompanionBuilder,
    $$BillPaymentsTableUpdateCompanionBuilder,
    (BillPayment, $$BillPaymentsTableReferences),
    BillPayment,
    PrefetchHooks Function({bool billId})> {
  $$BillPaymentsTableTableManager(_$AppDatabase db, $BillPaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> billId = const Value.absent(),
            Value<int> paidAmountPaise = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<String?> receiptAttachmentPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BillPaymentsCompanion(
            id: id,
            billId: billId,
            paidAmountPaise: paidAmountPaise,
            paymentDate: paymentDate,
            paymentMethod: paymentMethod,
            receiptAttachmentPath: receiptAttachmentPath,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String billId,
            required int paidAmountPaise,
            required DateTime paymentDate,
            Value<String> paymentMethod = const Value.absent(),
            Value<String?> receiptAttachmentPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BillPaymentsCompanion.insert(
            id: id,
            billId: billId,
            paidAmountPaise: paidAmountPaise,
            paymentDate: paymentDate,
            paymentMethod: paymentMethod,
            receiptAttachmentPath: receiptAttachmentPath,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BillPaymentsTable, BillPayment>(table),
                    $$BillPaymentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({billId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (billId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.billId,
                    referencedTable:
                        $$BillPaymentsTableReferences._billIdTable(db),
                    referencedColumn:
                        $$BillPaymentsTableReferences._billIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BillPaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BillPaymentsTable,
    BillPayment,
    $$BillPaymentsTableFilterComposer,
    $$BillPaymentsTableOrderingComposer,
    $$BillPaymentsTableAnnotationComposer,
    $$BillPaymentsTableCreateCompanionBuilder,
    $$BillPaymentsTableUpdateCompanionBuilder,
    (BillPayment, $$BillPaymentsTableReferences),
    BillPayment,
    PrefetchHooks Function({bool billId})>;
typedef $$AssetsTableCreateCompanionBuilder = AssetsCompanion Function({
  required String id,
  required String name,
  required String category,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> serialNumber,
  required DateTime purchaseDate,
  Value<int?> purchasePricePaise,
  Value<DateTime?> warrantyStartDate,
  required DateTime warrantyExpiryDate,
  Value<String?> seller,
  Value<String?> invoiceAttachmentPath,
  Value<String?> warrantyDocPath,
  Value<String?> imagePath,
  Value<int?> serviceIntervalMonths,
  Value<DateTime?> lastServiceDate,
  Value<DateTime?> nextServiceDate,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AssetsTableUpdateCompanionBuilder = AssetsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> serialNumber,
  Value<DateTime> purchaseDate,
  Value<int?> purchasePricePaise,
  Value<DateTime?> warrantyStartDate,
  Value<DateTime> warrantyExpiryDate,
  Value<String?> seller,
  Value<String?> invoiceAttachmentPath,
  Value<String?> warrantyDocPath,
  Value<String?> imagePath,
  Value<int?> serviceIntervalMonths,
  Value<DateTime?> lastServiceDate,
  Value<DateTime?> nextServiceDate,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$AssetsTableReferences
    extends BaseReferences<_$AppDatabase, $AssetsTable, Asset> {
  $$AssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AssetServicesTable, List<AssetService>>
      _assetServicesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.assetServices,
              aliasName: 'assets__id__asset_services__asset_id');

  $$AssetServicesTableProcessedTableManager get assetServicesRefs {
    final manager = $$AssetServicesTableTableManager($_db, $_db.assetServices)
        .filter((f) => f.assetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_assetServicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AssetsTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get purchasePricePaise => $composableBuilder(
      column: $table.purchasePricePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get warrantyStartDate => $composableBuilder(
      column: $table.warrantyStartDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get warrantyExpiryDate => $composableBuilder(
      column: $table.warrantyExpiryDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get seller => $composableBuilder(
      column: $table.seller, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceAttachmentPath => $composableBuilder(
      column: $table.invoiceAttachmentPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warrantyDocPath => $composableBuilder(
      column: $table.warrantyDocPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get serviceIntervalMonths => $composableBuilder(
      column: $table.serviceIntervalMonths,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastServiceDate => $composableBuilder(
      column: $table.lastServiceDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextServiceDate => $composableBuilder(
      column: $table.nextServiceDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> assetServicesRefs(
      Expression<bool> Function($$AssetServicesTableFilterComposer f) f) {
    final $$AssetServicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assetServices,
        getReferencedColumn: (t) => t.assetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssetServicesTableFilterComposer(
              $db: $db,
              $table: $db.assetServices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get purchasePricePaise => $composableBuilder(
      column: $table.purchasePricePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get warrantyStartDate => $composableBuilder(
      column: $table.warrantyStartDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get warrantyExpiryDate => $composableBuilder(
      column: $table.warrantyExpiryDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get seller => $composableBuilder(
      column: $table.seller, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceAttachmentPath => $composableBuilder(
      column: $table.invoiceAttachmentPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warrantyDocPath => $composableBuilder(
      column: $table.warrantyDocPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get serviceIntervalMonths => $composableBuilder(
      column: $table.serviceIntervalMonths,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastServiceDate => $composableBuilder(
      column: $table.lastServiceDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextServiceDate => $composableBuilder(
      column: $table.nextServiceDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => column);

  GeneratedColumn<int> get purchasePricePaise => $composableBuilder(
      column: $table.purchasePricePaise, builder: (column) => column);

  GeneratedColumn<DateTime> get warrantyStartDate => $composableBuilder(
      column: $table.warrantyStartDate, builder: (column) => column);

  GeneratedColumn<DateTime> get warrantyExpiryDate => $composableBuilder(
      column: $table.warrantyExpiryDate, builder: (column) => column);

  GeneratedColumn<String> get seller =>
      $composableBuilder(column: $table.seller, builder: (column) => column);

  GeneratedColumn<String> get invoiceAttachmentPath => $composableBuilder(
      column: $table.invoiceAttachmentPath, builder: (column) => column);

  GeneratedColumn<String> get warrantyDocPath => $composableBuilder(
      column: $table.warrantyDocPath, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get serviceIntervalMonths => $composableBuilder(
      column: $table.serviceIntervalMonths, builder: (column) => column);

  GeneratedColumn<DateTime> get lastServiceDate => $composableBuilder(
      column: $table.lastServiceDate, builder: (column) => column);

  GeneratedColumn<DateTime> get nextServiceDate => $composableBuilder(
      column: $table.nextServiceDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> assetServicesRefs<T extends Object>(
      Expression<T> Function($$AssetServicesTableAnnotationComposer a) f) {
    final $$AssetServicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assetServices,
        getReferencedColumn: (t) => t.assetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssetServicesTableAnnotationComposer(
              $db: $db,
              $table: $db.assetServices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AssetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssetsTable,
    Asset,
    $$AssetsTableFilterComposer,
    $$AssetsTableOrderingComposer,
    $$AssetsTableAnnotationComposer,
    $$AssetsTableCreateCompanionBuilder,
    $$AssetsTableUpdateCompanionBuilder,
    (Asset, $$AssetsTableReferences),
    Asset,
    PrefetchHooks Function({bool assetServicesRefs})> {
  $$AssetsTableTableManager(_$AppDatabase db, $AssetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> serialNumber = const Value.absent(),
            Value<DateTime> purchaseDate = const Value.absent(),
            Value<int?> purchasePricePaise = const Value.absent(),
            Value<DateTime?> warrantyStartDate = const Value.absent(),
            Value<DateTime> warrantyExpiryDate = const Value.absent(),
            Value<String?> seller = const Value.absent(),
            Value<String?> invoiceAttachmentPath = const Value.absent(),
            Value<String?> warrantyDocPath = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<int?> serviceIntervalMonths = const Value.absent(),
            Value<DateTime?> lastServiceDate = const Value.absent(),
            Value<DateTime?> nextServiceDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetsCompanion(
            id: id,
            name: name,
            category: category,
            brand: brand,
            model: model,
            serialNumber: serialNumber,
            purchaseDate: purchaseDate,
            purchasePricePaise: purchasePricePaise,
            warrantyStartDate: warrantyStartDate,
            warrantyExpiryDate: warrantyExpiryDate,
            seller: seller,
            invoiceAttachmentPath: invoiceAttachmentPath,
            warrantyDocPath: warrantyDocPath,
            imagePath: imagePath,
            serviceIntervalMonths: serviceIntervalMonths,
            lastServiceDate: lastServiceDate,
            nextServiceDate: nextServiceDate,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String category,
            Value<String?> brand = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> serialNumber = const Value.absent(),
            required DateTime purchaseDate,
            Value<int?> purchasePricePaise = const Value.absent(),
            Value<DateTime?> warrantyStartDate = const Value.absent(),
            required DateTime warrantyExpiryDate,
            Value<String?> seller = const Value.absent(),
            Value<String?> invoiceAttachmentPath = const Value.absent(),
            Value<String?> warrantyDocPath = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<int?> serviceIntervalMonths = const Value.absent(),
            Value<DateTime?> lastServiceDate = const Value.absent(),
            Value<DateTime?> nextServiceDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetsCompanion.insert(
            id: id,
            name: name,
            category: category,
            brand: brand,
            model: model,
            serialNumber: serialNumber,
            purchaseDate: purchaseDate,
            purchasePricePaise: purchasePricePaise,
            warrantyStartDate: warrantyStartDate,
            warrantyExpiryDate: warrantyExpiryDate,
            seller: seller,
            invoiceAttachmentPath: invoiceAttachmentPath,
            warrantyDocPath: warrantyDocPath,
            imagePath: imagePath,
            serviceIntervalMonths: serviceIntervalMonths,
            lastServiceDate: lastServiceDate,
            nextServiceDate: nextServiceDate,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AssetsTable, Asset>(table),
                    $$AssetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({assetServicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (assetServicesRefs) db.assetServices
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (assetServicesRefs)
                    await $_getPrefetchedDataByColumns<Asset, $AssetsTable,
                            AssetService, $AssetServicesTable>(
                        currentTable: table,
                        referencedTable:
                            $$AssetsTableReferences._assetServicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AssetsTableReferences(db, table, p0)
                                .assetServicesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'asset_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AssetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssetsTable,
    Asset,
    $$AssetsTableFilterComposer,
    $$AssetsTableOrderingComposer,
    $$AssetsTableAnnotationComposer,
    $$AssetsTableCreateCompanionBuilder,
    $$AssetsTableUpdateCompanionBuilder,
    (Asset, $$AssetsTableReferences),
    Asset,
    PrefetchHooks Function({bool assetServicesRefs})>;
typedef $$AssetServicesTableCreateCompanionBuilder = AssetServicesCompanion
    Function({
  required String id,
  required String assetId,
  required DateTime serviceDate,
  required String serviceType,
  Value<String?> technicianName,
  Value<String?> technicianContact,
  Value<int> costPaise,
  Value<String?> notes,
  Value<String?> receiptAttachmentPath,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AssetServicesTableUpdateCompanionBuilder = AssetServicesCompanion
    Function({
  Value<String> id,
  Value<String> assetId,
  Value<DateTime> serviceDate,
  Value<String> serviceType,
  Value<String?> technicianName,
  Value<String?> technicianContact,
  Value<int> costPaise,
  Value<String?> notes,
  Value<String?> receiptAttachmentPath,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$AssetServicesTableReferences
    extends BaseReferences<_$AppDatabase, $AssetServicesTable, AssetService> {
  $$AssetServicesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AssetsTable _assetIdTable(_$AppDatabase db) =>
      db.assets.createAlias('asset_services__asset_id__assets__id');

  $$AssetsTableProcessedTableManager get assetId {
    final $_column = $_itemColumn<String>('asset_id')!;

    final manager = $$AssetsTableTableManager($_db, $_db.assets)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AssetServicesTableFilterComposer
    extends Composer<_$AppDatabase, $AssetServicesTable> {
  $$AssetServicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get serviceDate => $composableBuilder(
      column: $table.serviceDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get technicianName => $composableBuilder(
      column: $table.technicianName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get technicianContact => $composableBuilder(
      column: $table.technicianContact,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get costPaise => $composableBuilder(
      column: $table.costPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$AssetsTableFilterComposer get assetId {
    final $$AssetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assetId,
        referencedTable: $db.assets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssetsTableFilterComposer(
              $db: $db,
              $table: $db.assets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssetServicesTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetServicesTable> {
  $$AssetServicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get serviceDate => $composableBuilder(
      column: $table.serviceDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get technicianName => $composableBuilder(
      column: $table.technicianName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get technicianContact => $composableBuilder(
      column: $table.technicianContact,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get costPaise => $composableBuilder(
      column: $table.costPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$AssetsTableOrderingComposer get assetId {
    final $$AssetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assetId,
        referencedTable: $db.assets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssetsTableOrderingComposer(
              $db: $db,
              $table: $db.assets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssetServicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetServicesTable> {
  $$AssetServicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get serviceDate => $composableBuilder(
      column: $table.serviceDate, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => column);

  GeneratedColumn<String> get technicianName => $composableBuilder(
      column: $table.technicianName, builder: (column) => column);

  GeneratedColumn<String> get technicianContact => $composableBuilder(
      column: $table.technicianContact, builder: (column) => column);

  GeneratedColumn<int> get costPaise =>
      $composableBuilder(column: $table.costPaise, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AssetsTableAnnotationComposer get assetId {
    final $$AssetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assetId,
        referencedTable: $db.assets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssetsTableAnnotationComposer(
              $db: $db,
              $table: $db.assets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssetServicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssetServicesTable,
    AssetService,
    $$AssetServicesTableFilterComposer,
    $$AssetServicesTableOrderingComposer,
    $$AssetServicesTableAnnotationComposer,
    $$AssetServicesTableCreateCompanionBuilder,
    $$AssetServicesTableUpdateCompanionBuilder,
    (AssetService, $$AssetServicesTableReferences),
    AssetService,
    PrefetchHooks Function({bool assetId})> {
  $$AssetServicesTableTableManager(_$AppDatabase db, $AssetServicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetServicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetServicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetServicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> assetId = const Value.absent(),
            Value<DateTime> serviceDate = const Value.absent(),
            Value<String> serviceType = const Value.absent(),
            Value<String?> technicianName = const Value.absent(),
            Value<String?> technicianContact = const Value.absent(),
            Value<int> costPaise = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> receiptAttachmentPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetServicesCompanion(
            id: id,
            assetId: assetId,
            serviceDate: serviceDate,
            serviceType: serviceType,
            technicianName: technicianName,
            technicianContact: technicianContact,
            costPaise: costPaise,
            notes: notes,
            receiptAttachmentPath: receiptAttachmentPath,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String assetId,
            required DateTime serviceDate,
            required String serviceType,
            Value<String?> technicianName = const Value.absent(),
            Value<String?> technicianContact = const Value.absent(),
            Value<int> costPaise = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> receiptAttachmentPath = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetServicesCompanion.insert(
            id: id,
            assetId: assetId,
            serviceDate: serviceDate,
            serviceType: serviceType,
            technicianName: technicianName,
            technicianContact: technicianContact,
            costPaise: costPaise,
            notes: notes,
            receiptAttachmentPath: receiptAttachmentPath,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AssetServicesTable, AssetService>(table),
                    $$AssetServicesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({assetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (assetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.assetId,
                    referencedTable:
                        $$AssetServicesTableReferences._assetIdTable(db),
                    referencedColumn:
                        $$AssetServicesTableReferences._assetIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AssetServicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssetServicesTable,
    AssetService,
    $$AssetServicesTableFilterComposer,
    $$AssetServicesTableOrderingComposer,
    $$AssetServicesTableAnnotationComposer,
    $$AssetServicesTableCreateCompanionBuilder,
    $$AssetServicesTableUpdateCompanionBuilder,
    (AssetService, $$AssetServicesTableReferences),
    AssetService,
    PrefetchHooks Function({bool assetId})>;
typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  required String id,
  required String name,
  required String registrationNumber,
  required String vehicleType,
  required String brand,
  required String model,
  Value<DateTime?> purchaseDate,
  Value<int> currentOdometerKm,
  required DateTime insuranceExpiry,
  required DateTime pucExpiry,
  Value<DateTime?> registrationExpiry,
  Value<DateTime?> lastServiceDate,
  Value<DateTime?> nextServiceDate,
  Value<int?> nextServiceOdometerKm,
  Value<String?> imagePath,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> registrationNumber,
  Value<String> vehicleType,
  Value<String> brand,
  Value<String> model,
  Value<DateTime?> purchaseDate,
  Value<int> currentOdometerKm,
  Value<DateTime> insuranceExpiry,
  Value<DateTime> pucExpiry,
  Value<DateTime?> registrationExpiry,
  Value<DateTime?> lastServiceDate,
  Value<DateTime?> nextServiceDate,
  Value<int?> nextServiceOdometerKm,
  Value<String?> imagePath,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VehicleLogsTable, List<VehicleLog>>
      _vehicleLogsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.vehicleLogs,
              aliasName: 'vehicles__id__vehicle_logs__vehicle_id');

  $$VehicleLogsTableProcessedTableManager get vehicleLogsRefs {
    final manager = $$VehicleLogsTableTableManager($_db, $_db.vehicleLogs)
        .filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehicleLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vehicleType => $composableBuilder(
      column: $table.vehicleType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentOdometerKm => $composableBuilder(
      column: $table.currentOdometerKm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get insuranceExpiry => $composableBuilder(
      column: $table.insuranceExpiry,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get pucExpiry => $composableBuilder(
      column: $table.pucExpiry, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get registrationExpiry => $composableBuilder(
      column: $table.registrationExpiry,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastServiceDate => $composableBuilder(
      column: $table.lastServiceDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextServiceDate => $composableBuilder(
      column: $table.nextServiceDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nextServiceOdometerKm => $composableBuilder(
      column: $table.nextServiceOdometerKm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> vehicleLogsRefs(
      Expression<bool> Function($$VehicleLogsTableFilterComposer f) f) {
    final $$VehicleLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vehicleLogs,
        getReferencedColumn: (t) => t.vehicleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehicleLogsTableFilterComposer(
              $db: $db,
              $table: $db.vehicleLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vehicleType => $composableBuilder(
      column: $table.vehicleType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentOdometerKm => $composableBuilder(
      column: $table.currentOdometerKm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get insuranceExpiry => $composableBuilder(
      column: $table.insuranceExpiry,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get pucExpiry => $composableBuilder(
      column: $table.pucExpiry, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get registrationExpiry => $composableBuilder(
      column: $table.registrationExpiry,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastServiceDate => $composableBuilder(
      column: $table.lastServiceDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextServiceDate => $composableBuilder(
      column: $table.nextServiceDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nextServiceOdometerKm => $composableBuilder(
      column: $table.nextServiceOdometerKm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber, builder: (column) => column);

  GeneratedColumn<String> get vehicleType => $composableBuilder(
      column: $table.vehicleType, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => column);

  GeneratedColumn<int> get currentOdometerKm => $composableBuilder(
      column: $table.currentOdometerKm, builder: (column) => column);

  GeneratedColumn<DateTime> get insuranceExpiry => $composableBuilder(
      column: $table.insuranceExpiry, builder: (column) => column);

  GeneratedColumn<DateTime> get pucExpiry =>
      $composableBuilder(column: $table.pucExpiry, builder: (column) => column);

  GeneratedColumn<DateTime> get registrationExpiry => $composableBuilder(
      column: $table.registrationExpiry, builder: (column) => column);

  GeneratedColumn<DateTime> get lastServiceDate => $composableBuilder(
      column: $table.lastServiceDate, builder: (column) => column);

  GeneratedColumn<DateTime> get nextServiceDate => $composableBuilder(
      column: $table.nextServiceDate, builder: (column) => column);

  GeneratedColumn<int> get nextServiceOdometerKm => $composableBuilder(
      column: $table.nextServiceOdometerKm, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> vehicleLogsRefs<T extends Object>(
      Expression<T> Function($$VehicleLogsTableAnnotationComposer a) f) {
    final $$VehicleLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vehicleLogs,
        getReferencedColumn: (t) => t.vehicleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehicleLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.vehicleLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehiclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, $$VehiclesTableReferences),
    Vehicle,
    PrefetchHooks Function({bool vehicleLogsRefs})> {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> registrationNumber = const Value.absent(),
            Value<String> vehicleType = const Value.absent(),
            Value<String> brand = const Value.absent(),
            Value<String> model = const Value.absent(),
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<int> currentOdometerKm = const Value.absent(),
            Value<DateTime> insuranceExpiry = const Value.absent(),
            Value<DateTime> pucExpiry = const Value.absent(),
            Value<DateTime?> registrationExpiry = const Value.absent(),
            Value<DateTime?> lastServiceDate = const Value.absent(),
            Value<DateTime?> nextServiceDate = const Value.absent(),
            Value<int?> nextServiceOdometerKm = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesCompanion(
            id: id,
            name: name,
            registrationNumber: registrationNumber,
            vehicleType: vehicleType,
            brand: brand,
            model: model,
            purchaseDate: purchaseDate,
            currentOdometerKm: currentOdometerKm,
            insuranceExpiry: insuranceExpiry,
            pucExpiry: pucExpiry,
            registrationExpiry: registrationExpiry,
            lastServiceDate: lastServiceDate,
            nextServiceDate: nextServiceDate,
            nextServiceOdometerKm: nextServiceOdometerKm,
            imagePath: imagePath,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String registrationNumber,
            required String vehicleType,
            required String brand,
            required String model,
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<int> currentOdometerKm = const Value.absent(),
            required DateTime insuranceExpiry,
            required DateTime pucExpiry,
            Value<DateTime?> registrationExpiry = const Value.absent(),
            Value<DateTime?> lastServiceDate = const Value.absent(),
            Value<DateTime?> nextServiceDate = const Value.absent(),
            Value<int?> nextServiceOdometerKm = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesCompanion.insert(
            id: id,
            name: name,
            registrationNumber: registrationNumber,
            vehicleType: vehicleType,
            brand: brand,
            model: model,
            purchaseDate: purchaseDate,
            currentOdometerKm: currentOdometerKm,
            insuranceExpiry: insuranceExpiry,
            pucExpiry: pucExpiry,
            registrationExpiry: registrationExpiry,
            lastServiceDate: lastServiceDate,
            nextServiceDate: nextServiceDate,
            nextServiceOdometerKm: nextServiceOdometerKm,
            imagePath: imagePath,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$VehiclesTable, Vehicle>(table),
                    $$VehiclesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({vehicleLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (vehicleLogsRefs) db.vehicleLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vehicleLogsRefs)
                    await $_getPrefetchedDataByColumns<Vehicle, $VehiclesTable,
                            VehicleLog, $VehicleLogsTable>(
                        currentTable: table,
                        referencedTable:
                            $$VehiclesTableReferences._vehicleLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VehiclesTableReferences(db, table, p0)
                                .vehicleLogsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'vehicle_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VehiclesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, $$VehiclesTableReferences),
    Vehicle,
    PrefetchHooks Function({bool vehicleLogsRefs})>;
typedef $$VehicleLogsTableCreateCompanionBuilder = VehicleLogsCompanion
    Function({
  required String id,
  required String vehicleId,
  required String logType,
  required DateTime date,
  Value<int?> odometerKm,
  required int costPaise,
  Value<double?> fuelLitres,
  Value<String?> serviceCentre,
  Value<String?> notes,
  Value<String?> receiptAttachmentPath,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$VehicleLogsTableUpdateCompanionBuilder = VehicleLogsCompanion
    Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<String> logType,
  Value<DateTime> date,
  Value<int?> odometerKm,
  Value<int> costPaise,
  Value<double?> fuelLitres,
  Value<String?> serviceCentre,
  Value<String?> notes,
  Value<String?> receiptAttachmentPath,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$VehicleLogsTableReferences
    extends BaseReferences<_$AppDatabase, $VehicleLogsTable, VehicleLog> {
  $$VehicleLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('vehicle_logs__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager($_db, $_db.vehicles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$VehicleLogsTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleLogsTable> {
  $$VehicleLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logType => $composableBuilder(
      column: $table.logType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get odometerKm => $composableBuilder(
      column: $table.odometerKm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get costPaise => $composableBuilder(
      column: $table.costPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fuelLitres => $composableBuilder(
      column: $table.fuelLitres, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceCentre => $composableBuilder(
      column: $table.serviceCentre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleId,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableFilterComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VehicleLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleLogsTable> {
  $$VehicleLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logType => $composableBuilder(
      column: $table.logType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get odometerKm => $composableBuilder(
      column: $table.odometerKm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get costPaise => $composableBuilder(
      column: $table.costPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fuelLitres => $composableBuilder(
      column: $table.fuelLitres, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceCentre => $composableBuilder(
      column: $table.serviceCentre,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleId,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableOrderingComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VehicleLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleLogsTable> {
  $$VehicleLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get logType =>
      $composableBuilder(column: $table.logType, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get odometerKm => $composableBuilder(
      column: $table.odometerKm, builder: (column) => column);

  GeneratedColumn<int> get costPaise =>
      $composableBuilder(column: $table.costPaise, builder: (column) => column);

  GeneratedColumn<double> get fuelLitres => $composableBuilder(
      column: $table.fuelLitres, builder: (column) => column);

  GeneratedColumn<String> get serviceCentre => $composableBuilder(
      column: $table.serviceCentre, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get receiptAttachmentPath => $composableBuilder(
      column: $table.receiptAttachmentPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleId,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableAnnotationComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VehicleLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehicleLogsTable,
    VehicleLog,
    $$VehicleLogsTableFilterComposer,
    $$VehicleLogsTableOrderingComposer,
    $$VehicleLogsTableAnnotationComposer,
    $$VehicleLogsTableCreateCompanionBuilder,
    $$VehicleLogsTableUpdateCompanionBuilder,
    (VehicleLog, $$VehicleLogsTableReferences),
    VehicleLog,
    PrefetchHooks Function({bool vehicleId})> {
  $$VehicleLogsTableTableManager(_$AppDatabase db, $VehicleLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> vehicleId = const Value.absent(),
            Value<String> logType = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int?> odometerKm = const Value.absent(),
            Value<int> costPaise = const Value.absent(),
            Value<double?> fuelLitres = const Value.absent(),
            Value<String?> serviceCentre = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> receiptAttachmentPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VehicleLogsCompanion(
            id: id,
            vehicleId: vehicleId,
            logType: logType,
            date: date,
            odometerKm: odometerKm,
            costPaise: costPaise,
            fuelLitres: fuelLitres,
            serviceCentre: serviceCentre,
            notes: notes,
            receiptAttachmentPath: receiptAttachmentPath,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String vehicleId,
            required String logType,
            required DateTime date,
            Value<int?> odometerKm = const Value.absent(),
            required int costPaise,
            Value<double?> fuelLitres = const Value.absent(),
            Value<String?> serviceCentre = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> receiptAttachmentPath = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              VehicleLogsCompanion.insert(
            id: id,
            vehicleId: vehicleId,
            logType: logType,
            date: date,
            odometerKm: odometerKm,
            costPaise: costPaise,
            fuelLitres: fuelLitres,
            serviceCentre: serviceCentre,
            notes: notes,
            receiptAttachmentPath: receiptAttachmentPath,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$VehicleLogsTable, VehicleLog>(table),
                    $$VehicleLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (vehicleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.vehicleId,
                    referencedTable:
                        $$VehicleLogsTableReferences._vehicleIdTable(db),
                    referencedColumn:
                        $$VehicleLogsTableReferences._vehicleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$VehicleLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VehicleLogsTable,
    VehicleLog,
    $$VehicleLogsTableFilterComposer,
    $$VehicleLogsTableOrderingComposer,
    $$VehicleLogsTableAnnotationComposer,
    $$VehicleLogsTableCreateCompanionBuilder,
    $$VehicleLogsTableUpdateCompanionBuilder,
    (VehicleLog, $$VehicleLogsTableReferences),
    VehicleLog,
    PrefetchHooks Function({bool vehicleId})>;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String title,
  Value<String> eventType,
  required DateTime dueDate,
  Value<String> priority,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<DateTime?> snoozedUntil,
  Value<String?> relatedEntityId,
  Value<String?> relatedEntityType,
  Value<String?> notes,
  Value<int?> notificationId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> eventType,
  Value<DateTime> dueDate,
  Value<String> priority,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<DateTime?> snoozedUntil,
  Value<String?> relatedEntityId,
  Value<String?> relatedEntityType,
  Value<String?> notes,
  Value<int?> notificationId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get snoozedUntil => $composableBuilder(
      column: $table.snoozedUntil, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relatedEntityId => $composableBuilder(
      column: $table.relatedEntityId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relatedEntityType => $composableBuilder(
      column: $table.relatedEntityType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get snoozedUntil => $composableBuilder(
      column: $table.snoozedUntil,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedEntityId => $composableBuilder(
      column: $table.relatedEntityId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedEntityType => $composableBuilder(
      column: $table.relatedEntityType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get snoozedUntil => $composableBuilder(
      column: $table.snoozedUntil, builder: (column) => column);

  GeneratedColumn<String> get relatedEntityId => $composableBuilder(
      column: $table.relatedEntityId, builder: (column) => column);

  GeneratedColumn<String> get relatedEntityType => $composableBuilder(
      column: $table.relatedEntityType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get notificationId => $composableBuilder(
      column: $table.notificationId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RemindersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableAnnotationComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder,
    (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
    Reminder,
    PrefetchHooks Function()> {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> eventType = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime?> snoozedUntil = const Value.absent(),
            Value<String?> relatedEntityId = const Value.absent(),
            Value<String?> relatedEntityType = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int?> notificationId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion(
            id: id,
            title: title,
            eventType: eventType,
            dueDate: dueDate,
            priority: priority,
            isCompleted: isCompleted,
            completedAt: completedAt,
            snoozedUntil: snoozedUntil,
            relatedEntityId: relatedEntityId,
            relatedEntityType: relatedEntityType,
            notes: notes,
            notificationId: notificationId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String> eventType = const Value.absent(),
            required DateTime dueDate,
            Value<String> priority = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime?> snoozedUntil = const Value.absent(),
            Value<String?> relatedEntityId = const Value.absent(),
            Value<String?> relatedEntityType = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int?> notificationId = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion.insert(
            id: id,
            title: title,
            eventType: eventType,
            dueDate: dueDate,
            priority: priority,
            isCompleted: isCompleted,
            completedAt: completedAt,
            snoozedUntil: snoozedUntil,
            relatedEntityId: relatedEntityId,
            relatedEntityType: relatedEntityType,
            notes: notes,
            notificationId: notificationId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RemindersTable, Reminder>(table),
                    BaseReferences<_$AppDatabase, $RemindersTable, Reminder>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RemindersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableAnnotationComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder,
    (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
    Reminder,
    PrefetchHooks Function()>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  required String id,
  required String title,
  required String category,
  required int amountPaise,
  required DateTime date,
  Value<String> paymentMethod,
  Value<String?> notes,
  Value<String?> linkedEntityId,
  Value<String?> linkedEntityType,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> category,
  Value<int> amountPaise,
  Value<DateTime> date,
  Value<String> paymentMethod,
  Value<String?> notes,
  Value<String?> linkedEntityId,
  Value<String?> linkedEntityType,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId, builder: (column) => column);

  GeneratedColumn<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> linkedEntityId = const Value.absent(),
            Value<String?> linkedEntityType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            title: title,
            category: category,
            amountPaise: amountPaise,
            date: date,
            paymentMethod: paymentMethod,
            notes: notes,
            linkedEntityId: linkedEntityId,
            linkedEntityType: linkedEntityType,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String category,
            required int amountPaise,
            required DateTime date,
            Value<String> paymentMethod = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> linkedEntityId = const Value.absent(),
            Value<String?> linkedEntityType = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            title: title,
            category: category,
            amountPaise: amountPaise,
            date: date,
            paymentMethod: paymentMethod,
            notes: notes,
            linkedEntityId: linkedEntityId,
            linkedEntityType: linkedEntityType,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ExpensesTable, Expense>(table),
                    BaseReferences<_$AppDatabase, $ExpensesTable, Expense>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()>;
typedef $$BudgetsTableCreateCompanionBuilder = BudgetsCompanion Function({
  required String id,
  required int month,
  required int year,
  Value<int> monthlyBudgetPaise,
  Value<String?> categoryAllocationsJson,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BudgetsTableUpdateCompanionBuilder = BudgetsCompanion Function({
  Value<String> id,
  Value<int> month,
  Value<int> year,
  Value<int> monthlyBudgetPaise,
  Value<String?> categoryAllocationsJson,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$BudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlyBudgetPaise => $composableBuilder(
      column: $table.monthlyBudgetPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryAllocationsJson => $composableBuilder(
      column: $table.categoryAllocationsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$BudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlyBudgetPaise => $composableBuilder(
      column: $table.monthlyBudgetPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryAllocationsJson => $composableBuilder(
      column: $table.categoryAllocationsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get monthlyBudgetPaise => $composableBuilder(
      column: $table.monthlyBudgetPaise, builder: (column) => column);

  GeneratedColumn<String> get categoryAllocationsJson => $composableBuilder(
      column: $table.categoryAllocationsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BudgetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BudgetsTable,
    Budget,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (Budget, BaseReferences<_$AppDatabase, $BudgetsTable, Budget>),
    Budget,
    PrefetchHooks Function()> {
  $$BudgetsTableTableManager(_$AppDatabase db, $BudgetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<int> monthlyBudgetPaise = const Value.absent(),
            Value<String?> categoryAllocationsJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BudgetsCompanion(
            id: id,
            month: month,
            year: year,
            monthlyBudgetPaise: monthlyBudgetPaise,
            categoryAllocationsJson: categoryAllocationsJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int month,
            required int year,
            Value<int> monthlyBudgetPaise = const Value.absent(),
            Value<String?> categoryAllocationsJson = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BudgetsCompanion.insert(
            id: id,
            month: month,
            year: year,
            monthlyBudgetPaise: monthlyBudgetPaise,
            categoryAllocationsJson: categoryAllocationsJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BudgetsTable, Budget>(table),
                    BaseReferences<_$AppDatabase, $BudgetsTable, Budget>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BudgetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BudgetsTable,
    Budget,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (Budget, BaseReferences<_$AppDatabase, $BudgetsTable, Budget>),
    Budget,
    PrefetchHooks Function()>;
typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  required String id,
  required String title,
  required String category,
  required String localFilePath,
  Value<int?> fileSizeBytes,
  Value<String?> mimeType,
  Value<String?> linkedEntityType,
  Value<String?> linkedEntityId,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> category,
  Value<String> localFilePath,
  Value<int?> fileSizeBytes,
  Value<String?> mimeType,
  Value<String?> linkedEntityType,
  Value<String?> linkedEntityId,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType, builder: (column) => column);

  GeneratedColumn<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DocumentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DocumentsTable,
    Document,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
    Document,
    PrefetchHooks Function()> {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> localFilePath = const Value.absent(),
            Value<int?> fileSizeBytes = const Value.absent(),
            Value<String?> mimeType = const Value.absent(),
            Value<String?> linkedEntityType = const Value.absent(),
            Value<String?> linkedEntityId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DocumentsCompanion(
            id: id,
            title: title,
            category: category,
            localFilePath: localFilePath,
            fileSizeBytes: fileSizeBytes,
            mimeType: mimeType,
            linkedEntityType: linkedEntityType,
            linkedEntityId: linkedEntityId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String category,
            required String localFilePath,
            Value<int?> fileSizeBytes = const Value.absent(),
            Value<String?> mimeType = const Value.absent(),
            Value<String?> linkedEntityType = const Value.absent(),
            Value<String?> linkedEntityId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DocumentsCompanion.insert(
            id: id,
            title: title,
            category: category,
            localFilePath: localFilePath,
            fileSizeBytes: fileSizeBytes,
            mimeType: mimeType,
            linkedEntityType: linkedEntityType,
            linkedEntityId: linkedEntityId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DocumentsTable, Document>(table),
                    BaseReferences<_$AppDatabase, $DocumentsTable, Document>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DocumentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DocumentsTable,
    Document,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
    Document,
    PrefetchHooks Function()>;
typedef $$AppSettingsTableTableCreateCompanionBuilder
    = AppSettingsTableCompanion Function({
  required String key,
  required String value,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AppSettingsTableTableUpdateCompanionBuilder
    = AppSettingsTableCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTableTable,
    AppSettingsTableData,
    $$AppSettingsTableTableFilterComposer,
    $$AppSettingsTableTableOrderingComposer,
    $$AppSettingsTableTableAnnotationComposer,
    $$AppSettingsTableTableCreateCompanionBuilder,
    $$AppSettingsTableTableUpdateCompanionBuilder,
    (
      AppSettingsTableData,
      BaseReferences<_$AppDatabase, $AppSettingsTableTable,
          AppSettingsTableData>
    ),
    AppSettingsTableData,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableTableManager(
      _$AppDatabase db, $AppSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsTableCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsTableCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AppSettingsTableTable, AppSettingsTableData>(
                        table),
                    BaseReferences<_$AppDatabase, $AppSettingsTableTable,
                        AppSettingsTableData>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTableTable,
    AppSettingsTableData,
    $$AppSettingsTableTableFilterComposer,
    $$AppSettingsTableTableOrderingComposer,
    $$AppSettingsTableTableAnnotationComposer,
    $$AppSettingsTableTableCreateCompanionBuilder,
    $$AppSettingsTableTableUpdateCompanionBuilder,
    (
      AppSettingsTableData,
      BaseReferences<_$AppDatabase, $AppSettingsTableTable,
          AppSettingsTableData>
    ),
    AppSettingsTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$InventoryCategoriesTableTableManager get inventoryCategories =>
      $$InventoryCategoriesTableTableManager(_db, _db.inventoryCategories);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$ShoppingItemsTableTableManager get shoppingItems =>
      $$ShoppingItemsTableTableManager(_db, _db.shoppingItems);
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db, _db.bills);
  $$BillPaymentsTableTableManager get billPayments =>
      $$BillPaymentsTableTableManager(_db, _db.billPayments);
  $$AssetsTableTableManager get assets =>
      $$AssetsTableTableManager(_db, _db.assets);
  $$AssetServicesTableTableManager get assetServices =>
      $$AssetServicesTableTableManager(_db, _db.assetServices);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$VehicleLogsTableTableManager get vehicleLogs =>
      $$VehicleLogsTableTableManager(_db, _db.vehicleLogs);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$BudgetsTableTableManager get budgets =>
      $$BudgetsTableTableManager(_db, _db.budgets);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
}
