import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:midtrans/pages/create/create_page.dart';

class CancelPage extends StatefulWidget {
  const CancelPage({super.key});

  @override
  State<CancelPage> createState() => _CancelPageState();
}

class _CancelPageState extends State<CancelPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        dismissOnTouchOutside: false,
        title: 'Cancel',
        desc: 'Pembayaran Dibatalkan',
        btnOkOnPress: (){},
        btnOkColor: Colors.red,
      ).show();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(
                    noPaymentMethodsIllistration,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Payment Cancelled",
                description:
                    "Pembayaran Anda telah di batalkan, Maaf jika ada kesalahan atau ketidak nyamanan dalam pembayaran",
                btnText: "Kembali",
                press: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreatePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Text(btnText ?? "Retry".toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

const noPaymentMethodsIllistration = '''
<svg width="831" height="852" viewBox="0 0 831 852" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M8.46013 532.49H27.1001C65.521 532.49 103.566 540.058 139.062 554.761C174.558 569.464 206.811 591.014 233.978 618.182C261.146 645.35 282.697 677.602 297.4 713.099C312.103 748.595 319.67 786.639 319.67 825.06V843.7C319.67 845.713 318.87 847.644 317.447 849.067C316.024 850.491 314.093 851.29 312.08 851.29H8.46013C6.44714 851.29 4.51659 850.491 3.09319 849.067C1.66978 847.644 0.870117 845.713 0.870117 843.7V540.08C0.870117 538.067 1.66978 536.137 3.09319 534.713C4.51659 533.29 6.44714 532.49 8.46013 532.49Z" fill="#ABABAB"/>
<path d="M204.3 299.41H633.11C641.066 299.41 648.697 302.571 654.323 308.197C659.949 313.823 663.11 321.454 663.11 329.41V670.51C663.11 676.703 660.65 682.642 656.271 687.021C651.892 691.4 645.953 693.86 639.76 693.86H622.48V389.57C622.48 385.993 621.775 382.452 620.406 379.147C619.037 375.843 617.03 372.841 614.501 370.312C611.971 367.783 608.968 365.778 605.663 364.41C602.359 363.042 598.817 362.339 595.24 362.34L183.17 362.41V320.54C183.17 314.936 185.396 309.562 189.359 305.599C193.321 301.636 198.696 299.41 204.3 299.41Z" fill="#E2E2E2"/>
<path d="M622.48 709.33H673C678.039 709.33 682.872 707.328 686.435 703.765C689.998 700.202 692 695.369 692 690.33V307.33C692 300.434 689.261 293.821 684.385 288.945C679.509 284.069 672.896 281.33 666 281.33H177C166.126 281.33 155.698 285.65 148.009 293.339C140.32 301.028 136 311.456 136 322.33C136 333.204 140.32 343.632 148.009 351.321C155.698 359.01 166.126 363.33 177 363.33H596.48C603.376 363.33 609.989 366.069 614.865 370.945C619.741 375.821 622.48 382.434 622.48 389.33V734.33C622.48 739.369 620.478 744.202 616.915 747.765C613.352 751.328 608.519 753.33 603.48 753.33H159.31C156.247 753.331 153.214 752.729 150.384 751.556C147.554 750.384 144.982 748.666 142.817 746.499C140.652 744.332 138.936 741.759 137.766 738.928C136.596 736.097 135.996 733.063 136 730V322.33" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M692 446.4H796.37C800.818 446.4 805.083 448.167 808.228 451.312C811.373 454.457 813.14 458.723 813.14 463.17V535.07C813.14 539.518 811.373 543.784 808.228 546.929C805.083 550.074 800.818 551.84 796.37 551.84H692V446.4Z" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M778.57 536.4C794.31 536.4 807.07 523.641 807.07 507.9C807.07 492.16 794.31 479.4 778.57 479.4C762.83 479.4 750.07 492.16 750.07 507.9C750.07 523.641 762.83 536.4 778.57 536.4Z" fill="#E2E2E2"/>
<path d="M770.57 527.4C786.31 527.4 799.07 514.641 799.07 498.9C799.07 483.16 786.31 470.4 770.57 470.4C754.83 470.4 742.07 483.16 742.07 498.9C742.07 514.641 754.83 527.4 770.57 527.4Z" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M622.48 483.9H672.14" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M622.48 570.9H672.14" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M622.48 657.89H672.14" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M742.07 90.54C739.71 91.2067 737.323 91.9501 734.91 92.7701" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M721.14 98.5503C668.86 124.04 614.14 190.23 635.49 251.23C648.49 279.33 687.1 265.79 701.61 225.39C721.9 169.25 679.13 140.28 622.61 196.39C592.8 227 558.52 276.93 524.22 332.26" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" stroke-dasharray="14.95 14.95"/>
<path d="M520.29 338.62L516.37 345.02" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M318.73 331.34C297.923 261.34 252.737 217.34 183.17 199.34" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" stroke-dasharray="15 15"/>
<path d="M357.72 331.34C342.72 273.34 349.72 229.34 378.72 199.34" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" stroke-dasharray="15 15"/>
<path d="M166.106 193.34C168.599 187.988 162.568 179.899 152.636 175.271C142.704 170.644 132.631 171.231 130.137 176.583C127.644 181.935 133.675 190.024 143.607 194.651C153.539 199.279 163.612 198.692 166.106 193.34Z" fill="#0E0E0E"/>
<path d="M130.796 176.759C132.161 173.831 130.893 170.35 127.964 168.986C125.035 167.622 121.555 168.89 120.191 171.818C118.826 174.747 120.094 178.227 123.023 179.592C125.952 180.956 129.432 179.688 130.796 176.759Z" fill="#0E0E0E"/>
<path d="M158.723 162.924L153.752 174.404C152.742 176.738 150.846 178.575 148.481 179.511C146.116 180.447 143.476 180.405 141.142 179.395C138.808 178.384 136.971 176.488 136.035 174.123C135.099 171.758 135.141 169.118 136.151 166.784L145.333 145.576C145.531 145.119 145.903 144.758 146.366 144.575C146.83 144.391 147.348 144.4 147.805 144.598L152.219 146.509C153.725 147.159 155.087 148.1 156.229 149.277C157.37 150.454 158.269 151.844 158.873 153.369C159.477 154.893 159.774 156.522 159.748 158.161C159.723 159.801 159.374 161.419 158.723 162.924Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M167.18 175.004L163.974 182.409C163.321 183.916 162.097 185.102 160.571 185.706C159.044 186.31 157.34 186.283 155.834 185.63C154.327 184.978 153.142 183.754 152.538 182.228C151.933 180.701 151.961 178.997 152.613 177.491L158.537 163.808C158.6 163.661 158.692 163.528 158.807 163.416C158.922 163.305 159.058 163.217 159.207 163.158C159.356 163.099 159.515 163.07 159.676 163.073C159.836 163.075 159.994 163.109 160.141 163.173L162.986 164.405C164.945 165.253 166.487 166.845 167.273 168.83C168.058 170.815 168.023 173.031 167.175 174.99L167.18 175.004Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M117.091 206.131L127.418 185.456C128.554 183.181 130.548 181.45 132.96 180.645C135.373 179.839 138.007 180.025 140.282 181.162C142.557 182.298 144.288 184.292 145.094 186.705C145.899 189.117 145.713 191.751 144.576 194.026L138.987 205.218C137.508 208.179 134.913 210.432 131.773 211.48C128.634 212.528 125.207 212.286 122.245 210.807L117.942 208.657C117.72 208.548 117.522 208.396 117.359 208.209C117.195 208.023 117.071 207.806 116.992 207.571C116.913 207.336 116.881 207.088 116.898 206.841C116.915 206.594 116.981 206.353 117.091 206.131Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M139.55 204.508L146.213 191.169C146.946 189.7 148.233 188.583 149.79 188.063C151.347 187.544 153.047 187.664 154.516 188.397C155.985 189.131 157.102 190.418 157.622 191.975C158.142 193.532 158.022 195.232 157.288 196.701L153.682 203.92C153.21 204.866 152.556 205.709 151.757 206.402C150.959 207.095 150.032 207.624 149.029 207.959C148.027 208.294 146.968 208.428 145.913 208.353C144.859 208.279 143.829 207.997 142.883 207.525L140.11 206.14C139.821 205.995 139.601 205.742 139.498 205.435C139.396 205.128 139.419 204.793 139.564 204.503L139.55 204.508Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M122.52 169.24C121.212 167.884 120.29 166.203 119.85 164.37" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M119.72 175.24C118.32 174.707 116.503 175.07 114.27 176.33" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M783.056 58.6985C789.906 43.9953 789.039 29.0848 781.119 25.3951C773.199 21.7054 761.226 30.6336 754.376 45.3369C747.526 60.0401 748.393 74.9506 756.313 78.6403C764.233 82.33 776.206 73.4018 783.056 58.6985Z" fill="#0E0E0E"/>
<path d="M792.353 22.188C794.373 17.8526 792.496 12.7007 788.16 10.681C783.825 8.66117 778.673 10.5384 776.653 14.8738C774.633 19.2091 776.511 24.361 780.846 26.3808C785.181 28.4005 790.333 26.5234 792.353 22.188Z" fill="#0E0E0E"/>
<path d="M801.299 67.7449L784.313 60.3907C780.865 58.892 778.152 56.086 776.771 52.5888C775.39 49.0917 775.453 45.1894 776.947 41.7389C778.444 38.2953 781.244 35.5853 784.735 34.2025C788.226 32.8196 792.123 32.8767 795.572 34.3612L826.956 47.9491C827.635 48.2431 828.17 48.7948 828.442 49.4829C828.714 50.1709 828.702 50.9389 828.408 51.618L825.579 58.1519C823.633 62.6472 819.981 66.1853 815.426 67.9878C810.871 69.7902 805.787 69.7095 801.292 67.7633L801.299 67.7449Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M783.415 80.2694L772.458 75.5256C770.229 74.5604 768.474 72.7491 767.58 70.4901C766.686 68.2312 766.726 65.7097 767.691 63.4803C768.657 61.2508 770.468 59.4962 772.727 58.6023C774.986 57.7083 777.507 57.7484 779.737 58.7136L799.981 67.4782C800.419 67.6679 800.764 68.0238 800.939 68.4677C801.115 68.9116 801.107 69.4071 800.918 69.8452L799.094 74.0574C797.838 76.9585 795.481 79.2419 792.541 80.4052C789.602 81.5685 786.32 81.5163 783.419 80.2603L783.415 80.2694Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M737.338 6.06259L767.934 21.3439C769.609 22.1745 771.103 23.3277 772.33 24.7375C773.558 26.1472 774.495 27.7856 775.088 29.5586C775.68 31.3315 775.916 33.2041 775.783 35.0687C775.65 36.9333 775.149 38.7531 774.31 40.4237C772.629 43.7906 769.679 46.3515 766.109 47.5432C762.539 48.7349 758.642 48.4596 755.275 46.778L738.671 38.485C736.501 37.4012 734.566 35.9007 732.976 34.069C731.386 32.2373 730.172 30.1104 729.404 27.8097C728.636 25.509 728.329 23.0796 728.5 20.6601C728.671 18.2406 729.317 15.8784 730.4 13.7085L733.582 7.33881C733.912 6.67683 734.492 6.17328 735.194 5.93898C735.896 5.70468 736.662 5.7588 737.324 6.08943L737.338 6.06259Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M739.728 39.3209L759.463 49.1778C761.636 50.2633 763.289 52.1677 764.059 54.4721C764.828 56.7765 764.65 59.292 763.565 61.4654C762.479 63.6388 760.575 65.292 758.27 66.0612C755.966 66.8305 753.45 66.6528 751.277 65.5673L740.595 60.2322C737.767 58.8196 735.616 56.3414 734.615 53.3427C733.614 50.344 733.845 47.0704 735.258 44.2422L737.308 40.1359C737.413 39.9231 737.559 39.7331 737.738 39.5768C737.916 39.4206 738.124 39.3011 738.349 39.2254C738.573 39.1497 738.811 39.1191 739.048 39.1355C739.284 39.1519 739.515 39.2149 739.728 39.3209Z" fill="white" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M791.93 14.1104C793.932 12.1557 796.422 10.7743 799.14 10.1104" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M783.06 10.0002C783.854 7.93351 783.317 5.24351 781.45 1.93018" stroke="#0E0E0E" stroke-width="3" stroke-miterlimit="10" stroke-linecap="round"/>
<path d="M311.04 658.35C332.43 658.35 349.77 641.01 349.77 619.62C349.77 598.23 332.43 580.89 311.04 580.89C289.65 580.89 272.31 598.23 272.31 619.62C272.31 641.01 289.65 658.35 311.04 658.35Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M311.04 648.78C327.145 648.78 340.2 635.725 340.2 619.62C340.2 603.515 327.145 590.46 311.04 590.46C294.935 590.46 281.88 603.515 281.88 619.62C281.88 635.725 294.935 648.78 311.04 648.78Z" fill="#0E0E0E"/>
<path d="M327.58 608.31C329.502 608.31 331.06 606.752 331.06 604.83C331.06 602.908 329.502 601.35 327.58 601.35C325.658 601.35 324.1 602.908 324.1 604.83C324.1 606.752 325.658 608.31 327.58 608.31Z" fill="white"/>
<path d="M321.49 616.14C322.451 616.14 323.23 615.361 323.23 614.4C323.23 613.439 322.451 612.66 321.49 612.66C320.529 612.66 319.75 613.439 319.75 614.4C319.75 615.361 320.529 616.14 321.49 616.14Z" fill="white"/>
<path d="M462.49 658.41C483.88 658.41 501.22 641.07 501.22 619.68C501.22 598.29 483.88 580.95 462.49 580.95C441.1 580.95 423.76 598.29 423.76 619.68C423.76 641.07 441.1 658.41 462.49 658.41Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M462.49 648.84C478.595 648.84 491.65 635.785 491.65 619.68C491.65 603.575 478.595 590.52 462.49 590.52C446.385 590.52 433.33 603.575 433.33 619.68C433.33 635.785 446.385 648.84 462.49 648.84Z" fill="#0E0E0E"/>
<path d="M479.03 608.37C480.952 608.37 482.51 606.812 482.51 604.89C482.51 602.968 480.952 601.41 479.03 601.41C477.108 601.41 475.55 602.968 475.55 604.89C475.55 606.812 477.108 608.37 479.03 608.37Z" fill="white"/>
<path d="M472.94 616.2C473.901 616.2 474.68 615.421 474.68 614.46C474.68 613.499 473.901 612.72 472.94 612.72C471.979 612.72 471.2 613.499 471.2 614.46C471.2 615.421 471.979 616.2 472.94 616.2Z" fill="white"/>
<path d="M353.65 703.19C384.27 685.19 408.88 691.34 430.25 703.19" stroke="#0E0E0E" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M339.81 535.36C322.1 556.82 297.01 558.87 269.53 554.64" stroke="#0E0E0E" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M428.82 535.4C446.51 556.87 471.6 558.95 499.08 554.74" stroke="#0E0E0E" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';