import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_pad_app/note_model.dart';
import 'package:share_plus/share_plus.dart';

class NoteDetails extends StatelessWidget {
  NoteModel note;
  NoteDetails(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.teal,
        title: Text("Note details", style: TextStyle(color: Colors.white)),

        actions: [
          InkWell(onTap: () {}, child: Icon(Icons.favorite)),

          InkWell(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: note.content!));
              Fluttertoast.showToast(msg: "copied to clipboard");
            },

            child: Icon(Icons.copy),
          ),

          InkWell(
            onTap: () {
              Share.share(note.content!, subject: note.title);
            },
            child: Icon(Icons.share, color: Colors.white38),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(note.title!),
              Text(note.date!),
              Text(note.content!),
            ],
          ),
        ),
      ),
    );
  }
}
