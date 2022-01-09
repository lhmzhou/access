import 'package:flutter/material.dart';
import 'pages/funds_list/funds_list_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    //SystemChrome.setEnabledSystemUIOverlays([]); // Enter fullscreen
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); // Exit fullscreen
    
    return new MaterialApp
    (
      title: 'access',
      theme: new ThemeData(primarySwatch: Colors.purple),
      home: new FundsListPage(),
    );
  }
}