import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/repositories/note_repository.dart';

class NotesViewModel extends ChangeNotifier {
  final NoteRepository repository;

  NotesViewModel(this.repository);

  List<Note> notes = [];
  List<Note> filteredNotes = [];

  void loadNotes() {
    notes = repository.getNotes();

    notes.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    filteredNotes = List.from(notes);

    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredNotes = List.from(notes);
    } else {
      filteredNotes = notes.where((note) {
        return note.title
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            note.description
                .toLowerCase()
                .contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    await repository.deleteNote(id);
    loadNotes();
  }
}