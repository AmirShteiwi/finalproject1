import 'package:diet_app/provider_model/user_provider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      await context.read<UserProvider>().logout();
    }

    return AppBar(
      backgroundColor: Colors.green,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Cabin'),
      ),
      leading: title != "Home" && title != "Profile" && title != "Contact Us"
          ? IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      actions: [
        Visibility(
            visible:
                title == "Home" || title == "Profile" || title == "Contact Us",
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                logout();
                Navigator.pushReplacementNamed(context, '/sign-in-screen');
              },
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
