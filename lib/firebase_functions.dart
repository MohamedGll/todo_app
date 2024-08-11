import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

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

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection(); // create collection
    var docRef = collection.doc(); //create doc
    task.id = docRef.id;
    return docRef.set(task); //set attributes
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    return getTasksCollection().doc(taskModel.id).update(taskModel.toJson());
  }
}
