import 'package:flutter/material.dart';

import '../data/model/user.dart';
import '../data/repo/user_repo.dart';
import 'widget/item_user.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return MyAppState();
  }

}


class MyAppState extends State<MyApp> {
  UserRepo userRepo = UserRepo();

  List<User> list = [];

  @override
  void initState() {
    super.initState();

    userRepo.getUsers().then((users) {
      setState(() {
        list.addAll(users);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Counter app")
        ),
        body: listDataUser(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showUserDialog(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget listDataUser() {
    return Container(
        color: Colors.white70,
        child: ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => showUserDialog(list[index]),
              onLongPress: () => showDialogDelete(list[index]),
              child: ItemUser(list[index])
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
    );
  }

  void showUserDialog(User? user){
    TextEditingController nameController =  TextEditingController()..text = user?.name ?? '';
    TextEditingController usernameController = TextEditingController()..text = user?.username ?? '';
    TextEditingController passwordController = TextEditingController()..text = user?.password ?? '';
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 350,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                user == null ? Text("Add user") : Text("Update user"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(label: Text("name"),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(label: Text("username"),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(label: Text("password"),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: (){
                          user == null
                          ? addUser(User.create(nameController.text, nameController.text, nameController.text))
                          : updateUser(user
                            ..name = nameController.text
                            ..username = usernameController.text
                            ..password = passwordController.text
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: user == null ? Text("add") : Text("update"),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDialogDelete(User user) {
    showDialog(context: context, builder: (contetx) => AlertDialog(
      title: Text("Bạn có muốn xóa ${user.name} không?"),
      actions: [
        GestureDetector(
            onTap: (){
              Navigator.pop(contetx);
              },
            child: Text("Không")),
        GestureDetector(
            onTap: (){
              deleteUser(user);
              Navigator.pop(contetx);
              },
            child: Text("Có")
        )
      ],
    )
    );
  }

  void addUser(User user) {
    userRepo.addUser(user)
        .then((userAdd){
      setState(() {
        list.add(userAdd);
      });
      var snackBar = SnackBar(content: Text("Add thành công"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    );
  }

  void updateUser(User user) {
    userRepo.updateUser(user)
        .then((userUpdate){
      setState(() {
      });
      var snackBar = SnackBar(content: Text("Update thành công"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    );
  }

  void deleteUser(User user) {
    userRepo.deleteUser(user)
        .then((userUpdate){
      setState(() {
        list.remove(user);
      });
      var snackBar = SnackBar(content: Text("delete thành công"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    );
  }
}