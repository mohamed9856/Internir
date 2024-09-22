import 'package:flutter/material.dart';
class Onecategory extends StatefulWidget {
  const Onecategory({super.key});

  @override
  State<Onecategory> createState() => _OnecategoryState();
}

class _OnecategoryState extends State<Onecategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
            "Programming",
            style: TextStyle(
              fontSize: 30,
              fontWeight:FontWeight.bold
          ),
        ) ,
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon:Icon(Icons.keyboard_backspace_sharp),iconSize: 40,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child:ListView(
          children: [
            ListTile(

            )
          ]
        ),

      ),
    );
  }
}
