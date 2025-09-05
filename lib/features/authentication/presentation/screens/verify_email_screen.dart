import 'package:api_integration/config/router.dart';
import 'package:api_integration/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:api_integration/features/authentication/presentation/bloc/events.dart';
import 'package:api_integration/features/authentication/presentation/bloc/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.push(AppRoutes.homeScreenRoute);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
            context.push(AppRoutes.loginScreenRoute);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "We’ve sent an OTP to your email: ${widget.email}",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                  //   final otp = _otpController.text.trim();
                  //   if (otp.isNotEmpty) {
                  //     context.read<AuthBloc>().add(
                  //       VerifyOtpRequest(email: widget.email, otp: otp),
                  //     );
                  //   }
                  },
                  child: const Text("Verify"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
