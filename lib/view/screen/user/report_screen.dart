import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  final UserData currentUser;

  ReportScreen({this.currentUser});

  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: CustomColors.light,
        appBar: AppBar(
          backgroundColor: CustomColors.light,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: CustomColors.black),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            'Báo cáo sự cố',
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'assets/images/trouble.jpg',
              width: 200,
              height: 400,
              fit: BoxFit.contain,
            )
          ],
        )
        // body: CustomScrollView(
        //     physics: BouncingScrollPhysics(),
        //     slivers: <Widget>[
        //       SliverPadding(
        //         padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
        //         sliver: SliverToBoxAdapter(
        //           child: Text(
        //             'Bạn đang gặp sự cố?',
        //             style: TextStyle(
        //               color: CustomColors.pink,
        //               fontSize: 24,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       ),
        //       SliverPadding(
        //         padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
        //         sliver: SliverToBoxAdapter(
        //           child: Text(
        //             'Liên hệ ngay với chúng tôi',
        //             style: TextStyle(
        //               color: CustomColors.pink,
        //               fontSize: 24,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       ),
        //       SliverPadding(
        //         padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
        //         sliver: SliverToBoxAdapter(
        //           child: Text(
        //             'Nguyễn Viết Lưu - 0852585888 - nguyenvietluu@gmail.com',
        //             style: TextStyle(
        //               color: CustomColors.darkgrey,
        //               fontSize: 16,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ])
        );
  }
}
