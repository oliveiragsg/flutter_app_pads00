

import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/models/user.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:provider/provider.dart';

class PartnerTile extends StatelessWidget {
  final User user;
  const PartnerTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarURL==null || user.avatarURL.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarURL));

    return GestureDetector(
      onTap: message,
      onLongPress: () {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Excluir Usuário'),
              content: Text('Tem certeza disso?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Provider.of<Users>(context, listen: false).remove(user);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Não'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.black,
                width: 2.0),
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: ListTile(
          leading: avatar,
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: Container(
            width: 50,
            child: Row(
              children: <Widget>[
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool message() {
  print("Enviar pra tela de Pombo Correio (Mensagem com este usuario)!!!!!");
  return true;
}
