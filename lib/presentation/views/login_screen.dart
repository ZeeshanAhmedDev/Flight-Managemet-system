import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/routes.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flight_management_system/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../core/utils/form_controller.dart';
import '../../core/utils/screen_size.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_btn.dart';
import '../widgets/separator.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextFieldController _formController = TextFieldController();
  final formKeyForLogin = GlobalKey<FormState>();

  Future<void> _loginUser() async {
    final email = _formController.getValue('email');
    final password = _formController.getValue('password');

    await Provider.of<AuthProvider>(context, listen: false)
        .loginUser(email, password, context);
  }

  /* void _navigateToDashboardScreen() {
    if (mounted) {
      Navigator.pushNamed(context, AppRoutes.dashboard);
    }
  }*/

  @override
  Widget build(BuildContext context) {
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
                    child: Form(
                      key: formKeyForLogin,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              validator: FormValidator.validateEmail,
                              labelText: StringConstants.emailText,
                              controller:
                                  _formController.getController('email'),
                              isPassword: false,
                            ),
                          ),
                          Separator(height: screenSizeMediaQuery.height * 0.01),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              validator: FormValidator.validatePassword,
                              labelText: StringConstants.passwordText,
                              controller:
                                  _formController.getController('password'),
                              isPassword: true,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: screenSizeMediaQuery.width * 0.18),
                            child: TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, AppRoutes.forgot),
                              child: const Text(StringConstants.forgotPassword),
                            ),
                          ),
                          Separator(height: screenSizeMediaQuery.height * 0.02),

                          CustomElevatedButton(
                            screenSizeMediaQuery: screenSizeMediaQuery,
                            onTap: () async {
                              if (formKeyForLogin.currentState?.validate() ==
                                  true) {
                                await _loginUser();
                                // _navigateToDashboardScreen();
                              }
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
