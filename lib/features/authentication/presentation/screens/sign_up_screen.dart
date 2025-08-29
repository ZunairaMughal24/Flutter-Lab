import 'dart:developer';
import 'package:api_integration/config/router.dart';
import 'package:api_integration/core/utils/app_colors.dart';
import 'package:api_integration/core/utils/app_validators.dart';
import 'package:api_integration/core/utils/extentions.dart';
import 'package:api_integration/core/utils/padding_extention.dart';
import 'package:api_integration/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:api_integration/features/authentication/presentation/bloc/events.dart';
import 'package:api_integration/features/authentication/presentation/bloc/stats.dart';
import 'package:api_integration/widgets/auth_card.dart';
import 'package:api_integration/widgets/primary_button.dart';
import 'package:api_integration/widgets/primary_textFeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:api_integration/core/utils/app_text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      log('Email: ${_emailController.text}');
      log('Password: ${_passwordController.text}');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: 
            BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
       
          context.go(AppRoutes.homeScreenRoute);
        } else if (state is AuthFailure) {
         
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }},
      
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    50.heightBox,
                    Text(
                      "ANTIQUES",
                      style: AppTextTheme.h3(
                        color: Colors.brown,
                        weight: FontWeight.bold,
                        fontFamily: "regular",
                      ),
                    ),
                    Text(
                      "Furniture",
                      style: AppTextTheme.bodyMedium(
                        color: AppColors.primaryColor,
                        weight: FontWeight.bold,
                        fontFamily: "regular",
                      ).copyWith(fontSize: 18),
                    ),
                    
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.heightBox,
                          Text(
                            "Create Account",
                            style: AppTextTheme.h4(
                              weight: FontWeight.bold,
                              fontFamily: "regular",
                            ),
                          ).pOnly(left: 6),
                          8.heightBox,
                          Text(
                            'Please enter your name, email and password to create your account.',
                            style: AppTextTheme.bodyMedium(
                              color: AppColors.lightGrey,
                            ).copyWith(fontSize: 15),
                          ).pOnly(left: 6),
                        ],
                      ),
                    ),
                    15.heightBox,
                    PrimaryTextField(
                      controller: _nameController,
                      labelText: "Name",
                    
                      prefixIcon: const Icon(Icons.person),
                      validator: Validators.validateName,
                    ),
                    8.heightBox,
                    PrimaryTextField(
                      controller: _emailController,
                      labelText: "Email",
                    
                      prefixIcon: const Icon(Icons.email),
                      validator: Validators.validateEmail,
                    ),
                    8.heightBox,
                    PrimaryTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      obscureText: !_passwordVisible,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      validator: Validators.validatePassword,
                    ),
                    20.heightBox,
                    PrimaryButton(
                      text: 'Sign Up',
                      onTap: () {
                        _submit;
                        context.read<AuthBloc>().add(
                          SignUpRequested(
                            _emailController.text,
                            _passwordController.text,
                          ),
                        );
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: AppTextTheme.bodyMedium(
                            color: Colors.black,
                          ).copyWith(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(AppRoutes.loginScreenRoute);
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(0, 0)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Sign In',
                            style: AppTextTheme.bodyMedium(
                              color: AppColors.primaryColor,
                              weight: FontWeight.w500,
                            ).copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ).px8(),
                  ],
                ).px12(),
              ),
            ).pOnly(left: 16, right: 16, top: 50).safeArea(),
          ),
        ),
      ),
    );
  }
}
