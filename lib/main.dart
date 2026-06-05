import 'package:flutter/material.dart';
import 'package:notes/data/app_database.dart';
import 'package:notes/note_details/note_details_view_model.dart';
import 'package:notes/notes/notes_screen.dart';
import 'package:notes/notes/notes_view_model.dart';
import 'package:notes/repositories/note_repository_impl.dart';
import 'package:provider/provider.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await database.init();

  final repository =
      NoteRepositoryImpl(database);

  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) =>
              NotesViewModel(repository),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              NoteDetailsViewModel(
            repository,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesScreen(),
    );
  }
}