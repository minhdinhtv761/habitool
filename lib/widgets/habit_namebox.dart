import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../custom_values/custom_colors.dart';
import 'custom_card.dart';
//version: "4.2.0"
class NameBox extends StatefulWidget {
  final bool enabled;
  String habitName;
  bool isImportant;
  IconData icon;
  Function onValueChange;

  NameBox({
    this.enabled,
    this.habitName,
    this.isImportant,
    this.icon,
    this.onValueChange,
  });

  @override
  _NameBoxState createState() => _NameBoxState();
}

class _NameBoxState extends State<NameBox> {
  void _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.fontAwesomeIcons,
        iconColor: CustomColors.black,
        iconSize: 30,
        iconPickerShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('Chọn icon',
            style: TextStyle(
              color: CustomColors.black,
              fontWeight: FontWeight.bold,
            )),
        searchIcon: const Icon(
          Icons.search,
          color: CustomColors.pink,
        ),
        searchHintText: 'Tìm kiếm...',
        closeChild: Text(
          'Hủy',
          style: TextStyle(
            color: CustomColors.pink,
          ),
        ));

    this.widget.icon = icon;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomCard(
      child: TextFormField(
        enabled: this.widget.enabled,
        onChanged: this.widget.onValueChange,
        initialValue: this.widget.habitName,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            color: CustomColors.pink,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Tên thói quen',
          hintStyle: TextStyle(
              color: CustomColors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          prefixIcon: IconButton(
            icon: !this.widget.isImportant
                ? Icon(Icons.star_border)
                : Icon(Icons.star),
            color: !this.widget.isImportant ? CustomColors.grey : Colors.yellow,
            onPressed: () {
              setState(() {
                this.widget.isImportant = !this.widget.isImportant;
              });
            },
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 18),
            child: Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: CustomColors.pink,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: Icon(this.widget.icon),
                  color: CustomColors.pink,
                  onPressed: _pickIcon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
