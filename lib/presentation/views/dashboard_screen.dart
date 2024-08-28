import 'package:cached_network_image/cached_network_image.dart';
import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flight_management_system/presentation/widgets/custom_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../core/utils/screen_size.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/dialog_box.dart';
import '../widgets/separator.dart';
import '../widgets/text_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List a = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
    "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/08/09/21/54/yellowstone-national-park-1581879_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
    "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
  ];

  late final List<String> items;
  // Controllers
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize the items list with some data
    items = List.generate(10, (index) => "Item $index");
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeMediaQuery = ScreenSizeMediaQuery(context: context);
    return WebSmoothScroll(
      controller: _scrollController,
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenSizeMediaQuery.height * 0.25,
                width: screenSizeMediaQuery.width,
                color: ColorConstants.appBarColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                        screenSizeMediaQuery.height * 0.1,
                      ),
                      child: DataShowerTextWidget(
                        fontSize: screenSizeMediaQuery.height * 0.04,
                        fontWeight: FontWeight.w700,
                        screenSizeMediaQuery: screenSizeMediaQuery,
                        text: StringConstants.appName,
                        textColor: ColorConstants.whiteColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        screenSizeMediaQuery.height * 0.06,
                      ),
                      child: const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: CachedNetworkImageProvider(
                            StringConstants.dummyUrlImage),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenSizeMediaQuery.height * 0.1,
                  top: screenSizeMediaQuery.height * 0.05,
                ),
                child: DataShowerTextWidget(
                  fontSize: screenSizeMediaQuery.height * 0.04,
                  fontWeight: FontWeight.w700,
                  screenSizeMediaQuery: screenSizeMediaQuery,
                  text: StringConstants.dashboardTitleText,
                  textColor: ColorConstants.blackColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenSizeMediaQuery.height * 0.1,
                  top: screenSizeMediaQuery.height * 0.03,
                ),
                child: DataShowerTextWidget(
                  fontSize: screenSizeMediaQuery.height * 0.03,
                  fontWeight: FontWeight.w100,
                  screenSizeMediaQuery: screenSizeMediaQuery,
                  text: StringConstants.dashboardSubtitleText,
                  textColor: ColorConstants.blackColor,
                ),
              ),
              Separator(height: screenSizeMediaQuery.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // From Field
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.whereFromText,
                    ),
                  ),
                  CustomSwapIcon(),
                  // To Field
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.whereToText,
                    ),
                  ),
                  // Date Picker
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.selectDate,
                    ),
                  ),
                  // Number of Adults Field
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.selectPerson,
                    ),
                  ),
                  // Search Button
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomElevatedButton(
                      text: StringConstants.searchText,
                      isHollowButton: false,
                      screenSizeMediaQuery: screenSizeMediaQuery,
                      onTap: () => Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "RFLUTTER ALERT",
                        desc: "Flutter is more awesome with RFlutter Alert.",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "FLAT",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                          ),
                          DialogButton(
                            child: Text(
                              "GRADIENT",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(116, 116, 191, 1.0),
                              Color.fromRGBO(52, 138, 199, 1.0)
                            ]),
                          )
                        ],
                      ).show(),
                    ),
                  ),
                ],
              ),
              Separator(height: screenSizeMediaQuery.height * 0.08),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctx, int index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Card(
                      shape: Border.all(
                        width: 5,
                      ),
                      elevation: 20,
                      color: Colors.black,
                      child: Column(
                        children: <Widget>[
                          Image.network(a[index]),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: a.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSwapIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(Icons.swap_horiz, color: Colors.blue),
    );
  }
}
