import 'package:notes/data/app_database.dart';

import '../models/note.dart';
import 'note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final AppDatabase database;

  NoteRepositoryImpl(this.database);

  @override
  Future<void> addNote(Note note) async {
    await database.add(note);
  }

  @override
  List<Note> getNotes() {
    return database.getAll();
  }

  @override
  Future<void> updateNote(Note note) async {
    await database.update(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await database.delete(id);
  }
}