import 'package:flutter/material.dart';
import 'package:objectdetection/addrecipe.dart';
import 'package:objectdetection/camera_view.dart';

void main() => runApp(MyApp()); 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
  
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue,
        title: Text('Recipe App'),
        centerTitle: true,),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecipe()));
              }, child: Text('Add Recipe')),
              
              SizedBox(height: 100,),
          
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraView()));
              }, child: Text('Detect Ingredients'))
            ],
          ),
        )
      );
    
  }
}
 