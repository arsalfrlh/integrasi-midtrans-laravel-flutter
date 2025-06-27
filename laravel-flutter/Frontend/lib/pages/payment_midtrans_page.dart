import 'package:flutter/material.dart';
import 'package:payment/pages/midtrans_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentMidtransPage extends StatefulWidget {
  PaymentMidtransPage({required this.snapToken});
  final String snapToken;

  @override
  State<PaymentMidtransPage> createState() => _PaymentMidtransPageState();
}

class _PaymentMidtransPageState extends State<PaymentMidtransPage> {
  WebViewController? webViewController;
  // int loadingProgress = 0; untuk proses

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progress) { //function saat membuka dan memproses web
          //   setState(() {
          //     loadingProgress = progress;
          //   });
          // },
          onPageStarted: (String url) {
            if (url.contains("status_code=202&transaction_status=deny")) { //function saat pembayaran gagal
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MidtransPage(),
              ));
            }
            if (url.contains("status_code=200&transaction_status=settlement")) { //function saat pembayaran berhasil
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    MidtransPage(),
              ));
            }
          },
          // onPageFinished: (String url) { //function saat selesai mengload web
          //   setState(() {
          //     loadingProgress = 100;
          //   });
          // },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran Midtrans'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: WebViewWidget(controller: webViewController!),
      )
    );
  }
}
