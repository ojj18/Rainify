import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rainify/core/common/app_route.dart';
import 'package:rainify/features/login/presentation/widgets/left_slide_animation.dart';

import '../../../../core/common/app_const.dart';
import '../../../../core/common/widgets/custom_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginkey,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                LeftSlideAnimation(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 100.0),
                        Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/app_logo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Text(
                            "Rainify",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Professional weather intelligence",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: AppConst.secTextColor),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 30.0,
                            ),
                            child: Column(
                              mainAxisAlignment: .start,
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  "Welcome back",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 20.0),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  "Enter your credentials to access your dashboard.",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: AppConst.secTextColor,
                                        fontSize: 14.0,
                                      ),
                                ),
                                const SizedBox(height: 30.0),
                                Text(
                                  "Email".toUpperCase(),
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 10.0),
                                CustomTextFieldWidget(
                                  prefix: Icon(
                                    Icons.mail_outline,
                                    color: AppConst.primaryColor,
                                  ),
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  obsurceText: false,
                                  hintText: 'Please enter your email',
                                  suffix: null,
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  "Password".toUpperCase(),
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 10.0),
                                CustomTextFieldWidget(
                                  prefix: Icon(
                                    Icons.lock_outline,
                                    color: AppConst.primaryColor,
                                  ),
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  obsurceText: isPasswordvisible,
                                  hintText: 'Please enter your password',
                                  suffix: GestureDetector(
                                    onTap: () {
                                      isPasswordvisible = !isPasswordvisible;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      color: AppConst.primaryColor,
                                      !isPasswordvisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    context.go(RouteName.forgotPasswordScreen);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Forgot Password?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppConst.primaryColor,
                                            fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                GestureDetector(
                                  onTap: () {
                                    if (!loginkey.currentState!.validate()) {
                                      return;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: AppConst.primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: .center,
                                        crossAxisAlignment: .center,
                                        children: [
                                          Text(
                                            "Login",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          const SizedBox(width: 5.0),
                                          Icon(
                                            Icons.keyboard_arrow_right_outlined,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 30.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: .center,
                                    crossAxisAlignment: .center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1.5,

                                          color: Colors.grey.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        "Or continue With".toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontSize: 12.0,
                                              color: AppConst.secTextColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Expanded(
                                        child: Container(
                                          height: 1.5,
                                          width: 200,
                                          color: Colors.grey.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.withValues(
                                                alpha: 0.3,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10.0,
                                            ),
                                          ),

                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: .center,
                                              children: [
                                                Image(
                                                  height: 15,
                                                  width: 15,
                                                  image: AssetImage(
                                                    "assets/images/google.png",
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0),
                                                Text(
                                                  "Google",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontSize: 16,
                                                        color: AppConst
                                                            .secTextColor,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.withValues(
                                                alpha: 0.3,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10.0,
                                            ),
                                          ),

                                          child: Row(
                                            mainAxisAlignment: .center,
                                            children: [
                                              Image(
                                                height: 15,
                                                width: 15,
                                                color: Colors.white,
                                                image: AssetImage(
                                                  "assets/images/apple.png",
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              Text(
                                                "Apple",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontSize: 16,
                                                      color:
                                                          AppConst.secTextColor,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account?",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: AppConst.secTextColor,
                                        fontSize: 14.0,
                                      ),
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.go(RouteName.registerScreen);
                                    },
                                    child: Text(
                                      "Register",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppConst.primaryColor,
                                            fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
