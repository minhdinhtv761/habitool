import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/widgets/custom_card.dart';

import '../custom_values/custom_colors.dart';

class NoteBox extends StatefulWidget {
  final bool enabled;
  Function onValueChange;
  String note;

  NoteBox({
    @required this.enabled,
    this.onValueChange,
    this.note,
  });

  @override
  _NoteBoxState createState() => _NoteBoxState();
}

class _NoteBoxState extends State<NoteBox> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: TextFormField(
        onChanged: this.widget.onValueChange,
        enabled: this.widget.enabled,
        initialValue: this.widget.note,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
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
