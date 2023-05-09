import 'package:flutter/material.dart';
import 'package:template_flutter/model/user_model.dart';
import 'package:template_flutter/viewmodel/user_viewmodel.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  late UserVieModel _userViewModel;

  @override
  void initState() {
    super.initState();
    _userViewModel = UserVieModel();
    _userViewModel.getUsers();
  }

  @override
  void dispose() {
    _userViewModel.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // if (_formKey.currentState.validate()) {
      Map<String, dynamic> user = {'name': _nameController.text, 'job': _emailController.text};
      // if (_userViewModel.usersStream.value.any((u) => u.email == user.email)) {
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text('Email already exists'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: Text('OK'),
      //           onPressed: () => Navigator.of(context).pop(),
      //         ),
      //       ],
      //     ),
      //   );
      // } else {
        _userViewModel.createUser(user);
        // _formKey.currentState.reset();
        _nameController.clear();
        _emailController.clear();
      // }
    // }
  }

  void _editForm(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit user'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                // controller: _nameController..text = user.name,
                validator: (value) {
                  // if (value.isEmpty) {
                  //   return 'Name is required';
                  // }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                // controller: _emailController..text = user.email,
                validator: (value) {
                  // if (value.isEmpty) {
                  //   return 'Email is required';
                  // } else if (!EmailValidator.validate(value)) {
                  //   return 'Invalid email format';
                  // }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              // _formKey.currentState.reset();
              _nameController.clear();
              _emailController.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('SAVE'),
            onPressed: () {
              // if (_formKey.currentState.validate()) {
              //   user.name = _nameController.text;
              //   user.email = _emailController.text;
              //   _userViewModel.updateUser(user);
              //   _formKey.currentState.reset();
              //   _nameController.clear();
              //   _emailController.clear();
              //   Navigator.of(context).pop();
              // }
            },
          ),
        ],
      ),
    );
  }

  void _deleteForm(Map<String, dynamic> user) {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('Delete user'),
    //     content: Text('Are you sure you want to delete ${user.name}?'),
    //     actions: <Widget>[
    //       TextButton(
    //         child: Text('CANCEL'),
    //         onPressed: () => Navigator.of(context).pop(),
    //       ),
    //       TextButton(
           
    //       child: Text('DELETE'),
    //       onPressed: () {
    //         _userViewModel.deleteUser(user);
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: _userViewModel.usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                UserModel user = snapshot.data![index];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(user.first_name),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // => _editForm(user)
                      },
                  ),
                  onLongPress: () {
                  // {=> _deleteForm(user)
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) => AlertDialog(
      //         title: Text('Add user'),
      //         content: Form(
      //           key: _formKey,
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: <Widget>[
      //               TextFormField(
      //                 controller: _nameController,
      //                 validator: (value) {
      //                   if (value.isEmpty) {
      //                     return 'Name is required';
      //                   }
      //                   return null;
      //                 },
      //                 decoration: InputDecoration(
      //                   labelText: 'Name',
      //                 ),
      //               ),
      //               TextFormField(
      //                 controller: _emailController,
      //                 validator: (value) {
      //                   if (value.isEmpty) {
      //                     return 'Email is required';
      //                   } else if (!EmailValidator.validate(value)) {
      //                     return 'Invalid email format';
      //                   }
      //                   return null;
      //                 },
      //                 decoration: InputDecoration(
      //                   labelText: 'Email',
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         actions: <Widget>[
      //           TextButton(
      //             child: Text('CANCEL'),
      //             onPressed: () {
      //               _formKey.currentState.reset();
      //               _nameController.clear();
      //               _emailController.clear();
      //               Navigator.of(context).pop();
      //             },
      //           ),
      //           TextButton(
      //             child: Text('SAVE'),
      //             onPressed: _submitForm,
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}