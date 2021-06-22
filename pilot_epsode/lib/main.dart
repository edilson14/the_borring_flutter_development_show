import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'src/article.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> _articles = articles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
          setState(
            () {
              _articles.removeAt(0);
            },
          );
        },
        child: ListView(
          children: _articles.map(_buildItem).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(Articles article) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        trailing: Icon(Icons.all_out_outlined),
        title: Text(
          article.text,
          style: TextStyle(fontSize: 24),
        ),
        // subtitle:
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${article.commentsCount} comments',
              ),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  if (await canLaunch(article.domain)) {
                    launch(article.domain);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
