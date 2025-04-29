import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/controllers/start_controller.dart';
import 'package:my_project/utils/constants.dart';
import 'package:my_project/utils/resources/start/start_strings.dart';
import 'package:my_project/widgets/custom_button.dart';
import '../utils/resources/global/app_colors.dart';

class StartView extends StatelessWidget {
  StartView({super.key});
  final StartController _startController = StartController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                width: size.width * 0.5,
                Constants.myProjectLogoPath,
              ),
              Column(
                children: [
                  Image.asset(
                    width: size.width * .6,
                    Constants.startImgPath,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    StartStrings.primaryTitle,
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    StartStrings.secondaryTitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              // if (_homeController.isLoading.value)
              //   const CircularProgressIndicator(
              //     valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
              //   )
              // else
              //Started Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonText: StartStrings.buttonText,
                  onPressed: () => _startController.startButtonTaped(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
