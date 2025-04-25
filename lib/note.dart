import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:note_pad_app/note_Controler.dart';
import 'package:note_pad_app/note_details.dart';
import 'package:note_pad_app/note_model.dart';

class Note extends StatelessWidget {
  Note({super.key});

  NoteControler noteControler = Get.put(NoteControler());

  TextEditingController titleclt = TextEditingController();
  TextEditingController contentclt = TextEditingController();

  final Box box = Hive.box('notes');

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          "Notes",
          style: TextStyle(fontWeight: FontWeight.bold),
          selectionColor: Colors.white,
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, box, child) {
          return GetBuilder<NoteControler>(
            builder: (_) {
              return box.keys.length == 0
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [Icon(Icons.note), Text('Note is empty')],
                    ),
                  )
                  : ListView.separated(
                    itemCount: box.keys.length,
                    separatorBuilder: (content, index) {
                      return Divider(
                        color: Colors.blueGrey,
                        indent: 20,
                        endIndent: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      NoteModel note = box.getAt(index);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.brown,
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        title: Text(note.title.toString()),
                        subtitle: Text(note.content.toString()),
                        trailing: SizedBox(
                          width: 80,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  viewDialouge(context, index);
                                },
                                child: Icon(Icons.edit),
                              ),
                              SizedBox(width: 10.0),
                              InkWell(
                                onTap: () {
                                  noteControler.deleteNote(index);
                                },
                                child: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.to(NoteDetails(note));
                        },
                      );
                    },
                  );
            },
          );
        },
      ),
    );
  }

  viewDialouge(context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: [
                TextField(
                  controller: titleclt,
                  decoration: InputDecoration(hintText: 'Input a title'),
                ),
                TextField(
                  controller: contentclt,
                  decoration: InputDecoration(hintText: 'Input a content'),
                ),
              ],
            ),

            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  if (titleclt.text.isNotEmpty && contentclt.text.isNotEmpty) {
                    DateTime now = DateTime.now();

                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                    NoteModel note = NoteModel(
                      formattedDate,
                      titleclt.text,
                      contentclt.text,
                    );

                    noteControler.updateNote(index, note);
                    Navigator.pop(context);
                  }
                },
                child: Text("update"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancell"),
              ),
            ],
          ),
        );
      },
    );
  }
}
