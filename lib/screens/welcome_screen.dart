import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation colorAnimation;
  // initialize the animation once the screen is initialized
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    // curved animation (always make sure upper bound is less than one)
    // we can have other types of animations aside cuves. eg. ColorTween (take an animation course)
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    // tween color animation
    colorAnimation =
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.white)
            .animate(controller);

    // we can add a status listener to   the animation to check the status and perform operations based on the status.
    // remember to use dipose whenever you use animation controllers
    controller.forward();
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
    });
  }

// dispose whenever an animation controller is used. to prevent it from wasting resources after it has closed.
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                      child: Image.asset('images/logo.png'), height: 60.0),
                ),
                // using animated text.
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  repeatForever: false,
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              text: 'Login',
              color: Colors.blueAccent,
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, '/login');
              },
            ),
            RoundedButton(
              text: 'Register',
              color: Colors.lightBlueAccent,
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
