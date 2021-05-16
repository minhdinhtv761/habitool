import 'package:flutter/material.dart';

import 'package:habitool/src/custom_values/custom_colors.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.light,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          buildSliverAppBar(size),

          // Những SliverToBoxAdapter dưới đây được thêm vào để test scroll màn hình
          SliverToBoxAdapter(
            child: Container(height: 50.0, color: Colors.red)
          ),
          SliverToBoxAdapter(
            child: Container(height: 50.0, color: Colors.pink)
          ),
          SliverToBoxAdapter(
            child: Container(height: 100.0, color: Colors.black)
          ),
          SliverToBoxAdapter(
            child: Container(height: 500.0, color: Colors.green)
          ),
          
          // SliverToBoxAdapter dùng để làm phần trống, tránh việc dữ liệu bị che dưới BottomAppBar
          SliverToBoxAdapter(
            child: Container(height: 100.0, color: Colors.transparent)
          ),
        ],
      ),
    );
  }

// Hàm build AppBar cho DashBoardScreen
  SliverAppBar buildSliverAppBar(Size size) {
    return SliverAppBar(
          pinned: true,
          floating: true,
          snap: false,
          toolbarHeight: 100.0,
          backgroundColor: CustomColors.blue,
          shadowColor: Colors.transparent,
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
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
              height: 100,
              decoration: BoxDecoration(
                color: CustomColors.blue,
              ),
            ),
          ),
          bottom: PreferredSize(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: CustomColors.light,
                  ),
                ),
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: CustomColors.blue,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: size.width * 0.8,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(130.0),
          ),
          
        );
  }
}