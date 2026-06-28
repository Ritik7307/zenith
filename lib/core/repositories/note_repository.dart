import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/note.dart';
import '../services/local_db.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return NoteRepository(isar);
});

class NoteRepository {
  final Isar _isar;

  NoteRepository(this._isar);

  Future<void> addNote(String title, String content) async {
    final note = Note()
      ..title = title
      ..content = content
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.notes.put(note);
    });
  }

  Future<void> updateNote(Note note) async {
    note.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.notes.put(note);
    });
  }

  Future<void> deleteNote(int id) async {
    await _isar.writeTxn(() async {
      await _isar.notes.delete(id);
    });
  }

  Stream<List<Note>> watchNotes() {
    return _isar.notes.where().sortByCreatedAtDesc().watch(fireImmediately: true);
  }
}
