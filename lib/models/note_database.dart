import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;
  //Initialize
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //List of notes
  final List<Note> currentNotes = [];

  //Create note
  Future<void> addNewNote(String title, String description) async{
    final newNote = Note()
    ..title = title
    ..description = description;

    //save to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    //re-read new database
    readNotes();
  }

  //Read note
  Future<void> readNotes() async{
    List<Note> fetchNote = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNote);
    notifyListeners();
  }

  //Update note
  Future<void> updateNotes(Id id, String newTtile, String newDescription) async{
    final existingNote = await isar.notes.get(id);
    if(existingNote != null){
        existingNote.title = newTtile;
        existingNote.description = newDescription;
        await isar.writeTxn(() => isar.notes.put(existingNote));
        await readNotes();
    }
  }

  //Delete note
  Future<void> deleteNote(Id id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await readNotes();
  }
}