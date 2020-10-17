import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String,String> _formData = {};

  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).pop();
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
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _formData['name']=value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email']=value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (value) => _formData['password']=value,
              ),
              TextFormField(
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