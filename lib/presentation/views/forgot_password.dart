import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../core/utils/routes.dart';
import '../../core/utils/screen_size.dart';
import '../providers/auth_provider.dart';
import '../widgets/separator.dart';
import '../widgets/text_field.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
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
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: screenSizeMediaQuery.height * 0.03),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.02),
                        Text(
                          'Please enter your an email address. \n \t\t\t We will send you instructions',
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: screenSizeMediaQuery.height * 0.03),
                        ),
                        SizedBox(
                          width: screenSizeMediaQuery.width * 0.3,
                          child: TextFieldWidget(
                            labelText: 'Email',
                            controller: emailController,
                            isPassword: false,
                          ),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.04),
                        ElevatedButton(
                          onPressed: () async {
                            final email = emailController.text.trim();
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .resetPassword(email, context);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: ColorConstants.whiteColor,
                              fixedSize: Size(screenSizeMediaQuery.width * 0.3,
                                  screenSizeMediaQuery.height * 0.05),
                              backgroundColor: ColorConstants.appBarColor,
                              textStyle: TextStyle(
                                  fontSize: screenSizeMediaQuery.height * 0.025,
                                  fontWeight: FontWeight.w100)),
                          child: const Text(StringConstants.forgot),
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
