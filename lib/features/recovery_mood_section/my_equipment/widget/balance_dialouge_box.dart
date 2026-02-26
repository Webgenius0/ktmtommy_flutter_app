import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';

// Custom Balance Option Button Widget
class BalanceOptionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const BalanceOptionButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, color: Colors.white, ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Main Balance Dialog
class BalanceDialog extends StatelessWidget {
  const BalanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white38, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.logo225),
            const SizedBox(height: 16),
            // Question text
            const Text(
              "How balanced was your day?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Subtext
            const Text(
              "You logged 3 items today",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Options using custom button widget
            Column(
              children: [
                // Best
                BalanceOptionButton(
                  title: "Best",
                  subtitle: "Perfect balance today",
                  icon: AppIcons.bestIcon,
                  color: Colors.amber,
                  textColor: Colors.black,
                  onPressed: () {
                    print("Best tapped");
                    // Add your best option logic here
                  },
                ),
                const SizedBox(height: 12),
                // Good
                BalanceOptionButton(
                  title: "Good",
                  subtitle: "Solid day overall",
                  icon: AppIcons.goodIcon,
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    print("Good tapped");
                    // Add your good option logic here
                  },
                ),
                const SizedBox(height: 12),
                // Poor
                BalanceOptionButton(
                  title: "Poor",
                  subtitle: "Room to improve",
                  icon: AppIcons.poorIcon,
                  color: Colors.grey,
                  textColor: Colors.white,
                  onPressed: () {
                    print("Poor tapped");
                    // Add your poor option logic here
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Skip button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white70,
              ),
              child: const Text(
                "Skip for now",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Optional: Theme extension for custom button styling
class BalanceDialogTheme {
  static ThemeData get theme {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Example of how to use the dialog
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const BalanceDialog(),
            );
          },
          child: const Text('Show Balance Dialog'),
        ),
      ),
    );
  }
}