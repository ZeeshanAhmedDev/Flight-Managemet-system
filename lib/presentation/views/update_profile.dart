import 'package:flight_management_system/core/utils/color_constants.dart';
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

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextFieldController _formController = TextFieldController();
  final formKeyForUpdateInformation = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final userInfo =
        await Provider.of<AuthProvider>(context, listen: false).fetchUserInfo();
    if (userInfo != null) {
      _formController.getController('firstName').text =
          userInfo['firstName'] ?? '';
      _formController.getController('lastName').text =
          userInfo['lastName'] ?? '';
      _formController.getController('email').text = userInfo['email'] ?? '';
    }
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
                      key: formKeyForUpdateInformation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_isLoading) ...[
                            CircularProgressIndicator(),
                            Separator(
                                height: screenSizeMediaQuery.height * 0.02),
                          ],
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
                          Separator(height: screenSizeMediaQuery.height * 0.02),
                          CustomElevatedButton(
                            screenSizeMediaQuery: screenSizeMediaQuery,
                            onTap: () async {
                              if (formKeyForUpdateInformation.currentState
                                      ?.validate() ==
                                  true) {
                                setState(() {
                                  _isLoading = true;
                                });

                                final firstName =
                                    _formController.getValue('firstName');
                                final lastName =
                                    _formController.getValue('lastName');
                                final email = _formController.getValue('email');

                                try {
                                  await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .updateUserInfo(
                                          firstName, lastName, email, context);
                                } catch (e) {
                                  // Handle any errors here if necessary
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            },
                            text: StringConstants.updateInformation,
                            isHollowButton: false,
                          ),
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
