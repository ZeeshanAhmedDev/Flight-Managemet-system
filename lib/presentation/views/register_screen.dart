import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../../core/utils/routes.dart';
import '../../core/utils/screen_size.dart';
import '../widgets/separator.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final screenSizeMediaQuery = ScreenSizeMediaQuery(context: context);
    return Scaffold(
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
                            labelText: 'First Name',
                            controller: firstNameController,
                            isPassword: false,
                          ),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.01),
                        SizedBox(
                          width: screenSizeMediaQuery.width * 0.3,
                          child: TextFieldWidget(
                            labelText: 'Last Name',
                            controller: lastNameController,
                            isPassword: true,
                          ),
                        ),
                        SizedBox(
                          width: screenSizeMediaQuery.width * 0.3,
                          child: TextFieldWidget(
                            labelText: 'Email',
                            controller: emailController,
                            isPassword: false,
                          ),
                        ),
                        SizedBox(
                          width: screenSizeMediaQuery.width * 0.3,
                          child: TextFieldWidget(
                            labelText: 'Password',
                            controller: passwordController,
                            isPassword: true,
                          ),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, AppRoutes.dashboard);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: ColorConstants.whiteColor,
                              fixedSize: Size(screenSizeMediaQuery.width * 0.3,
                                  screenSizeMediaQuery.height * 0.05),
                              backgroundColor: ColorConstants.appBarColor,
                              textStyle: TextStyle(
                                  fontSize: screenSizeMediaQuery.height * 0.025,
                                  fontWeight: FontWeight.w100)),
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
