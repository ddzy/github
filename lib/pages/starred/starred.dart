import 'package:flutter/material.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StarredPageState();
  }
}

class _StarredPageState extends State<StarredPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我赞过的'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: ListView.builder(itemCount: 0, itemBuilder: (context, index) {
        
      }),
    );
  }
}
