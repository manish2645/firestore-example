import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then((value) =>
        Navigator.of(context).popAndPushNamed('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.activeOrange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/logo.png'), width: 120),

            SizedBox(height: 20),
            CupertinoActivityIndicator(
              color: CupertinoColors.black,
              animating: true,
              radius: 35.0,
            )
          ],
        ),
      ),
    );
  }
}
