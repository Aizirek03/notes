import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notes_view_model.dart';
import '../note_details/note_details_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() =>
      _NotesScreenState();
}

class _NotesScreenState
    extends State<NotesScreen> {


  @override
  Widget build(BuildContext context) {

    final vm =
        context.watch<NotesViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: ListView.builder(
        itemCount: vm.notes.length,
        itemBuilder: (_, index) {

          final note = vm.notes[index];

          return ListTile(
            title: Text(note.title),
            subtitle: Text(
              note.description,
              maxLines: 2,
            ),
            trailing: PopupMenuButton(
              itemBuilder: (_) => [

                PopupMenuItem(
                  child: const Text('Редактировать'),
                  onTap: () {
                    Future.microtask(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              NoteDetailsScreen(
                            note: note,
                          ),
                        ),
                      );
                    });
                  },
                ),

                PopupMenuItem(
                  child: const Text('Удалить'),
                  onTap: () {
                    vm.deleteNote(note.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton:
          FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const NoteDetailsScreen(),
            ),
          );
        },
      ),
    );
  }
}