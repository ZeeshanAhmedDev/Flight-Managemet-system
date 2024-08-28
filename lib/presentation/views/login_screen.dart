import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/routes.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../core/utils/screen_size.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_btn.dart';
import '../widgets/separator.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                            labelText: StringConstants.emailText,
                            controller: emailController,
                            isPassword: false,
                          ),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.01),
                        SizedBox(
                          width: screenSizeMediaQuery.width * 0.3,
                          child: TextFieldWidget(
                            labelText: StringConstants.passwordText,
                            controller: passwordController,
                            isPassword: true,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: screenSizeMediaQuery.width * 0.18),
                          child: TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.forgot),
                            child: const Text(StringConstants.forgotPassword),
                          ),
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.02),

                        CustomElevatedButton(
                          screenSizeMediaQuery: screenSizeMediaQuery,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.dashboard,
                            );
                          },
                          text: StringConstants.logIn,
                          isHollowButton: false,
                        ),
                        Separator(height: screenSizeMediaQuery.height * 0.04),

                        // Register Button
                        CustomElevatedButton(
                          screenSizeMediaQuery: screenSizeMediaQuery,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.register,
                            );
                          },
                          text: StringConstants.registerTextOnly,
                          isHollowButton: true,
                        )
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
