import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DomainWebView extends StatefulWidget {
  final String? link;
  DomainWebView({Key? key,this.link}) : super(key: key);

  @override
  DomainWebViewState createState() => DomainWebViewState();
}

class DomainWebViewState extends State<DomainWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: widget.link,
      ),
    );
  }
}