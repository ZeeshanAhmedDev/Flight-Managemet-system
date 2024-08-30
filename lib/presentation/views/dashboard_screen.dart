import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flight_management_system/presentation/widgets/custom_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/custom_alert.dart';
import '../../core/utils/routes.dart';
import '../../core/utils/screen_size.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_datepicker.dart';
import '../widgets/custom_default_dropdown.dart';
import '../widgets/custom_guest_dropdown.dart';
import '../widgets/flightdetails_card.dart';
import '../widgets/footer_widget.dart';
import '../widgets/separator.dart';
import '../widgets/text_widget.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final customAlert = CustomAlertBox();
  late ScrollController _scrollController;
  String? selectedCountryWhereFrom;
  String? selectedCountryWhereTo;
  int? selectedGuests;
  DateTime? selectedDate;

  bool showPopupButton = false;
  bool isClicked = false;

  var userName;
  final List<String> countries = [
    "USA",
    "Canada",
    "Mexico",
    "Germany",
    "France",
    "Italy",
    "Pakistan"
  ];
  final List<String> cities = [
    "New York",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Phoenix",
    "Rome",
    "Venice",
    "Milan"
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    try {
      final userInfo = await Provider.of<AuthProvider>(context, listen: false)
          .fetchUserInfo();
      if (userInfo != null) {
        setState(() {
          userName = userInfo['firstName'] ?? 'Unknown User';
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Failed to load user';
      });
      if (kDebugMode) {
        print('Error loading user info: $e');
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _validateAndSearch() {
    if (selectedCountryWhereFrom == null || selectedCountryWhereFrom!.isEmpty) {
      customAlert.buildShowDialog(context, 'Departure Location', '',
          'Please select the departure location.', 'Close');
    } else if (selectedCountryWhereTo == null ||
        selectedCountryWhereTo!.isEmpty) {
      customAlert.buildShowDialog(context, 'Destination Location', '',
          'Please select the destination location.', 'Close');
    } else if (selectedDate == null) {
      customAlert.buildShowDialog(
          context, 'Date Validation', '', 'Please select the date.', 'Close');
    } else {
      // Proceed with search
      if (kDebugMode) {
        isClicked = true;
        print('Searching flights...');
      }
    }
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Profile Options"),
          content: const Text("Here you can manage your profile settings."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, AppRoutes.updateProfile);
              },
              child: const Text("Update Info"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout(context);
              },
              child: const Text('Logout'),
            )
          ],
        );
      },
    );
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
                        MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              showPopupButton = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              showPopupButton = false;
                            });
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
                                  text: userName ?? "",
                                  textColor: ColorConstants.whiteColor,
                                ),
                              ),
                              if (showPopupButton)
                                ElevatedButton(
                                  onPressed: () => _showPopup(context),
                                  child: const Text("Settings"),
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
              // Dropdown Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomDefaultDropdown(
                      items: countries,
                      hintText: StringConstants.whereFromText,
                      selectedItem: selectedCountryWhereFrom,
                      onChanged: (value) {
                        setState(() {
                          selectedCountryWhereFrom = value;
                        });
                      },
                      borderColor: Colors.blue,
                      dropdownColor: Colors.lightBlue[50]!,
                      textColor: Colors.black,
                      hintTextColor: Colors.blueGrey,
                      borderRadius: 12.0,
                      elevation: 8.0,
                    ),
                  ),
                  Separator(height: screenSizeMediaQuery.height * 0.08),
                  Expanded(
                    flex: 1,
                    child: CustomDefaultDropdown(
                      items: countries,
                      hintText: StringConstants.whereToText,
                      selectedItem: selectedCountryWhereTo,
                      onChanged: (value) {
                        setState(() {
                          selectedCountryWhereTo = value;
                        });
                      },
                      borderColor: Colors.blue,
                      dropdownColor: Colors.lightBlue[50]!,
                      textColor: Colors.black,
                      hintTextColor: Colors.blueGrey,
                      borderRadius: 12.0,
                      elevation: 8.0,
                    ),
                  ),
                  Separator(height: screenSizeMediaQuery.height * 0.08),
                  Expanded(
                    flex: 1,
                    child: CustomDatePicker(
                      hintText: 'Select Date',
                      selectedDate: selectedDate,
                      onDateChanged: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      borderColor: Colors.blue,
                      textColor: Colors.black,
                      hintTextColor: Colors.blueGrey,
                      borderRadius: 12.0,
                    ),
                  ),
                  Separator(height: screenSizeMediaQuery.height * 0.08),
                  SizedBox(
                      width: screenSizeMediaQuery.width * 0.25,
                      child: CustomGuestDropdown(
                        label: 'Adults',
                        initialCount: 2,
                        onChanged: (newCount) {
                          setState(() {
                            selectedGuests = newCount;
                          });
                        },
                      )),
                  Separator(height: screenSizeMediaQuery.height * 0.08),
                  Expanded(
                    flex: 1,
                    child: CustomElevatedButton(
                      text: StringConstants.searchText,
                      isHollowButton: false,
                      screenSizeMediaQuery: screenSizeMediaQuery,
                      onTap: () {
                        setState(() {
                          _validateAndSearch();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Separator(height: screenSizeMediaQuery.height * 0.1),
              // Flight Details Section
              SizedBox(
                height: screenSizeMediaQuery.height,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: Provider.of<AuthProvider>(context, listen: false)
                      .getFlightDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading flight details'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No flight details available'));
                    }

                    final flights = snapshot.data!;
                    return isClicked
                        ? ListView.builder(
                            itemCount: flights.length,
                            itemBuilder: (context, index) {
                              final flight = flights[index];
                              return FlightDetailsCard(
                                flight: flight,
                              );
                            },
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
              Separator(height: screenSizeMediaQuery.height * 0.01),
              // Footer Section
              buildFooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
