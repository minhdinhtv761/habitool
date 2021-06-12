import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/widgets/custom_card.dart';

import '../custom_values/custom_colors.dart';

class NoteBox extends StatefulWidget {
  NoteBox({
    Key key,
    @required this.note,
  });

  String note;

  @override
  _NoteBoxState createState() => _NoteBoxState();
}

class _NoteBoxState extends State<NoteBox> {
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    this._noteController.text = this.widget.note;
  }

  @override
  void dispose() {
    this._noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: TextField(
        controller: this._noteController,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: CustomColors.pink,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Ghi chú',
          hintStyle: TextStyle(
            color: CustomColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            FontAwesomeIcons.stickyNote,
            color: CustomColors.grey,
          ),
        ),
      ),
    );
  }
}
