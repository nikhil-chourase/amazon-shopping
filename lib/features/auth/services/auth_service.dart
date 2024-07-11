
import 'dart:convert';

import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

 
class AuthService{
  // Sign up user

  
  void signUpUser( {
    required BuildContext context,
    required String email, 
    required String password, 
    required String name}) async{

    try{

      User user = User(
           id: '',
           name: name, 
           email: email, 
           password: password, 
           address: '', 
           type: '', 
           token: '', cart: [],
        );


        http.Response res = await http.post(
          Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String,String>{
            'Content-Type': 'application/json; charlset=UTF-8',
          }  
        );

        httpErrorHandle(
          response: res, 
          context: context, 
          
          onSuccess: (){
           showSnackBar(context, 'Account created! Login with same credentials!');
        });

        print(res.statusCode);

    }
    catch(e){
      showSnackBar(context, e.toString());
    }

  }


  void signInUser( {
    required BuildContext context,
    required String email, 
    required String password,}) async{

    try{

        http.Response res = await http.post(
          Uri.parse("$uri/api/signin"),
          body: jsonEncode(
            {
              "email": email,
              "password": password,
            }
          ),
          headers: <String,String>{
            'Content-Type': 'application/json; charlset=UTF-8',
          }  
        );

        print(res.body);

        httpErrorHandle(
          response: res, 
          context: context, 
          
          onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        });

        print(res.statusCode);

    }
    catch(e){
      showSnackBar(context, e.toString());
    }

  }

  
  void getUserData( {
    required BuildContext context,
   }) async{

    try{

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token =  prefs.getString('x-auth-token');

      if(token == null){
        prefs.setString('x-auth-token', '');
      }


      http.Response tokenRes = await http.post(
        Uri.parse("$uri/tokenIsValid"), 
       headers: <String,String> {
          'Content-Type': 'application/json; charlset=UTF-8',
          'x-auth-token': token!
       }
      );


      var response = jsonDecode(tokenRes.body);


      if(response == true){

        //get user data

        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String,String> {
          'Content-Type': 'application/json; charlset=UTF-8',
          'x-auth-token': token
          }
        );

        var userProvider = Provider.of<UserProvider>(context,listen: false);

        userProvider.setUser(userRes.body);

      }












      
        // http.Response res = await http.post(
        //   Uri.parse("$uri/api/signin"),
        //   body: jsonEncode(
        //     {
        //       "email": email,
        //       "password": password,
        //     }
        //   ),
        //   headers: <String,String>{
        //     'Content-Type': 'application/json; charlset=UTF-8',
        //   }  
        // );

        // print(res.body);

        // httpErrorHandle(
        //   response: res, 
        //   context: context, 
          
        //   onSuccess: () async {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        //   await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        //   Navigator.pushNamedAndRemoveUntil(
        //     context,
        //     HomeScreen.routeName,
        //     (route) => false,
        //   );
        // });

        // print(res.statusCode);

    }
    catch(e){
      showSnackBar(context, e.toString());
    }

  }
}