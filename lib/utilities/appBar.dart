import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget {
//   String? title;
//   Widget? leading;
//   List<Widget>? actions;

//   CustomAppBar({super.key, this.title, this.leading, this.actions});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.white,
//       title: Text(
//         title!,
//         style: TextStyle(fontSize: 25, color: Colors.black),
//       ),
//       leading: leading,
//       actions: actions,
//     );
//   }
// }
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  Widget? leading;
  List<Widget>? actions;

  CustomAppBar({this.title, this.leading, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
       title??"",
        style: const TextStyle(fontSize: 25, color: Colors.black),
      ),
      leading: leading,
      actions: actions,
    );
  }
}
