import 'dart:html';

import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/routes.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../core/utils/screen_size.dart';
import '../providers/auth_provider.dart';
import '../widgets/separator.dart';
import '../widgets/text_field.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final screenSizeMediaQuery = ScreenSizeMediaQuery(context: context);
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.logout_sharp)],
        automaticallyImplyLeading: false,
        title: const Text(StringConstants.appName),
      ),
      backgroundColor: ColorConstants.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        screenSizeMediaQuery.height * 0.07,
                      ),
                    ),
                    height: screenSizeMediaQuery.height * 0.8,
                    child: Transform.rotate(
                      angle: -math.pi / 2,
                      child: SvgPicture.asset(
                        StringConstants.airPlaneSvg,
                        height: screenSizeMediaQuery.height * 0.7,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorConstants.whiteColor,
                    ),
                    height: screenSizeMediaQuery.height,
                    width: screenSizeMediaQuery.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenSizeMediaQuery.width * 0.3,
                          child: TextFieldWidget(
                            labelText: 'Email',
                            controller: emailController,
                            isPassword: false,
                          ),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.01),
                        SizedBox(
                          width: screenSizeMediaQuery.width * 0.3,
                          child: TextFieldWidget(
                            labelText: 'Password',
                            controller: passwordController,
                            isPassword: true,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: screenSizeMediaQuery.width * 0.14),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot Password'),
                          ),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            String email = emailController.text;
                            String password = passwordController.text;
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .registerUser(email, password, context);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: ColorConstants.whiteColor,
                              fixedSize: Size(screenSizeMediaQuery.width * 0.3,
                                  screenSizeMediaQuery.height * 0.05),
                              backgroundColor: ColorConstants.appBarColor,
                              textStyle: TextStyle(
                                  fontSize: screenSizeMediaQuery.height * 0.025,
                                  fontWeight: FontWeight.w100)),
                          child: const Text(StringConstants.logIn),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.04),

                        // Register Button
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: ColorConstants.appBarColor),
                            foregroundColor: ColorConstants.appBarColor,
                            fixedSize: Size(screenSizeMediaQuery.width * 0.3,
                                screenSizeMediaQuery.height * 0.05),
                            backgroundColor: ColorConstants.whiteColor,
                            textStyle: TextStyle(
                                fontSize: screenSizeMediaQuery.height * 0.025,
                                fontWeight: FontWeight.w100),
                          ),
                          child: const Text(StringConstants.register),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
