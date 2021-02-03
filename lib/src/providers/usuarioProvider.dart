import 'dart:convert';

import 'package:aplicacion_web/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;


class UsusarioProvider{

final String _firebaseToken = 'AIzaSyB9BrfIxSDFPMmSvoWNfqfgQndxlxaw20k';
final _prefs = new PreferenciasUsuario();

Future<Map<String, dynamic>> login(String email, String password)async{
     
  final authData = {
    "email"   : email,
    "password": password,
    "returnSecureToken": true
    };

   final resp = await http.post( 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken', 
   body: json.encode(authData));


  Map<String, dynamic> decodeResp = json.decode(resp.body);
  print(decodeResp);

  if (decodeResp.containsKey('idToken')){

    _prefs.token = decodeResp['idToken'];

    return {'ok': true, 'token': decodeResp['idToken']};
  }else{
    return {'ok': false, 'mensaje': decodeResp['error']['message']};
  }

}

 Future nuevoUsuario(String email, String password )async{

    final authData = {
      "email"   : email,
      "password": password,
      "returnSecureToken": true
    };

    final resp = await http.post( 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken', 
    body: json.encode(authData));


  Map<String, dynamic> decodeResp = json.decode(resp.body);
  print(decodeResp);

  if (decodeResp.containsKey('idToken')){

    _prefs.token = decodeResp['idToken'];

    return {'ok': true, 'token': decodeResp['idToken']};
  }else{
    return {'ok': false, 'mensaje': decodeResp['error']['message']};
  }



  }




}