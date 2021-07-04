import 'dart:io';

import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/blocs/newsbloc/news_bloc.dart';
import 'package:habitool/model/blocs/newsbloc/news_states.dart';
import 'package:habitool/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:habitool/view/screen/achivement/social_screen.dart';

import '../home_screen.dart';

class ListNew extends StatefulWidget {
  @override
  _ListNewState createState() => _ListNewState();
}

class _ListNewState extends State<ListNew> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.light,
          body: Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: CustomColors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: size.width * 0.075),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Khám phá",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 12, left: 12, top: size.height * 0.01),
                      child: customButton(size, "Khám phá cộng đồng"),
                    ),
                    //
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.3),
                padding: EdgeInsets.all(16),
                child: Text(
                  "Tin tức",
                  style: TextStyle(
                    color: CustomColors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.35),
                padding: EdgeInsets.all(16),
                child: BlocBuilder<NewsBloc, NewsStates>(
                  builder: (BuildContext context, NewsStates state) {
                    if (state is NewsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NewsLoadedState) {
                      List<ArticleModel> _articleList = [];
                      _articleList = state.articleList;
                      return ListView.builder(
                          itemCount: _articleList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (Platform.isAndroid) {
                                  FlutterWebBrowser.openWebPage(
                                    url: _articleList[index].url,
                                    customTabsOptions: CustomTabsOptions(
                                      colorScheme: CustomTabsColorScheme.dark,
                                      toolbarColor: Colors.deepPurple,
                                      secondaryToolbarColor: Colors.green,
                                      navigationBarColor: Colors.amber,
                                      addDefaultShareMenuItem: true,
                                      instantAppsEnabled: true,
                                      showTitle: true,
                                      urlBarHidingEnabled: true,
                                    ),
                                  );
                                } else if (Platform.isIOS) {
                                  FlutterWebBrowser.openWebPage(
                                    url: _articleList[index].url,
                                    safariVCOptions:
                                        SafariViewControllerOptions(
                                      barCollapsingEnabled: true,
                                      preferredBarTintColor: Colors.green,
                                      preferredControlTintColor: Colors.amber,
                                      dismissButtonStyle:
                                          SafariViewControllerDismissButtonStyle
                                              .close,
                                      modalPresentationCapturesStatusBarAppearance:
                                          true,
                                    ),
                                  );
                                } else {
                                  await FlutterWebBrowser.openWebPage(
                                      url: _articleList[index].url);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: CustomColors.pink),
                                ),
                                height: height * 0.15,
                                margin: EdgeInsets.only(
                                    bottom: height * 0.01,
                                    top: height * 0.01,
                                    left: width * 0.02,
                                    right: width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      width: width * 0.3,
                                      height: height * 0.15,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                _articleList[index]
                                                            .urlToImage !=
                                                        null
                                                    ? _articleList[index]
                                                        .urlToImage
                                                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Container(
                                      height: height * 0.15,
                                      width: width * 0.5,
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.01),
                                      child: Text(
                                        _articleList[index].title,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (state is NewsErrorState) {
                      String error = state.errorMessage;

                      return Center(child: Text(error));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ));
                    }
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget customButton(Size size, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SocialScreen()),
            (route) => false);
      },
      child: Center(
        child: Container(
            width: size.width * 0.85,
            margin: EdgeInsets.only(top: 60.0, bottom: 10),
            height: size.height * 0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              // border: Border.all(color: CustomColors.pink),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: CustomColors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nhấn vào để tìm hiểu thêm',
                  style: TextStyle(
                      color: CustomColors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic),
                ),
              ],
            )),
      ),
    );
  }
}
