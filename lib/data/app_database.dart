import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class AppDatabase {
  static const String notesBox = 'notes';

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteAdapter());
    }

    await Hive.openBox<Note>(notesBox);
  }

  Box<Note> get box => Hive.box<Note>(notesBox);

  Future<void> add(Note note) async {
    await box.put(note.id, note);
  }

  Future<void> update(Note note) async {
    await box.put(note.id, note);
  }

  Future<void> delete(String id) async {
    await box.delete(id);
  }

  List<Note> getAll() {
    return box.values.toList();
  }
}