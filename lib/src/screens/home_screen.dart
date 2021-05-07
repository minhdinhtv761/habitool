import 'package:flutter/material.dart';

import 'package:habitool/src/custom_values/custom_colors.dart';
import 'package:habitool/src/widgets/date_time_picker.dart';
// import 'package:habitool/src/widgets/datetimpicker_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.light,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            floating: false,
            snap: false,
            toolbarHeight: 100.0,
            backgroundColor: CustomColors.blue,
            title: Row(
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: CustomColors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Xin chào,',
                      style: TextStyle(
                        color: CustomColors.light,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      'Your name',
                      style: TextStyle(
                        color: CustomColors.light,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
          // SliverAppBar(
          //   pinned: true,
          //   floating: false,
          //   snap: false,
          //   toolbarHeight: 130.0,
          //   flexibleSpace: Stack(
          //     children: <Widget>[
          //       Container(
                  
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        child: BottomAppBar(
          notchMargin: 7.0,
          shape: CircularNotchedRectangle(
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_outlined),
                iconSize: 30.0,
                color: CustomColors.darkgrey,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.insert_chart_outlined_rounded),
                iconSize: 30.0,
                color: CustomColors.darkgrey,
                onPressed: () {},
              ),
              SizedBox(width: size.width * 0.1),
              IconButton(
                icon: Icon(Icons.star_border_rounded),
                iconSize: 30.0,
                color: CustomColors.darkgrey,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person_outline_rounded),
                iconSize: 30.0,
                color: CustomColors.darkgrey,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.pink, 
        child: Icon(
          Icons.add,
          size: 45.0,
          color: Colors.white,
          ),
        onPressed: () {},
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}