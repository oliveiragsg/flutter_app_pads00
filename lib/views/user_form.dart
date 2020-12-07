import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/data/myUser.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String,String> _formData = {};

  void _loadFormData(User user) {
    if(user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['password'] = user.password;
      _formData['avatarUrl'] = user.avatarURL;
    }
  }


  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);


    return Scaffold(
      appBar: AppBar(
        title: Text("Form de usuário"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _form.currentState.save();
             Provider.of<Users>(context, listen:false).put(
                User(
                  id: _formData['id'],
                  name: _formData['name'],
                  email: _formData['email'],
                  password: _formData['password'],
                  avatarURL: _formData['avatarURL'],
                )
              );
             myUser = User(
               id: _formData['id'],
               name: _formData['name'],
               email: _formData['email'],
               password: _formData['password'],
               avatarURL: _formData['avatarURL'],
             );
              //Navigator.of(context).pushNamed(AppRoutes.BOTNAVBAR);
              Navigator.of(context).pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _formData['name']=value,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email']=value,
              ),
              TextFormField(
                initialValue: _formData['password'],
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (value) => _formData['password']=value,
              ),
              TextFormField(
                initialValue: _formData['avatarURL'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarURL']=value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}