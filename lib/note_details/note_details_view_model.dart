import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/repositories/note_repository.dart';


class NoteDetailsViewModel extends ChangeNotifier {

  final NoteRepository repository;

  NoteDetailsViewModel(this.repository);

  Future<void> save(Note note) async {
    await repository.addNote(note);
  }

  Future<void> update(Note note) async {
    await repository.updateNote(note);
  }
}