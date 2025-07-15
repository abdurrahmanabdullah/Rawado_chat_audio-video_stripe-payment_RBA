import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/colors.gen.dart';
import '../helpers/helper_methods.dart';

class TextFontStyle {
//Initialising Constractor
  TextFontStyle._();

  // Google Font Cabin

  static final headline10StyleCabin = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 8.sp, fontWeight: FontWeight.w400);

  static final headline12StyleCabin500 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w500);

  static final headline12StyleCabin = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w400);

  static final headline13StyleCabin500 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 13.sp, fontWeight: FontWeight.w500);

  static final headline14StyleCabin = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w400);

  static final headline14StyleCabin500 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w500);

  static final headline14StyleCabin700 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w500);

  static final headline16StyleCabin700 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w700);

  static final headline16StyleCabin = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w400);

  static final authButton16StyleCabin = GoogleFonts.cabin(
      color: appTextColor(), fontSize: 16.sp, fontWeight: FontWeight.w400);

  static final headline16StyleCabin500 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w500);

  static final headline18StyleCabin700 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.w700);

  static final headline20StyleCabin600 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w600);

  static final headline24StyleCabin700 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 24.sp, fontWeight: FontWeight.w700);

  static final headline28StyleCabin700 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 28.sp, fontWeight: FontWeight.w700);

  static final headline32StyleCabin700 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 32.sp, fontWeight: FontWeight.w700);

  static final headline40StyleCabin700 = GoogleFonts.cabin(
      color: AppColors.white, fontSize: 40.sp, fontWeight: FontWeight.w700);

  //Google Font Montserrat
  static final headline50StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.white, fontSize: 50.sp, fontWeight: FontWeight.w400);
  static final headline10StyleMontserrat700 = GoogleFonts.montserrat(
      color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w700);
  static final headline14StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w400);
  static final headline15StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.white, fontSize: 15.sp, fontWeight: FontWeight.w400);
  static final headline16StyleMontserrat500 = GoogleFonts.montserrat(
      color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w500);
  static final headline16StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.c8D8D8D, fontSize: 16.sp, fontWeight: FontWeight.w400);
  static final headline16StyleMontserrat700 = GoogleFonts.montserrat(
      color: AppColors.c000000, fontSize: 16.sp, fontWeight: FontWeight.w700);
  static final headline18StyleMontserrat700 = GoogleFonts.montserrat(
      color: AppColors.c000000, fontSize: 16.sp, fontWeight: FontWeight.w700);

  //Google Font Raleway
  static final headline20StyleRaleway = GoogleFonts.raleway(
      color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w400);
  static final headline20StyleRaleway500 = GoogleFonts.raleway(
      color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w500);

  //Google Font Roboto
  static final headline12StyleRoboto = GoogleFonts.roboto(
      color: AppColors.c707070, fontSize: 12.sp, fontWeight: FontWeight.w400);
  static final headline13StyleRoboto700 = GoogleFonts.roboto(
      color: AppColors.white, fontSize: 13.sp, fontWeight: FontWeight.w700);
  static final headline17StyleRoboto = GoogleFonts.roboto(
      color: AppColors.c707070, fontSize: 17.sp, fontWeight: FontWeight.w400);
  static final headline18StyleRoboto700 = GoogleFonts.roboto(
      color: AppColors.c707070, fontSize: 18.sp, fontWeight: FontWeight.w700);
  static final headline14StyleRoboto = GoogleFonts.roboto(
      color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w400);
}
