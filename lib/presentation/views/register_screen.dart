import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../core/utils/form_controller.dart';
import '../../core/utils/routes.dart';
import '../../core/utils/screen_size.dart';
import '../../core/utils/validators/form_validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_btn.dart';
import '../widgets/separator.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextFieldController _formController = TextFieldController();
  final formKeyForRegister = GlobalKey<FormState>();

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final firstName = _formController.getValue('firstName');
    final lastName = _formController.getValue('lastName');
    final email = _formController.getValue('email');
    final password = _formController.getValue('password');

    await Provider.of<AuthProvider>(context, listen: false)
        .registerUser(firstName, lastName, email, password, context);
  }

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
                      key: formKeyForRegister,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              validator: FormValidator.validateFirstName,
                              labelText: StringConstants.firstName,
                              controller:
                                  _formController.getController('firstName'),
                              isPassword: false,
                            ),
                          ),
                          Separator(height: screenSizeMediaQuery.height * 0.01),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              validator: FormValidator.validateLastName,
                              labelText: StringConstants.lastName,
                              controller:
                                  _formController.getController('lastName'),
                              isPassword: false,
                            ),
                          ),
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
                          Separator(height: screenSizeMediaQuery.height * 0.02),

                          // Register Button
                          CustomElevatedButton(
                            screenSizeMediaQuery: screenSizeMediaQuery,
                            onTap: () async {
                              if (formKeyForRegister.currentState?.validate() ==
                                  true) {
                                await _registerUser();
                              }
                            },
                            text: StringConstants.register,
                            isHollowButton: false,
                          ),
                          Separator(height: screenSizeMediaQuery.height * 0.04),

                          // Login Button
                          CustomElevatedButton(
                            screenSizeMediaQuery: screenSizeMediaQuery,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.login,
                              );
                            },
                            text: StringConstants.alreadyHaveAccount,
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
