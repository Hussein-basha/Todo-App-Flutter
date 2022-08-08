import 'package:flutter/material.dart';
import 'package:todo_app/models/user/user_model.dart';


class UsersScreen extends StatelessWidget {
  List<UserModel> Users = [
    UserModel(
        id: 1,
        name: 'Hussein Basha',
        phone: '+201062794332',
    ),
    UserModel(
      id: 2,
      name: 'Ziad Basha',
      phone: '+201065556635',
    ),
    UserModel(
      id: 3,
      name: 'Akram Basha',
      phone: '+2010665565685',
    ),
    UserModel(
      id: 4,
      name: 'Ahmed Basha',
      phone: '+2010624545445',
    ),
    UserModel(
      id: 5,
      name: 'Amr Basha',
      phone: '+201062454545',
    ),
    UserModel(
      id: 6,
      name: 'Mahmoud Basha',
      phone: '+20106245455645',
    ),
    UserModel(
      id: 7,
      name: 'Zein Basha',
      phone: '+20106245455645',
    ),
    UserModel(
      id: 8,
      name: 'Abbas Basha',
      phone: '+20106245455645',
    ),
    UserModel(
      id: 9,
      name: 'Mohammed Basha',
      phone: '+20106245455645',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context,index) => buildUserItem(Users[index]),
          separatorBuilder: (context,index) => Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ) ,
          itemCount:Users.length,
      ),
    );
  }
  Widget buildUserItem(UserModel User) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            '${User.id}',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${User.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text(
              '${User.phone}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
