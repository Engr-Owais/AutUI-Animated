import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/socal_buttons.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignup = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignup = !_isShowSignup;
    });
    _isShowSignup
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    setUpAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: _isShowSignup ? -_size.width * 0.76 : 0,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: _isShowSignup ? _size.width * 0.12 : _size.width * 0.88,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: _size.height * 0.10,
                  left: 0,
                  right:
                      _isShowSignup ? -_size.width * 0.06 : _size.width * 0.06,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: SvgPicture.asset(
                      "assets/animation_logo.svg",
                      color: _isShowSignup ? signup_bg : login_bg,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  bottom: _size.height * 0.10,
                  right:
                      _isShowSignup ? -_size.width * 0.06 : _size.width * 0.06,
                  child: SocalButtns(),
                ),
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _isShowSignup
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    left: _isShowSignup ? 0 : _size.width * 0.44 - 80,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: _isShowSignup ? 20 : 32,
                          fontWeight: FontWeight.bold,
                          color: _isShowSignup ? Colors.white : Colors.white70),
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * pi / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: updateView,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              "Log In".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !_isShowSignup
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    right: _isShowSignup ? _size.width * 0.44 - 80 : 0,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: !_isShowSignup ? 20 : 32,
                          fontWeight: FontWeight.bold,
                          color: _isShowSignup ? Colors.white : Colors.white70),
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: updateView,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              "Sign Up".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            );
          }),
    );
  }
}
