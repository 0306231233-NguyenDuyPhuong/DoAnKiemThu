import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http show Client;

import '../models/users.dart';
import '../widgets/my_colors.dart';
import 'home_screen.dart';

class login extends StatefulWidget{
  _login createState()=>_login();
}

class _login extends State<login>{
  @override
  var txt1=TextEditingController();
  var txt2=TextEditingController();
  Widget build(Object context) {
    return Scaffold(
      backgroundColor: ShopeeColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SHOPPING NOW",style: TextStyle(fontSize: 30,color: ShopeeColors.textDark),),
            Padding(padding: EdgeInsetsGeometry.all(10),child: TextField(
              decoration: InputDecoration(
                label: Text("Tên đăng nhập : ",style: TextStyle(color: ShopeeColors.textDark),),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ShopeeColors.primaryLight,width: 1.5)
                ),
              ),
              controller: txt1,
            )
            ),
            Padding(padding: EdgeInsetsGeometry.all(10),child: TextField(
              decoration: InputDecoration(
                  label: Text("Mật khẩu : "),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  )
              ),
              controller: txt2,
            )
            ),
            Padding(padding: EdgeInsetsGeometry.all(10),child: ElevatedButton(onPressed: (){
              if(txt1.text.isEmpty || txt2.text.isEmpty){
                final snackBar = SnackBar(
                  content: const Text('Vui lòng nhập đầy đủ thông tin'),
                );

                ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
              }else{
                var result=Login(txt1.text, txt2.text);
                if(txt1.text.toString()=="quygoku321" && txt2.text.toString() =="123456789")
                {
                  showDialog(context: context as BuildContext, builder:(context)=>AlertDialog(
                    title: Text("Đăng Nhập thất bại"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("OK"))
                    ],
                  )
                  );
                }else{
                  result.then((e)=>{
                    if(e==true)
                      {
                        showDialog(context: context as BuildContext, builder:(context)=>AlertDialog(
                          title: Text("Đăng Nhập thành Công"),
                          actions: [
                            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));}, child: Text("OK"))
                          ],
                        )
                        )
                      }
                  }

                  );
                }

              }
            }, child: Text("Đăng Nhập",style: TextStyle(fontSize: 15,color: ShopeeColors.textDark),)),)
          ],
        ),
      ),
    );
  }
}

Future<bool> Login(String name,String pass) async {
  bool a=false;
  var url=Uri.parse("https://dummyjson.com/user/login");
  var Client=http.Client();
  User b=User(username: name,password: pass);
  try{
    var res = await Client.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(b.toJson()),
    );
    var result=jsonDecode(res.body);
    print(result['accessToken']);
    if(result['accessToken']!="")
    {
      a=true;
    }
    else
    {
      a=false;
    }
  }finally{
    Client.close();
  }
  return a;
}
