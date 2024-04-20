import 'package:flutter/material.dart';
import 'package:notes_app/components/custom_textfield.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/theme/bg_provider.dart';
import 'package:provider/provider.dart';

class UpdateAndViewPage extends StatefulWidget {
  final Note note;
  const UpdateAndViewPage({super.key, required this.note});

  @override
  State<UpdateAndViewPage> createState() => _UpdateAndViewPageState();
}

class _UpdateAndViewPageState extends State<UpdateAndViewPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
    //update the notes
  void updateNotes(Note note){
    context.read<NoteDatabase>().updateNotes(note.id, titleController.text, descriptionController.text);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.note.title),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextButton(
              onPressed: () {
                updateNotes(widget.note);
              },
              child: Text("Update", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 18),),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              //Title field
              CustomTextField(
                  descriptionController: titleController, hintText: "Title", maxLines: 1, bgColor: Provider.of<BackgroundProvider>(context).bgColor,),
        
              //Description field
              CustomTextField(
                  descriptionController: descriptionController, hintText: "Description", maxLines: 15,bgColor: Provider.of<BackgroundProvider>(context).bgColor,),
          ],
        ),
      ),
    );
  }
}
