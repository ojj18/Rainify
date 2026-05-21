import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rainify/core/common/app_const.dart';
import 'package:rainify/core/common/widgets/common_dialog_widget.dart';
import 'package:rainify/features/register/bloc/bloc.dart';
import 'package:rainify/features/register/bloc/bloc_state.dart';
import 'package:rainify/features/register/presentation/widgets/left_slide_animation.dart';
import 'package:rainify/features/register/presentation/widgets/label_formfield.dart';

import '../../../../core/common/app_route.dart';
import '../../bloc/bloc_event.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordvisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            showDialog(
              context: context,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          }
          if (state is RegisterSuccessState) {
            if (context.mounted) {
              Navigator.pop(context);
            }
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => CommonDialogWidget(
                iconColor: AppConst.primaryColor,
                onTapEvent: () {
                  context.go(RouteName.loginScreen);
                },
                icon: Icons.check_circle_outline,
                title: "Account Created!",
                desc:
                    "Your Rainify account is ready. Welcome to our community of sky-watchers.",
                buttonText: "Go to Login",
              ),
            );
          }
          if (state is RegisterErrorState) {
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
                title: "Registration Failed",
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
            key: registerKey,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    LeftSlideAnimation(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Column(
                              mainAxisAlignment: .center,
                              crossAxisAlignment: .center,
                              children: [
                                const SizedBox(height: 100.0),
                                Container(
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
                                const SizedBox(height: 30),
                                Text(
                                  "Rainify",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayLarge,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Experience weather in high-definition",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(color: AppConst.secTextColor),
                                ),
                                const SizedBox(height: 30.0),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 20.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: .start,
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text(
                                          "Create Account",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(fontSize: 20.0),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          "Join our global network of sky-watchers",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: AppConst.secTextColor,
                                                fontSize: 14.0,
                                              ),
                                        ),
                                        const SizedBox(height: 30.0),
                                        //full name
                                        LabelFormfield(
                                          controller: nameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This is required";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          obsurceText: false,
                                          hintText: 'Please enter your name',
                                          suffix: null,
                                          prefix: Icon(
                                            Icons.person_2_outlined,
                                            color: AppConst.primaryColor,
                                          ),
                                          labelText: 'Full name',
                                        ),
                                        const SizedBox(height: 20.0),
                                        //Email
                                        LabelFormfield(
                                          controller: emailController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This is required";
                                            } else {
                                              // Regex for email validation
                                              const emailPattern =
                                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

                                              final regex = RegExp(
                                                emailPattern,
                                              );

                                              if (!regex.hasMatch(
                                                value.trim(),
                                              )) {
                                                return "Enter a valid email address";
                                              }
                                            }
                                            return null;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          obsurceText: false,
                                          hintText: 'Please enter your email',
                                          suffix: null,
                                          prefix: Icon(
                                            Icons.mail_outline,
                                            color: AppConst.primaryColor,
                                          ),
                                          labelText: 'Email',
                                        ),
                                        const SizedBox(height: 20.0),
                                        //Password
                                        LabelFormfield(
                                          controller: passwordController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This is required";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          obsurceText: isPasswordvisible,
                                          hintText:
                                              'Please enter your password',
                                          suffix: GestureDetector(
                                            onTap: () {
                                              isPasswordvisible =
                                                  !isPasswordvisible;
                                              setState(() {});
                                            },
                                            child: Icon(
                                              color: AppConst.primaryColor,
                                              !isPasswordvisible
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                        .visibility_off_outlined,
                                            ),
                                          ),
                                          prefix: Icon(
                                            Icons.lock_outline,
                                            color: AppConst.primaryColor,
                                          ),
                                          labelText: 'Password',
                                        ),
                                        const SizedBox(height: 20.0),
                                        //Password
                                        LabelFormfield(
                                          controller: confirmPasswordController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This is required";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          obsurceText: isConfirmPasswordVisible,

                                          suffix: GestureDetector(
                                            onTap: () {
                                              isConfirmPasswordVisible =
                                                  !isConfirmPasswordVisible;
                                              setState(() {});
                                            },
                                            child: Icon(
                                              color: AppConst.primaryColor,
                                              !isConfirmPasswordVisible
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                        .visibility_off_outlined,
                                            ),
                                          ),
                                          prefix: Icon(
                                            Icons.verified_user_outlined,
                                            color: AppConst.primaryColor,
                                          ),
                                          hintText:
                                              'Please enter your confirm password',

                                          labelText: 'Confirm password',
                                        ),
                                        const SizedBox(height: 20.0),
                                        GestureDetector(
                                          onTap: () {
                                            if (!registerKey.currentState!
                                                .validate()) {
                                              return;
                                            }
                                            if (confirmPasswordController.text
                                                    .trim() !=
                                                passwordController.text
                                                    .trim()) {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) =>
                                                    CommonDialogWidget(
                                                      iconColor:
                                                          AppConst.errorColor,
                                                      onTapEvent: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icons.error,
                                                      title:
                                                          "Registration Failed",
                                                      desc:
                                                          "Password and confirm password do not match.",
                                                      buttonText: "Okay",
                                                    ),
                                              );
                                              return;
                                            }
                                            registerKey.currentState!.save();
                                            context.read<RegisterBloc>().add(
                                              RegisterSuccessEvent(
                                                fullName: nameController.text
                                                    .trim(),
                                                email: emailController.text
                                                    .trim(),
                                                password:
                                                    confirmPasswordController
                                                        .text
                                                        .trim(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: AppConst.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            width: MediaQuery.sizeOf(
                                              context,
                                            ).width,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: .center,
                                                crossAxisAlignment: .center,
                                                children: [
                                                  Text(
                                                    "Create Account",
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
                                        Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "Already have an account?",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        color: AppConst
                                                            .secTextColor,
                                                        fontSize: 14.0,
                                                      ),
                                                ),
                                                WidgetSpan(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      context.go(
                                                        RouteName.loginScreen,
                                                      );
                                                    },
                                                    child: Text(
                                                      "Login",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            color: AppConst
                                                                .primaryColor,
                                                            fontSize: 14.0,
                                                          ),
                                                    ),
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
                              ],
                            ),
                          ),
                        ],
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
