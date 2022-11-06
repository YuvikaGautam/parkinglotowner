import 'package:flutter/material.dart';

Color primaryColor = Color.fromARGB(255, 0, 0, 0);
Color primaryColor1 = const Color.fromARGB(255, 255, 255, 255);
// --------------- Our Assumption for constants ---------------
// ideal width = 400, ideal height = 800;
const double idealDevWd = 400;
const double idealDevHt = 800;
// --------------- Text Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
const double h1Size = 0.1; // (40 / 400)
const double h2Size = 0.055; // (22 / 400)
const double h3Size = 0.05; // (20 / 400)
const double subHdSize = 0.04; // (16 / 400)
const double bdTx1Size = 0.04; // (16 / 400)
const double bdTx2Size = 0.035; // (14 / 400)
const double bdTx3Size = 0.0325; // (13 / 400)
const double bdTx4Size = 0.03; // (12 / 400)
// --------------- Text weight constants ---------------
const FontWeight h1Weight = FontWeight.w700;
const FontWeight h2Weight = FontWeight.w700;
const FontWeight subHdWeight = FontWeight.w500;
const FontWeight bdTx1Weight = FontWeight.w500;
const FontWeight bdTx2Weight = FontWeight.w400;
const FontWeight bdTx3Weight = FontWeight.w400;
const FontWeight btnWeight = FontWeight.w700;
// --------------- gaps Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
const double appBarSizeHeight = 0.14; // (56 / 400)
const double mainBdPadHoriz = 0.04; // (16 / 400)
const double mainBdPadVert = 0.06; // (24 / 400)
const double mainCdPadHoriz = 0.03; // (12 / 400)
const double mainCdPadVert = 0.03; // (12 / 400)
const double btnPadHoriz = 0.0575; // (23 / 400)
const double btnPadTop = 0.0075; // (3 / 400)
const double btnPadBottom = 0.005; // (2 / 400)
const double rectBtnPadHoriz = 0.03; // (12 / 400)
// --------------- card Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
const double cdBorderRad = 0.02; // (8 / 400)
const double cdBorderWid = 0.0025; // (1 / 400)

// --------------- icons Sizes constants ---------------
class IconSize {
  final double wd;
  final double ht;
  const IconSize(this.wd, this.ht);
}

// all sizes are calculated by dividing size in points by ideal device width
const IconSize exLgIconSize =
    IconSize(0.12, 0.12); // wd:(48 / 400),ht:(48 / 400)
const IconSize lgIconSize = IconSize(0.08, 0.08); // wd:(32 / 400),ht:(32 / 400)
const IconSize iconSize = IconSize(0.06, 0.06); // wd:(24 / 400),ht:(24 / 400)
const IconSize smIconSize = IconSize(0.05, 0.05); // wd:(20 / 400),ht:(20 / 400)
const IconSize exSmIconSize =
    IconSize(0.04, 0.04); // wd:(16 / 400),ht:(16 / 400)
const IconSize morExSmIconSize =
    IconSize(0.03, 0.03); // wd:(12 / 400),ht:(12 / 400)
// --------------- Button Sizes constants ---------------
// all sizes are calculated by dividing size in points by ideal device width
const double btnBorderRad = 0.11; // (44 / 400)
const double rectBtnBorderRad = 0.01; // (4 / 400)