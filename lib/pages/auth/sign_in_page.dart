import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar(
          "Type in your email",
          title: "Email",
        );
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackbar(
          "Type in your valid email address",
          title: "Invalid Email",
        );
      } else if (password.isEmpty) {
        showCustomSnackbar(
          "Type in your password",
          title: "Password",
        );
      } else if (password.length < 6) {
        showCustomSnackbar(
          "Password cannot be less than 6 character",
          title: "Weak Password",
        );
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            print("Success sign in");
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackbar(status.message);
          }
        });
        // print(signUpbody.toString());
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),

                    //logo
                    Container(
                      height: Dimensions.screenHeight * 0.25,
                      child: const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          backgroundImage:
                              AssetImage("assets/images/logo 2.png"),
                        ),
                      ),
                    ),

                    //welcome page
                    Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                      ),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(
                              fontSize:
                                  Dimensions.font20 * 3 + Dimensions.font20 / 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Sign in to your account",
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              color: Colors.grey[500],
                              //fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    AppTextField(
                      textController: emailController,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AppTextField(
                      textController: passwordController,
                      hintText: "Password",
                      icon: Icons.password_sharp,
                      isObscure: true,
                    ),

                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          text: TextSpan(
                            text: "Sign into your account",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),

                    //sign in
                    GestureDetector(
                      onTap: (() {
                        _login(authController);
                      }),
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius30,
                          ),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: BigText(
                            text: "Sign In",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),

                    //sign up options
                    RichText(
                      text: TextSpan(
                          text: "Don\'t have an account?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(
                                      () => SignUpPage(),
                                      transition: Transition.fade,
                                    ),
                              text: "Create",
                              style: TextStyle(
                                color: AppColors.mainBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ]),
                    ),
                  ]),
                )
              : CustomLoader();
        }));
  }
}
