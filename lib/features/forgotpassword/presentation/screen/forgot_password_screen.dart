import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rainify/core/common/app_route.dart';
import 'package:rainify/features/forgotpassword/bloc/bloc.dart';
import 'package:rainify/features/forgotpassword/bloc/bloc_event.dart';
import 'package:rainify/features/forgotpassword/bloc/bloc_state.dart';
import 'package:rainify/features/login/presentation/widgets/left_slide_animation.dart';

import '../../../../core/common/app_const.dart';
import '../../../../core/common/widgets/common_dialog_widget.dart';
import '../../../../core/common/widgets/custom_text_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final forgotPasswordKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordLoadingState) {
            showDialog(
              context: context,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ForgotPasswordSuccessState) {
            if (context.mounted) {
              Navigator.pop(context);
            }
            context.go(RouteName.loginScreen);
          }
          if (state is ForgotPasswordErrorState) {
            if (context.mounted) {
              Navigator.pop(context);
            }
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => CommonDialogWidget(
                iconColor: AppConst.errorColor,
                onTapEvent: () {
                  Navigator.pop(context);
                },
                icon: Icons.error,
                title: "Auth Failed",
                desc:
                    state.errorMessage ??
                    "Something went wrong while creating your account. Please check your internet connection or try a different email address",
                buttonText: "Okay",
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: forgotPasswordKey,
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
                                    image: AssetImage(
                                      "assets/images/app_logo.png",
                                    ),
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
                                      "Forgot Password",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(fontSize: 20.0),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Enter your email to reset your password. We'll send a magic link to your inbox.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppConst.secTextColor,
                                            fontSize: 14.0,
                                          ),
                                    ),
                                    const SizedBox(height: 50.0),
                                    Text(
                                      "Email".toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
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
                                        } else {
                                          // Regex for email validation
                                          const emailPattern =
                                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

                                          final regex = RegExp(emailPattern);

                                          if (!regex.hasMatch(value.trim())) {
                                            return "Enter a valid email address";
                                          }
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      obsurceText: false,
                                      hintText: 'Please enter your email',
                                      suffix: null,
                                    ),

                                    const SizedBox(height: 20.0),
                                    GestureDetector(
                                      onTap: () {
                                        if (!forgotPasswordKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        forgotPasswordKey.currentState!.save();
                                        context.read<ForgotPasswordBloc>().add(
                                          PasswordResetEvent(
                                            email: emailController.text.trim(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: AppConst.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: .center,
                                            crossAxisAlignment: .center,
                                            children: [
                                              Text(
                                                "Send Reset Link",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                              const SizedBox(width: 5.0),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_right_outlined,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30.0),
                                    GestureDetector(
                                      onTap: () {
                                        context.go(RouteName.loginScreen);
                                      },
                                      child: Row(
                                        mainAxisAlignment: .center,
                                        crossAxisAlignment: .center,
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_left_outlined,
                                            color: AppConst.primaryColor,
                                          ),
                                          const SizedBox(width: 2.5),
                                          Text(
                                            "Back To Login",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  color: AppConst.primaryColor,
                                                  fontSize: 14.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
