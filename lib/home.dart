import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app_news/comment.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Comments> comment = [];

  Future<List<Comments>> getComment() async{
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if(response.statusCode==200){
      List data = jsonDecode(response.body);
      for(var element in data){
        comment.add(Comments.fromJson(element));
      }
    }

    return comment;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text('Comment Api App', style: TextStyle(fontSize: 28,
            fontWeight: FontWeight.bold
        ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 10),
            child: Icon(Icons.comment,size: 30,),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getComment(),
        builder: (context,snapShoot){
          if(snapShoot.hasData){
            return ListView.builder(
              itemCount: snapShoot.data!.length,
                itemBuilder: (context, index) => ListTile(
                 leading: Container(
                   margin: EdgeInsets.only(top: 10, right: 10),
                   child: CircleAvatar(
                     child: Text(snapShoot.data![index].id.toString(), style: TextStyle(fontSize: 23,
                     fontWeight: FontWeight.bold),),
                     radius: 30,
                     backgroundColor: Colors.black,
                   ),
                 ),
                  title: Text(snapShoot.data![index].email!, style: TextStyle(fontSize: 22,
                  fontWeight: FontWeight.bold),),
                  subtitle: Text(snapShoot.data![index].body!, style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold),),
                ));
          }else if(snapShoot.hasError){
            return Text('Error ayaa jiro');
          }

          return CircularProgressIndicator();
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.textsms),
              label: 'Comment'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
}

