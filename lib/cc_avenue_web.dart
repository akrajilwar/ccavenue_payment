import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../cc_avenue/data/payData.dart';
import '../cc_avenue/utility/urlList.dart';
import 'cc_avenue.dart';

class CcAvenueWeb extends StatefulWidget {
  const CcAvenueWeb({Key? key, this.data}) : super(key: key);
  final PaymentData? data;

  @override
  _CcAvenueWebState createState() => _CcAvenueWebState();
}

class _CcAvenueWebState extends State<CcAvenueWeb> {
  bool loading = true;
  late InAppWebViewController _webViewController;

  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  @override
  void initState() {
    super.initState();

    // _loadHTML();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            //title: new Text('Are you sure?'),
            content: const Text('Do you want to cancel this transaction ?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Payment'),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: InAppWebView(
                  initialSettings: settings,
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptEnabled: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useWideViewPort: false,
                        useHybridComposition: true,
                        loadWithOverviewMode: true,
                        domStorageEnabled: true,
                      ),
                      ios: IOSInAppWebViewOptions(
                          allowsInlineMediaPlayback: true,
                          enableViewportScale: true,
                          ignoresViewportScaleLimits: true)),
                  initialData: InAppWebViewInitialData(data: _loadHTML()),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadError: (controller, url, code, message) {
                    print(message);
                  },
                  onLoadStop:
                      (InAppWebViewController controller, Uri? pageUri) async {
                    setState(() {
                      loading = false;
                    });
                    print(pageUri.toString());
                    final page = pageUri.toString();

                    if (page == widget.data?.cancelUrl ||
                        page == widget.data?.redirectUrl) {
                      var html = await controller.evaluateJavascript(
                          source:
                              "window.document.getElementsByTagName('html')[0].outerHTML;");

                      String html1 = html.toString();
                      print(html1);
                      if (html1.contains('<body>')) {
                        html1 = html1.split('<body>')[1].split('</body>')[0];

                        RegExp exp = RegExp(r"<pre.*?>(.*)</pre>",
                            multiLine: true, dotAll: true);
                        Match? match = exp.firstMatch(html1);
                        if (match != null) {
                          String data = match.group(1) as String;
                          Map<String, dynamic> jsonData = jsonDecode(data);

                          CcAvenueService()
                              .handleCcAvenuePaymentStatus(context, jsonData);
                        }

                        //
                        // String status = map['order_status'];
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             PaymentStatus(resp: html1.toString())),
                        //     (Route<dynamic> route) => false);
                      }
                    }
                  },
                ),
              ),
              (loading)
                  ? const Center(child: CircularProgressIndicator())
                  : const Center(),
            ],
          ),
        ),
      ),
    );
  }

  String _loadHTML() {
    final url = UrlList.ccAvenue_payment_url;
    const command = "initiateTransaction";
    final encRequest = widget.data?.encVal;
    final accessCode = widget.data?.accessCode;

    String html =
        "<html> <head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$url'>" +
            "<input type='hidden' name='command' value='$command'/>" +
            "<input type='hidden' name='encRequest' value='$encRequest' />" +
            "<input  type='hidden' name='access_code' value='$accessCode' />";
    print(html);
    return html + "</form> </body> </html>";
  }
}
