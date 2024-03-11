import 'package:animated_login/animated_login.dart';
import 'package:firestore_example/screens/utils/dailog_builder.dart';
import 'package:firestore_example/screens/utils/login_funtions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  LanguageOption language = _languageOptions[1];
  AuthMode currentMode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: CupertinoPageScaffold(
            child: AnimatedLogin(
              onLogin: LoginFunctions(context).onLogin,
              onSignup: LoginFunctions(context).onSignup,
              onForgotPassword: LoginFunctions(context).onForgotPassword,
              logo: Image.asset('assets/logo.png'),
              // backgroundImage: 'images/background_image.jpg',
              signUpMode: SignUpModes.both,
              socialLogins: _socialLogins(context),
              loginDesktopTheme: _desktopTheme,
              loginMobileTheme: _mobileTheme,
              loginTexts: _loginTexts,
              changeLanguageCallback: (LanguageOption? _language) {
                if (_language != null) {
                  DialogBuilder(context).showResultDialog(
                      'Successfully changed the language to: ${_language.value}.');
                  if (mounted) setState(() => language = _language);
                }
              },
              languageOptions: _languageOptions,
              selectedLanguage: language,
              initialMode: currentMode,
              onAuthModeChange: (AuthMode newMode) => currentMode = newMode,
              validateEmail: true,
              validateName: true,
              validateCheckbox: true,
              validatePassword: true,
            ),
          ),
      );
  }

  static List<LanguageOption> get _languageOptions => const <LanguageOption>[
    LanguageOption(
      value: 'Turkish',
      code: 'TR',
      iconPath: 'assets/tr.png',
    ),
    LanguageOption(
      value: 'English',
      code: 'EN',
      iconPath: 'assets/tr.png',
    ),
  ];

  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
    // To set the color of button text, use foreground color.
    actionButtonStyle: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
    dialogTheme: const AnimatedDialogTheme(
      languageDialogTheme: LanguageDialogTheme(
          optionMargin: EdgeInsets.symmetric(horizontal: 80)),
    ),
  );

  LoginViewTheme get _mobileTheme => LoginViewTheme(
    // showLabelTexts: false,
    backgroundColor: CupertinoColors.activeOrange, // const Color(0xFF6666FF),
    formFieldBackgroundColor: Colors.white,
    formWidthRatio: 60,
    actionButtonStyle: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blue),
    ),
  );

  LoginTexts get _loginTexts => LoginTexts(
    nameHint: _username,
    login: _login,
    signUp: _signup,
  );

  String get _username => language.code == 'TR' ? 'Kullanıcı Adı' : 'Username';

  String get _login => language.code == 'TR' ? 'Giriş Yap' : 'Login';

  String get _signup => language.code == 'TR' ? 'Kayıt Ol' : 'Sign Up';

  /// Social login options, you should provide callback function and icon path.
  /// Icon paths should be the full path in the assets
  /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
  List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
    SocialLogin(
        callback: () async => LoginFunctions(context).socialLogin('Google'),
        iconPath: 'assets/google.png'),
    SocialLogin(
        callback: () async =>
            LoginFunctions(context).socialLogin('Facebook'),
        iconPath: 'assets/facebook.png'),
    SocialLogin(
        callback: () async =>
            LoginFunctions(context).socialLogin('Linkedin'),
        iconPath: 'assets/linkedin.png'),
  ];

}
