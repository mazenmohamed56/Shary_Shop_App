import 'package:flutter/material.dart';
import 'package:shop_app/shared/Network/local/sharedPreferences.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shop_app/modules/LoginScreen/login_screen.dart';

class BoardingModel {
  @required
  String image;
  @required
  String title;
  @required
  String body;
  BoardingModel(this.image, this.title, this.body);
}

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel('assets/5252481.png', 'Boarding Page 1', 'Page Body 1'),
    BoardingModel('assets/5252481.png', 'Boarding Page 2', 'Page Body 2'),
    BoardingModel('assets/5252481.png', 'Boarding Page 3', 'Page Body 3'),
  ];
  var pagecontroller = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: skipBoarding, child: Text('Skip'))],
      ),
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    controller: pagecontroller,
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: boarding.length,
                    itemBuilder: (context, index) =>
                        buildPageItem(boarding[index])),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pagecontroller,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blueAccent,
                      dotHeight: 10,
                      expansionFactor: 4,
                      spacing: 5,
                      dotWidth: 10,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        skipBoarding();
                      } else {
                        pagecontroller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 30,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget buildPageItem(BoardingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage('${model.image}')),
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('${model.body}'),
        ],
      );

  void skipBoarding() {
    CacheHelper.putData(key: 'isOnBoarding', value: true);

    navigateAndFinsh(context, LoginScreen());
  }
}
