import 'package:flutter/material.dart';

mixin CustomDialogMixin on Widget {
  void showCustomDialog({
    required final BuildContext context,
    required final Widget contentWidget,
    required final AppBar appBar,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Material(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  appBar,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: contentWidget, // Your dialog content goes here,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
