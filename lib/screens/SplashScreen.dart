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
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/logo.png'), width: 120),
            Text(
              "Cloud Firestore",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: CupertinoColors.black,
              ),
            ),
            SizedBox(height: 20),
            CupertinoActivityIndicator(
              animating: true,
              radius: 35.0,
            )
          ],
        ),
      ),
    );
  }
}
