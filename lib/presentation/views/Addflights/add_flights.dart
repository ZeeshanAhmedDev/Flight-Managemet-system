import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../core/utils/form_controller.dart';
import '../../../core/utils/screen_size.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/separator.dart';
import '../../widgets/text_field.dart';

class AddFlightDetails extends StatefulWidget {
  const AddFlightDetails({super.key});

  @override
  State<AddFlightDetails> createState() => _AddFlightDetailsState();
}

class _AddFlightDetailsState extends State<AddFlightDetails> {
  final TextFieldController _formController = TextFieldController();
  final formKeyForAddFlights = GlobalKey<FormState>();

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  Future<void> _addFlights() async {
    final date = _formController.getValue('date');
    final departCity = _formController.getValue('departCity');
    final destCity = _formController.getValue('destCity');
    final duration = _formController.getValue('duration');
    final price = int.tryParse(_formController.getValue('price') ?? '0') ?? 0;
    final stopDate = _formController.getValue('stopDate');
    final stopTime = _formController.getValue('stopTime');
    final stops = int.tryParse(_formController.getValue('stops') ?? '0') ?? 0;
    final time = _formController.getValue('time');

    await Provider.of<AuthProvider>(context, listen: false).addFlights(
        date,
        departCity,
        destCity,
        duration,
        price,
        stopDate,
        stopTime,
        stops,
        time,
        context);
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
                      key: formKeyForAddFlights,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Date",
                              controller: _formController.getController('date'),
                              isPassword: false,
                            ),
                          ),
                          Separator(height: screenSizeMediaQuery.height * 0.01),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Departure City",
                              controller:
                                  _formController.getController('departCity'),
                              isPassword: false,
                            ),
                          ),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Destination City",
                              controller:
                                  _formController.getController('destCity'),
                              isPassword: false,
                            ),
                          ),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Duration",
                              controller:
                                  _formController.getController('duration'),
                              isPassword: false,
                            ),
                          ),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Price",
                              controller:
                                  _formController.getController('price'),
                              isPassword: false,
                            ),
                          ),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Stop Date",
                              controller:
                                  _formController.getController('stopDate'),
                              isPassword: false,
                            ),
                          ),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Stop Time",
                              controller:
                                  _formController.getController('stopTime'),
                              isPassword: false,
                            ),
                          ),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Stops",
                              controller:
                                  _formController.getController('stops'),
                              isPassword: false,
                            ),
                          ),
                          SizedBox(
                            width: screenSizeMediaQuery.width * 0.3,
                            child: TextFieldWidget(
                              labelText: "Time",
                              controller: _formController.getController('time'),
                              isPassword: false,
                            ),
                          ),
                          Separator(height: screenSizeMediaQuery.height * 0.02),
                          // Register Button
                          CustomElevatedButton(
                            screenSizeMediaQuery: screenSizeMediaQuery,
                            onTap: () async {
                              if (formKeyForAddFlights.currentState
                                      ?.validate() ==
                                  true) {
                                await _addFlights();
                              }
                            },
                            text: StringConstants.register,
                            isHollowButton: false,
                          ),
                          Separator(height: screenSizeMediaQuery.height * 0.04),
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
