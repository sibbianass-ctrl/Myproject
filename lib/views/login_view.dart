import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/login_controller.dart';
import 'package:my_project/utils/constants.dart';
import 'package:my_project/utils/resources/global/app_colors.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/resources/login/login_strings.dart';
import 'package:my_project/widgets/custom_checkbox.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_text_button.dart';
import 'package:my_project/widgets/custom_text_field.dart';
import '../widgets/confirmation_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());
  // final AuthService _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
  }

  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2,
              color: AppColors.green,
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * .11,
                bottom: size.height * .02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Logo
                  Image.asset(
                    width: size.width * 0.3,
                    Constants.moroccoLogoPath,
                  ),
                  // Loging Content
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          width: size.width * 0.6,
                          Constants.myProjectLogoPath,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomTextField(
                            label: LoginStrings.usernameLabel,
                            icon: Icons.person_outline_outlined,
                            hintText: LoginStrings.usernameHint,
                            keyboardType: TextInputType.emailAddress,
                            controller: _usernameTextController),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(
                          () => CustomTextField(
                            label: LoginStrings.passwordLabel,
                            icon: Icons.lock_outline,
                            hintText: LoginStrings.passwordHint,
                            obscureText:
                                _loginController.isPasswordVisible.value,
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordTextController,
                            onVisible: () {
                              _loginController.isPasswordVisible.value =
                                  !_loginController.isPasswordVisible.value;
                            },
                          ),
                        ),
                        CustomCheckbox(
                          labelText: LoginStrings.saveLoginCheckboxLabel,
                          onChanged: (value) {
                            _loginController.isRememberMe = value ?? false;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //Login Button
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            buttonText: LoginStrings.loginButtonText,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              Get.focusScope?.unfocus();
                              _loginController.login(
                                _usernameTextController.text,
                                _passwordTextController.text,
                              );
                              // loginUser();
                              // await _authService.generateToken(
                              //     _usernameTextController.text,
                              //     _passwordTextController.text);
                            },
                          ),
                        ),
                        // Forget Password Button
                        CustomTextButton(
                          buttonText: LoginStrings.forgetPasswordButtonText,
                          onPressed: () async {
                            Get.dialog(ConfirmationDialog(
                              title: LoginStrings.forgetPasswordButtonText,
                              content: LoginStrings.forgetPasswordMessage,
                              yesButtonTitle: AppStrings.ok,
                              noButtonTitle: '',
                            ));
                          },
                          textColor: AppColors.green,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.93),
              width: double.infinity,
              child: const Text(
                textAlign: TextAlign.center,
                AppStrings.copyright,
                style: TextStyle(fontSize: 10.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
