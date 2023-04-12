import 'package:flutter/material.dart';

Color primaryColor = const Color.fromARGB(255, 0, 0, 0);
Color primaryColor1 = const Color.fromARGB(255, 255, 255, 255);
Color grey = const Color.fromRGBO(156, 148, 148, 1);
Color bluecolor = const Color.fromRGBO(3, 95, 170, 1);
// --------------- Our Assumption for constants ---------------
// ideal width = 400, ideal height = 800;
double idealDevWd = 400;
double idealDevHt = 800;
// --------------- Text Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
double h1Size = 0.1; // (40 / 400)
double h2Size = 0.055; // (22 / 400)
double h3Size = 0.05; // (20 / 400)
double subHdSize = 0.04; // (16 / 400)
double bdTx1Size = 0.04; // (16 / 400)
double bdTx2Size = 0.035; // (14 / 400)
double bdTx3Size = 0.0325; // (13 / 400)
double bdTx4Size = 0.03; // (12 / 400)
// --------------- Text weight constants ---------------
FontWeight h1Weight = FontWeight.w700;
FontWeight h2Weight = FontWeight.w700;
FontWeight subHdWeight = FontWeight.w500;
FontWeight bdTx1Weight = FontWeight.w500;
FontWeight bdTx2Weight = FontWeight.w400;
FontWeight bdTx3Weight = FontWeight.w400;
FontWeight btnWeight = FontWeight.w700;
// --------------- gaps Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
double appBarSizeHeight = 0.14; // (56 / 400)
double mainBdPadHoriz = 0.04; // (16 / 400)
double mainBdPadVert = 0.06; // (24 / 400)
double mainCdPadHoriz = 0.03; // (12 / 400)
double mainCdPadVert = 0.03; // (12 / 400)
double btnPadHoriz = 0.0575; // (23 / 400)
double btnPadTop = 0.0075; // (3 / 400)
double btnPadBottom = 0.005; // (2 / 400)
double rectBtnPadHoriz = 0.03; // (12 / 400)
// --------------- card Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
double cdBorderRad = 0.02; // (8 / 400)
double cdBorderWid = 0.0025; // (1 / 400)

// --------------- icons Sizes constants ---------------
class IconSize {
  final double wd;
  final double ht;
  IconSize(this.wd, this.ht);
}

// all sizes are calculated by dividing size in points by ideal device width
IconSize exLgIconSize = IconSize(0.12, 0.12); // wd:(48 / 400),ht:(48 / 400)
IconSize lgIconSize = IconSize(0.08, 0.08); // wd:(32 / 400),ht:(32 / 400)
IconSize iconSize = IconSize(0.06, 0.06); // wd:(24 / 400),ht:(24 / 400)
IconSize smIconSize = IconSize(0.05, 0.05); // wd:(20 / 400),ht:(20 / 400)
IconSize exSmIconSize = IconSize(0.04, 0.04); // wd:(16 / 400),ht:(16 / 400)
IconSize morExSmIconSize = IconSize(0.03, 0.03); // wd:(12 / 400),ht:(12 / 400)
// --------------- Button Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
double btnBorderRad = 0.11; // (44 / 400)
double rectBtnBorderRad = 0.01; // (4 / 400)

InputDecoration getCustomDecoration(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: const Color.fromRGBO(217, 217, 217, 0.5),
    hintText: hintText,
    enabled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: bluecolor),
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(20),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: bluecolor),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
