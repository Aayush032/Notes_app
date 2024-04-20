import 'package:flutter/material.dart';
import 'package:notes_app/components/color_selector.dart';
import 'package:notes_app/components/custom_textfield.dart';

import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/theme/bg_provider.dart';
import 'package:provider/provider.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  String title = "";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: SizedBox(
          width: 300,
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {
                  //Add to database
                  context.read<NoteDatabase>().addNewNote(
                      titleController.text, descriptionController.text);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title field
            CustomTextField(
              descriptionController: titleController,
              hintText: "Title",
              maxLines: 1,
              bgColor: Provider.of<BackgroundProvider>(context).bgColor,
            ),

            //Description field
            CustomTextField(
              descriptionController: descriptionController,
              hintText: "Description",
              maxLines: 15,
              bgColor: Provider.of<BackgroundProvider>(context).bgColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Choose the background color for the note:",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                    ),
              ),
            ),
            CustomColorSelector(),
          ],
        ),
      ),
    );
  }
}
