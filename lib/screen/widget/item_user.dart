
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/user.dart';

class ItemUser extends StatelessWidget{
  User user;
  ItemUser(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("id: ${user.id }"),
            Text("name: ${user.name}"),
            Text("username: ${user.username}"),
            Text("password: ${user.password}"),
          ],
        ),
      ),
    );
  }

}