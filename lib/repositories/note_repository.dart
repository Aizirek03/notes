import '../models/note.dart';

abstract class NoteRepository {

  Future<void> addNote(Note note);

  List<Note> getNotes();

  Future<void> updateNote(Note note);

  Future<void> deleteNote(String id);
}