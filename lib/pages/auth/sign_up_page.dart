import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/modles/sign_up_body.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utilities/colors.dart';
import 'package:food_delivery_app/utilities/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    //validation

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackbar(
          "Type in your name",
          title: "Name",
        );
      } else if (phone.isEmpty) {
        showCustomSnackbar(
          "Type in your phone number",
          title: "Phone",
        );
      } else if (email.isEmpty) {
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
        SignUpbody signUpbody = SignUpbody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpbody).then((status) {
          if (status.isSuccess) {
            print("Success");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackbar(status.message);
          }
        });
        // print(signUpbody.toString());
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
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
                    AppTextField(
                        textController: nameController,
                        hintText: "Name",
                        icon: Icons.person),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AppTextField(
                      textController: phoneController,
                      hintText: "Phone",
                      icon: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    //sign up button
                    GestureDetector(
                      onTap: (() {
                        _registration(_authController);
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
                            text: "Sign Up",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),

                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),

                    //sign up options
                    RichText(
                      text: TextSpan(
                        text: "Sign up using one of the following methods",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                    Wrap(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: Dimensions.radius30,
                            backgroundImage: AssetImage(
                                "assets/images/" + signUpImages[index]),
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              : const CustomLoader();
        }));
  }
}
