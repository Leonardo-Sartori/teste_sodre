import 'package:flutter/material.dart';
import 'package:teste_sodre/data/models/user.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListTile(
            title: Text(user.name, style: textStyle()),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(child: Text(user.email, style: textStyle())),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(child: Text("${user.age.toString()} ano(s)", style: textStyle())),
                  ],
                ),
              ],
            ),
            dense: true,
          ),
        ],
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis);
  }
}