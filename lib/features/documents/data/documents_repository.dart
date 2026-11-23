import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final documentsRepositoryProvider = Provider<DocumentsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DocumentsRepository(db);
});

class DocumentsRepository {
  final AppDatabase _db;

  DocumentsRepository(this._db);

  Stream<List<Document>> watchAllDocuments() {
    return (_db.select(_db.documents)
          ..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]))
        .watch();
  }

  Stream<List<Document>> watchDocumentsByCategory(String category) {
    return (_db.select(_db.documents)
          ..where((d) => d.category.equals(category))
          ..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<int> insertDocument(DocumentsCompanion doc) {
    return _db.into(_db.documents).insert(doc);
  }

  Future<int> deleteDocument(String id) {
    return (_db.delete(_db.documents)..where((d) => d.id.equals(id))).go();
  }
}
