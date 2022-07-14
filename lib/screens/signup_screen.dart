import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_sharing_app/utils/colors.dart';
import 'package:photo_sharing_app/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPassword = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _reEnterPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //image
              SvgPicture.asset(
                'assets/photogram.svg',
                color: primaryColor,
                height: 64,
              ),

              const SizedBox(
                height: 64,
              ),
              // textfield for username
              TextFieldInput(
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                  hintText: 'enter your username here'),
              // password
              const SizedBox(
                height: 24,
              ),
              //textfields for email
              TextFieldInput(
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                  hintText: 'enter your email here'),
              // password
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
                hintText: 'enter your password here',
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  textInputType: TextInputType.text,
                  textEditingController: _reEnterPassword,
                  isPass: true,
                  hintText: 're-enter your password'),
              // password
              const SizedBox(
                height: 24,
              ),
              //textfield for bio
              TextFieldInput(
                  textInputType: TextInputType.text,
                  textEditingController: _bioController,
                  hintText: 'enter your bio here'),
              // password
              const SizedBox(
                height: 24,
              ),

              // the button
              InkWell(
                child: Container(
                  child: const Text('Sign Up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: blueColor),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // Transitioning to signup page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("already have an account ?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
