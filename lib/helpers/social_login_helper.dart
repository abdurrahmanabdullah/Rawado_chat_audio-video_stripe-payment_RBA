// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rawado/networks/api_acess.dart';

import 'toast.dart';

class SocialLoginHelper {
  static final SocialLoginHelper _singleton = SocialLoginHelper._internal();
  SocialLoginHelper._internal();

  static SocialLoginHelper get instance => _singleton;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      await InternetAddress.lookup('google.com');

      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      // ToastUtil.showLongToast(authResult.toString());
      if (authResult.user != null) {
        // Call Your Server API
        postSocialLoginRXObj.socialLogin(authResult.credential!.accessToken!);
        // Provider.of<AuthenticationProvider>(context, listen: false).socialLogin(
        //     authResult.user!.email!,
        //     authResult.user!.displayName!,
        //     authResult.credential!.accessToken!,
        //     'google',
        //     context);
        // ToastUtil.showLongToast('Login Sussessfully');
      }
      log("google sing in info$authResult");
      // Return the current user
      return authResult.user;
    } catch (error) {
      ToastUtil.showLongToast(error.toString());
      log(error.toString());
      return null;
    }
  }
}
