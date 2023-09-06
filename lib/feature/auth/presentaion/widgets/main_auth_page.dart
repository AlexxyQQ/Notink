import 'package:flutter/material.dart';
import 'package:notink/config/constants/constants.dart';
import 'package:notink/feature/auth/presentaion/widgets/others/landing_page_other_layout.dart';
import 'package:notink/feature/auth/presentaion/widgets/phone/main_auth_page_phone_layout.dart';

class MainAuthPage extends StatefulWidget {
  const MainAuthPage({super.key});

  @override
  State<MainAuthPage> createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mediaQuerySize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth > 600
            ? LandingPageOtherLayout(
                isDark: isDark, mediaQuerySize: mediaQuerySize)
            : Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor:
                    isDark ? KColors.blackColor : KColors.whiteColor,
                body: Column(
                  children: [
                    LogoAndAppNamePhoneLayout(
                        mediaQuerySize: mediaQuerySize, isDark: isDark),
                    LoginSignupButtonPhoneLayout(
                        isDark: isDark, mediaQuerySize: mediaQuerySize),
                  ],
                ),
              );
      },
    );
  }
}
