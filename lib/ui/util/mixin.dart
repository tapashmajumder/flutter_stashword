import 'package:flutter/material.dart';

mixin CustomDialogMixin on Widget {
  List<Widget> _createActions({
    required final BuildContext context,
    required final void Function()? onClose
  }) {
    return [
      IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          if (onClose != null) {
            onClose();
          }
          Navigator.of(context).pop();
        },
      ),
    ];
  }

  void showCustomDialog({
    required final BuildContext context,
    required final Widget contentWidget,
    final String? title,
    final void Function()? onClose,
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
                  AppBar(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    title: Text(title ?? ""),
                    actions: _createActions(context: context, onClose: onClose),
                  ),
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
