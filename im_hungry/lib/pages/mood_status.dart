import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:im_hungry/collections/moods_collection.dart";
import "package:im_hungry/colors.dart";
import "package:im_hungry/components/mood/big_mood.dart";
import 'package:im_hungry/components/mood/mood_list_view.dart';
import "package:im_hungry/components/snack_bar.dart";
import "package:im_hungry/models/mood.dart";

class MoodStatus extends StatefulWidget {
  const MoodStatus({super.key});

  @override
  State<MoodStatus> createState() => _MoodStatusState();
}

class _MoodStatusState extends State<MoodStatus> {
  final db = FirebaseFirestore.instance;
  late final statusDocRef = db
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("status")
      .doc("currentStatus");
  int? currentIndex;
  DateTime? moodUpdateTime;

  void updateMood(int index) {
    setState(() {
      currentIndex = index;
      moodUpdateTime = DateTime.now();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      duration: Durations.long4,
      content: Text(
        "Da update",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: HungryColors().backYellow,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: const Color.fromARGB(255, 152, 75, 60),
      behavior: SnackBarBehavior.floating,
    ));
  }

  Mood partnerMood = MoodCollection().moods[1];
  Future<void> getMood() async {
    final data = await statusDocRef.get();
    final fetchedMoodData = data.data();
    if (fetchedMoodData != null) {
      setState(() {
        partnerMood = MoodCollection().moods[fetchedMoodData["current"]];
      });
    } else {
      print("No such document.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Mood currentMood = MoodCollection().moods[currentIndex ?? 0];
    getMood();
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trạng thái",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HungryColors().surfaceBrown),
              ),
              BigMood(
                  mood: partnerMood,
                  time: moodUpdateTime ?? DateTime.now()),
              BigMood(
                  mood: currentMood,
                  time: DateTime.now(),
                  avaPath: "lib/assets/em.png"),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Chọn trạng thái của bạn",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HungryColors().surfaceBrown),
              ),
            ),
            const SizedBox(height: 10),
            MoodsListView(updateMood: (index) => updateMood(index)),
          ],
        )
      ],
    ));
  }
}
