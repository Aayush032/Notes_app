

import 'package:flutter/material.dart';
import 'package:notes_app/components/notes_tile.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/pages/new_note_page.dart';
import 'package:notes_app/pages/update_and_view_page.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  
  //tO READ THE NOTES FROM THE DB
  void readNotes(){
    context.watch<NoteDatabase>().readNotes();
  }

  //update the notes
  void updateNotes(Note note){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UpdateAndViewPage(note: note)));
  }


  //Delete the notes
  void deleteNode(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }
  @override
  void initState() {
    super.initState();
    context.read<NoteDatabase>().readNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 30),),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Provider.of<ThemeProvider>(context).isDarkMode?Icons.dark_mode:Icons.light_mode),
                const SizedBox(width: 8,),
                Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value){
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  },
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const NewNotePage()));
          },
          child: Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary, size: 35,),
          ),
      ),

      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context,index){
          final note = currentNotes[index];
          return InkWell(
            onTap: (){
              updateNotes(note);
            },
            child: NotesTile(
              note: note,
              deleteNode: () => deleteNode(note.id),
              )
          );
        }),
    );
  }
}