import 'package:flutter/material.dart';
import 'package:notink/config/constants/constants.dart';

class LandingPageOtherLayout extends StatelessWidget {
  const LandingPageOtherLayout({
    super.key,
    required this.isDark,
    required this.mediaQuerySize,
  });

  final bool isDark;
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
              ),
              const SizedBox(width: 10),
              Text(
                "Notink",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? KColors.whiteColor
                          : KColors.blackColor,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: KColors.whiteColor,
                  ),
                  child: const Text("Login"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: KColors.blackColor,
                    backgroundColor: KColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Signup"),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Placeholder(
                fallbackHeight: mediaQuerySize.height / 2,
                color: isDark ? KColors.whiteColor : KColors.blackColor,
              ),
              const SizedBox(height: 20),
              Placeholder(
                fallbackHeight: mediaQuerySize.height / 2,
                color: isDark ? KColors.whiteColor : KColors.blackColor,
              ),
              const SizedBox(height: 20),
              Placeholder(
                fallbackHeight: mediaQuerySize.height / 2,
                color: isDark ? KColors.whiteColor : KColors.blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
