// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _politicianCards()));
  }

  _politicianCards() {
    return [
      new Column(
        children: [
          new Image.network(
              'http://www.camara.leg.br/internet/deputado/bandep/160553.jpg'),
          new Text(
            'ANTONIO BRITO',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16.0,
            ),
          ),
          new Text(
            'PSD/BA',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
      new Column(
        children: [
          new Image.network(
              'http://www.camara.leg.br/internet/deputado/bandep/160600.jpg'),
          new Text(
            'ARTHUR OLIVEIRA MAIA',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16.0,
            ),
          ),
          new Text(
            'PPS/BA',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ];
  }
}
