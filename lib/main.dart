import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class ImageModel{
  int id;
  String url;
  String title;

  ImageModel(this.id, this.url, this.title);

}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter App Quiz',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override 
  MyHomePageState createState()=>MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>{
  int ctr = 0;
  List<ImageModel>images=[];

  void fetchImage() async{
    ctr++;

    var res = await http.get('https://jsonplaceholder.typicode.com/photos/$ctr');
    var parsed = json.decode(res.body);

    images.add(new ImageModel(parsed['id'], parsed['url'], parsed['title']));
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's See Some Images!"),
      ),
      body:
        ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index){
            return Card(
              child: Column(  
                children: <Widget>[
                  Image.network(images[index].url),
                  Text(images[index].title)
                ],
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton( 
        onPressed: fetchImage,
        child: Icon(Icons.add)
      ),

    );
  }

}