import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payment/models/gopay.dart';
import 'package:payment/services/midtrans_service.dart';

class PaymentGopayPage extends StatefulWidget {
  PaymentGopayPage({required this.gopay});
  Gopay gopay;

  @override
  _PaymentGopayPageState createState() => _PaymentGopayPageState();
}

class _PaymentGopayPageState extends State<PaymentGopayPage> {
  final MidtransService midtransService = MidtransService();

  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides(); //utk mengahpus sertifikasi ssl (tdk di sarankan utk mode produksi)| ini stl
  }

  void _cekStatus(BuildContext context)async{
    final response = await midtransService.cekStatusGopay(widget.gopay.status);
    if(int.parse(response['status_code']) == 201){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        btnOkOnPress: (){},
        title: 'Status ${response['transaction_status']}',
        desc: response['status_message'],
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        btnOkOnPress: (){},
        title: 'Error',
        desc: response['status_message'],
      ).show();
    }
  }

  void _cekGopay(BuildContext context)async{
    final response = await midtransService.cekPaymentGopay(widget.gopay.status);
    if(response['success'] == true){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        btnOkOnPress: (){},
        title: 'Status ${response['data']['transaction_status']}',
        desc: response['data']['status_message'],
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        btnOkOnPress: (){},
        title: 'Error',
        desc: response['message'],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.string(starIcon),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(gopay: widget.gopay),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  gopay: widget.gopay,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(gopay: widget.gopay),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFFF7643),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              onPressed: () => _cekGopay(context),
              child: const Text("Cek Status"),
            ),
          ),
        ),
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class ProductImages extends StatefulWidget {
  const ProductImages({required this.gopay});

  final Gopay gopay;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(imageUrl: widget.gopay.gambar, fit: BoxFit.cover, errorWidget: (context, url, error) => Icon(Icons.broken_image, size: 120,),),
          ),
        ),
      ],
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    required this.gopay,
    this.pressOnSeeMore,
  });

  final Gopay gopay;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'ORDER-ID: ${gopay.orderID}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6F9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.string(
              heartIcon,
              colorFilter: ColorFilter.mode( const Color(0xFFFF4848),
                  BlendMode.srcIn),
              height: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  'Pembayaran melalui Gopay Sebesar: ${gopay.total}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ColorDots extends StatelessWidget {
  const ColorDots({
    required this.gopay,
  });

  final Gopay gopay;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 120,
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Transaksi: ${gopay.waktuTransaksi}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ),
          const Spacer(),
          SizedBox(
            height: 50,
            width: 120,
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Expired: ${gopay.Expired}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          )
        ],
      ),
    );
  }
}

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

const starIcon =
    '''<svg width="13" height="12" viewBox="0 0 13 12" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M12.7201 5.50474C12.9813 5.23322 13.0659 4.86077 12.9476 4.50957C12.8292 4.15777 12.5325 3.90514 12.156 3.83313L9.12773 3.25704C9.03883 3.23992 8.96219 3.18621 8.91743 3.11007L7.41279 0.515295C7.22517 0.192424 6.88365 0 6.49983 0C6.116 0 5.7751 0.192424 5.58748 0.515295L4.08284 3.11007C4.03808 3.18621 3.96144 3.23992 3.87192 3.25704L0.844252 3.83313C0.467173 3.90514 0.171028 4.15777 0.0526921 4.50957C-0.0662565 4.86077 0.0189695 5.23322 0.280166 5.50474L2.37832 7.68397C2.43963 7.74831 2.46907 7.83508 2.45803 7.92185L2.09199 10.8725C2.04661 11.2397 2.20419 11.5891 2.51566 11.8063C2.6996 11.935 2.91236 11.9999 3.12696 11.9999C3.27595 11.9999 3.42617 11.9687 3.56842 11.9055L6.36984 10.6577C6.45262 10.6211 6.54704 10.6211 6.62981 10.6577L9.43185 11.9055C9.7795 12.0601 10.1725 12.0235 10.484 11.8063C10.7955 11.5891 10.9537 11.2397 10.9083 10.8725L10.5416 7.92244C10.5306 7.83508 10.56 7.74831 10.6226 7.68397L12.7201 5.50474Z" fill="#FFC416"/>
</svg>
''';

const heartIcon =
    '''<svg width="18" height="16" viewBox="0 0 18 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5266 8.61383L9.27142 15.8877C9.12207 16.0374 8.87889 16.0374 8.72858 15.8877L1.47343 8.61383C0.523696 7.66069 0 6.39366 0 5.04505C0 3.69644 0.523696 2.42942 1.47343 1.47627C2.45572 0.492411 3.74438 0 5.03399 0C6.3236 0 7.61225 0.492411 8.59454 1.47627C8.81857 1.70088 9.18143 1.70088 9.40641 1.47627C11.3691 -0.491451 14.5629 -0.491451 16.5266 1.47627C17.4763 2.42846 18 3.69548 18 5.04505C18 6.39366 17.4763 7.66165 16.5266 8.61383Z" fill="#DBDEE4"/>
</svg>
''';