import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance.collection('Tasks').withConverter(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance.collection('Users').withConverter(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection(); // create collection
    var docRef = collection.doc(); //create doc
    task.id = docRef.id;
    return docRef.set(task); //set attributes
  }

  static addUser(UserModel user) {
    var collection = getUsersCollection(); // create collection
    var docRef = collection.doc(user.id); //create doc
    docRef.set(user); //set attributes
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<UserModel?> getUserData(String userId) async {
    var collection = getUsersCollection();
    DocumentSnapshot<UserModel> docUser = await collection.doc(userId).get();
    return docUser.data();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    return getTasksCollection().doc(taskModel.id).update(taskModel.toJson());
  }

  static createAccounte(
    String email,
    String password, {
    required Function onSuccess,
    required Function onError,
    required String userName,
    required String phone,
    required int age,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user?.sendEmailVerification();
      UserModel user = UserModel(
        id: credential.user!.uid,
        userName: userName,
        phone: phone,
        age: age,
        email: email,
      );
      addUser(user);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }

  static login(String email, String password,
      {required Function onSuccess, required Function onError}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (credential.user?.emailVerified == true) {
      //   onSuccess();
      // }
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }
}
