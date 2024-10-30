import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code/core/widgets/custom_button.dart';
import 'package:qr_code/features/auth/login/controller/cubit/login_cubit.dart';
import 'package:qr_code/features/qr/presentation/qr_scanner_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QrScannerScreen()));
            });
          } else if (state is LoginFailedState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(
                  state.msg,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            const CircularProgressIndicator();
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/images/center_image.png'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/right_img.png'),
                        ],
                      ),
                      const Column(
                        children: [
                          SizedBox(height: 140),
                          Center(child: Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 66),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              labelText: "Enter your email",
                              focusColor: Color(0xffFE7D55),
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email must not be empty";
                              }
                              return null;
                            },
                            ),
                          const SizedBox(height: 22),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.remove_red_eye),
                              labelText: "Password",
                            ),
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password must not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 22),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Forget password?"),
                            ],
                          ),
                          const SizedBox(height: 44),
                          CustomButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Login'
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
