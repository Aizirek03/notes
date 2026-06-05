import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'note_details_view_model.dart';

class NoteDetailsScreen
    extends StatefulWidget {

  final Note? note;

  const NoteDetailsScreen({
    super.key,
    this.note,
  });

  @override
  State<NoteDetailsScreen> createState()
      => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState
    extends State<NoteDetailsScreen> {

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text =
          widget.note!.title;

      descriptionController.text =
          widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {

    final vm =
        context.read<NoteDetailsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note == null
              ? 'Новая заметка'
              : 'Редактирование',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(
                labelText: 'Название',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  descriptionController,
              maxLines: 5,
              decoration:
                  const InputDecoration(
                labelText: 'Описание',
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () async {

                final note = Note(
                  id: widget.note?.id ??
                      const Uuid().v4(),
                  title:
                      titleController.text,
                  description:
                      descriptionController.text,
                  createdAt:
                      widget.note?.createdAt ??
                          DateTime.now(),
                );

                if (widget.note == null) {
                  await vm.save(note);
                } else {
                  await vm.update(note);
                }

                Navigator.pop(context);
              },
              child: Text(
                widget.note == null
                    ? 'Сохранить'
                    : 'Сохранить изменения',
              ),
            ),
          ],
        ),
      ),
    );
  }
}