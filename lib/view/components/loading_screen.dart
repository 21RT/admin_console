import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader {
  static loader(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 300)
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  static loaderWaitPage(context) {
    return Material(
      child: Stack(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xFFFFB100),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 5)],
          )
        ],
      ),
    );
  }

  static dismiss(context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
