import 'package:flutter/material.dart';

import '../custom_values/custom_colors.dart';
import 'custom_card.dart';

class NameBox extends StatefulWidget {
  bool enabled;
  String habitName;
  bool isImportant;
  IconData icon;

  NameBox({
    this.enabled,
    this.habitName,
    this.isImportant,
    this.icon,
  });

  @override
  _NameBoxState createState() => _NameBoxState();
}

class _NameBoxState extends State<NameBox> {
  final _habitNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    this._habitNameController.text = this.widget.habitName;
  }

  @override
  void dispose() {
    this._habitNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomCard(
      child: TextFormField(
        enabled: this.widget.enabled,
        initialValue: this.widget.habitName,
        controller: this._habitNameController,
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
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
