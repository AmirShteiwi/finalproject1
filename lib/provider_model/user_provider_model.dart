// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserData _user;

  UserData get user => _user;

  Future<String> login(String email, String password) async {
    String errorMessage = "Success_success";

    // Perform Firebase authentication
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print("error message : ${e.code}_${e.message}");
      if (e.code == 'user-not-found') {
        errorMessage = "${e.code}_${e.message}";
      } else if (e.code == 'wrong-password') {
        errorMessage = "${e.code}_${e.message}";
      } else if (e.code == 'invalid-credential') {
        errorMessage =
            "${e.code}_Invalid email or password entered. Please enter correct email and password";
      } else if (e.code == 'invalid-email') {
        errorMessage =
            "${e.code}_${e.message} Kindly enter a valid email in the following example format : 'john.wyler874@gmail.com' ";
      }
    }

    if (errorMessage == "Success_success") {
      // Retrieve user data from Firestore
      try {
        final docUser =
            FirebaseFirestore.instance.collection('users').doc(email.trim());
        final snapshot = await docUser.get();
        Map<String, dynamic> data = snapshot.data()!;
        print(data['profilePictureUrl']);
        // Populate user model
        _user = UserData(
          email: data['email'],
          fullName: data['fullname'],
          age: data['age'],
          weight: data['weight'],
          height: data['height'],
          gender: data['gender'],
          profilePictureUrl: data['profilePictureUrl'],
        );
      } on FirebaseAuthException catch (e) {
        print('Error adding user : ${e.code}_${e.message}');
      }
    }

    notifyListeners();
    return errorMessage;
  }

  Future<String> signup(String email, String password, String fullName, int age,
      double weight, double height, String gender) async {
    String errorMessage = "Success_success";

    // Perform Firebase authentication for signup
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("error message : ${e.code}_${e.message}");
      if (e.code == 'weak-password') {
        errorMessage = "${e.code}_${e.message}";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "${e.code}_${e.message}";
      } else if (e.code == 'invalid-email') {
        errorMessage =
            "${e.code}_${e.message} Kindly enter a valid email in the following example format : 'john.wyler874@gmail.com' ";
      }
    }

    if (errorMessage == "Success_success") {
      // Create a user document in Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'email': email,
        'fullname': fullName,
        'age': age,
        'weight': weight,
        'height': height,
        'gender': gender,
        'profilePictureUrl': ''
      });

      // Populate user model
      _user = UserData(
        email: email,
        fullName: fullName,
        age: age,
        weight: weight,
        height: height,
        gender: gender,
        profilePictureUrl: '',
      );
    }

    notifyListeners();
    return errorMessage;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    _user = UserData(
      email: '',
      fullName: '',
      age: 0,
      weight: 0,
      height: 0,
      gender: '',
      profilePictureUrl: '',
    );

    notifyListeners();
  }

  Future<String> resetPassword(String email) async {
    String errorMessage = "Success_success";
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage =
            "${e.code}_${e.message} Kindly enter a valid email in the following example format : 'john.wyler874@gmail.com' ";
      } else {
        errorMessage = "Error_${e.code}, ${e.message}";
      }
    }
    return errorMessage;
  }

  Future<void> setProfilePicture(File imageFile, String email) async {
    UploadTask uploadTask =
        FirebaseStorage.instance.ref("profilePictures").child(email).putFile(
              imageFile,
              SettableMetadata(
                  contentType:
                      'image/jpeg'), // Replace with the appropriate content type
            );
    TaskSnapshot taskSnapshot = await uploadTask;

    String imgURL = await taskSnapshot.ref.getDownloadURL();

    //update the provider instance of the user
    _user = UserData(
      email: _user.email,
      fullName: _user.fullName,
      age: _user.age,
      weight: _user.weight,
      height: _user.height,
      gender: _user.gender,
      profilePictureUrl: imgURL,
    );

    FirebaseFirestore.instance.collection('users').doc(email).update({
      'profilePictureUrl': imgURL,
    });

    notifyListeners();
  }
}
