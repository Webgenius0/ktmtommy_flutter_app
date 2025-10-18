import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HtmlToWidgetRenderer extends StatelessWidget {
  final String htmlData;

  const HtmlToWidgetRenderer({super.key, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: HtmlWidget(
        htmlData,
        // Specify custom styles for certain elements
        customStylesBuilder: (element) {
          if (element.localName == 'p') {
            return {
              'font-size': '17px',
              'line-height': '1.8',
              'font-family': GoogleFonts.poppins().fontFamily ?? 'default-font'
            };
          }
          if (element.localName == 'strong') {
            return {'font-weight': 'bold', 'color': 'black'};
          }
          if (element.localName == 'em') {
            return {'font-style': 'italic', 'color': 'gray'};
          }
          return null;
        },

        // Custom widget builder based on attributes
        customWidgetBuilder: (element) {
          if (element.attributes['foo'] == 'bar') {
            return FooBarWidget(); // Custom block widget
          }
          if (element.attributes['fizz'] == 'buzz') {
            return InlineCustomWidget(
              child: FizzBuzzWidget(), // Inline custom widget
            );
          }
          return null;
        },

        // Callback when user taps a link
        onTapUrl: (url) {
          print('Tapped URL: $url');
          // Handle URL tap, you could open it in a browser or navigate to a page
          return true; // Ensure a boolean value is returned
        },

        // Choose the rendering mode
        renderMode: RenderMode
            .column, // You can change this to RenderMode.listView or SliverList for better performance

        // Default styling for text
        textStyle: TextStyle(
            fontSize: 14.sp, fontFamily: GoogleFonts.poppins().fontFamily),
      ),
    );
  }
}

// Custom widget for 'foo' attribute
class FooBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
          child: Text('Custom FooBar Widget',
              style: TextStyle(color: Colors.white))),
    );
  }
}

// Custom inline widget for 'fizz' attribute
class InlineCustomWidget extends StatelessWidget {
  final Widget child;

  const InlineCustomWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [child, Text('Inline Custom Widget')],
    );
  }
}

// Another custom widget for 'fizzbuzz' functionality
class FizzBuzzWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
          child: Text('FizzBuzz Widget',
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ))),
    );
  }
}