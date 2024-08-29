import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flight_management_system/presentation/widgets/custom_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../core/utils/custom_alert.dart';
import '../../core/utils/routes.dart';
import '../../core/utils/screen_size.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/footer_widget.dart';
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
  final customAlertBox = CustomAlertBox();

  late final List<String> items;
  late ScrollController _scrollController;
  String? _firstName;

  @override
  void initState() {
    super.initState();
    items = List.generate(10, (index) => "Item $index");
    _scrollController = ScrollController();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final userInfo =
        await Provider.of<AuthProvider>(context, listen: false).fetchUserInfo();
    if (userInfo != null) {
      setState(() {
        _firstName =
            userInfo['firstName'] ?? ''; // Set the first name to the variable
      });
    }
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
                height: screenSizeMediaQuery.height * 0.35,
                width: screenSizeMediaQuery.width,
                color: ColorConstants.appBarColor,
                child: Column(
                  children: [
                    Row(
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
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.updateProfile);
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: screenSizeMediaQuery.height * 0.01,
                                ),
                                child: Icon(
                                  color: ColorConstants.whiteColor,
                                  Icons.account_circle,
                                  size: screenSizeMediaQuery.height * 0.1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: screenSizeMediaQuery.height * 0.05,
                                ),
                                child: DataShowerTextWidget(
                                  fontSize: screenSizeMediaQuery.height * 0.04,
                                  fontWeight: FontWeight.w700,
                                  screenSizeMediaQuery: screenSizeMediaQuery,
                                  text: StringConstants.viewProfile,
                                  textColor: ColorConstants.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.whereFromText,
                    ),
                  ),
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.whereToText,
                    ),
                  ),
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.selectDate,
                    ),
                  ),
                  const Expanded(
                    child: CustomDropdown(
                      hintText: StringConstants.selectPerson,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomElevatedButton(
                      text: StringConstants.searchText,
                      isHollowButton: false,
                      screenSizeMediaQuery: screenSizeMediaQuery,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Separator(height: screenSizeMediaQuery.height * 0.3),
              // Footer Section
              buildFooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

/*
_firstName != null
? Padding(
padding: EdgeInsets.only(
right:
screenSizeMediaQuery.height * 0.05,
),
child: DataShowerTextWidget(
fontSize:
screenSizeMediaQuery.height * 0.04,
fontWeight: FontWeight.w700,
screenSizeMediaQuery:
screenSizeMediaQuery,
text: 'Welcome, $_firstName',
textColor: ColorConstants.whiteColor,
),
)*/
