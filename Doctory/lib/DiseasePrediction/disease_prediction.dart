import 'package:doctory/AppColor/appcolors.dart';
import 'package:doctory/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'disease_result.dart';

class Predict extends StatefulWidget {
  const Predict({super.key});

  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  List<String> symptoms = [
    "Itching",
    "Skin Rash",
    "Nodal Skin Eruptions",
    "Continuous Sneezing",
    "Shivering",
    "Chills",
    "Joint Pain",
    "Stomach Pain",
    "Acidity",
    "Ulcers On Tongue",
    "Muscle Wasting",
    "Vomiting",
    "Burning Micturition",
    "Spotting Urination",
    "Fatigue",
    "Weight Gain",
    "Anxiety",
    "Cold Hands And Feets",
    "Mood Swings",
    "Weight Loss",
    "Restlessness",
    "Lethargy",
    "Patches In Throat",
    "Irregular Sugar Level",
    "Cough",
    "High Fever",
    "Sunken Eyes",
    "Breathlessness",
    "Sweating",
    "Dehydration",
    "Indigestion",
    "Headache",
    "Yellowish Skin",
    "Dark Urine",
    "Nausea",
    "Loss Of Appetite",
    "Pain Behind The Eyes",
    "Back Pain",
    "Constipation",
    "Abdominal Pain",
    "Diarrhoea",
    "Mild Fever",
    "Yellow Urine",
    "Yellowing Of Eyes",
    "Acute Liver Failure",
    "Fluid Overload",
    "Swelling Of Stomach",
    "Swelled Lymph Nodes",
    "Malaise",
    "Blurred And Distorted Vision",
    "Phlegm",
    "Throat Irritation",
    "Redness Of Eyes",
    "Sinus Pressure",
    "Runny Nose",
    "Congestion",
    "Chest Pain",
    "Weakness In Limbs",
    "Fast Heart Rate",
    "Pain During Bowel Movements",
    "Pain In Anal Region",
    "Bloody Stool",
    "Irritation In Anus",
    "Neck Pain",
    "Dizziness",
    "Cramps",
    "Bruising",
    "Obesity",
    "Swollen Legs",
    "Swollen Blood Vessels",
    "Puffy Face And Eyes",
    "Enlarged Thyroid",
    "Brittle Nails",
    "Swollen Extremeties",
    "Excessive Hunger",
    "Extra Marital Contacts",
    "Drying And Tingling Lips",
    "Slurred Speech",
    "Knee Pain",
    "Hip Joint Pain",
    "Muscle Weakness",
    "Stiff Neck",
    "Swelling Joints",
    "Movement Stiffness",
    "Spinning Movements",
    "Loss Of Balance",
    "Unsteadiness",
    "Weakness Of One Body Side",
    "Loss Of Smell",
    "Bladder Discomfort",
    "Foul Smell Of Urine",
    "Continuous Feel Of Urine",
    "Passage Of Gases",
    "Internal Itching",
    "Toxic Look (Typhos)",
    "Depression",
    "Irritability",
    "Muscle Pain",
    "Altered Sensorium",
    "Red Spots Over Body",
    "Belly Pain",
    "Abnormal Menstruation",
    "Dischromic Patches",
    "Watering From Eyes",
    "Increased Appetite",
    "Polyuria",
    "Family History",
    "Mucoid Sputum",
    "Rusty Sputum",
    "Lack Of Concentration",
    "Visual Disturbances",
    "Receiving Blood Transfusion",
    "Receiving Unsterile Injections",
    "Coma",
    "Stomach Bleeding",
    "Distention Of Abdomen",
    "History Of Alcohol Consumption",
    "Fluid Overload",
    "Blood In Sputum",
    "Prominent Veins On Calf",
    "Palpitations",
    "Painful Walking",
    "Pus Filled Pimples",
    "Blackheads",
    "Scurring",
    "Skin Peeling",
    "Silver Like Dusting",
    "Small Dents In Nails",
    "Inflammatory Nails",
    "Blister",
    "Red Sore Around Nose",
    "Yellow Crust Ooze",
  ];

  late List<int> selectedSymptoms;
  TextEditingController searchController = TextEditingController();
  List<String> filteredSymptoms = [];

  @override
  void initState() {
    super.initState();
    selectedSymptoms = List.filled(symptoms.length, 0);
    filteredSymptoms = symptoms;
  }

  void filterSymptoms(String query) {
    setState(() {
      filteredSymptoms =
          symptoms
              .where(
                (symptom) =>
                    symptom.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void navigateToPrediction() {
    List<String> selected = [];
    for (int i = 0; i < selectedSymptoms.length; i++) {
      if (selectedSymptoms[i] == 1) {
        selected.add(symptoms[i]);
      }
    }

    List<String> finalSelected = List.filled(17, "0");
    for (int i = 0; i < selected.length && i < 17; i++) {
      finalSelected[i] = selected[i];
    }

    void clearSelection() {
      setState(() {
        selectedSymptoms = List.filled(symptoms.length, 0);
        searchController.clear();
        filteredSymptoms = symptoms;
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictResult(selectedSymptoms: finalSelected),
      ),
    ).then((_) {
      clearSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        foregroundColor: Colors.white,
        backgroundColor: AppColors().maincolor,
        title: Text(
          "Symptoms List",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: Icon(FontAwesomeIcons.userDoctor),
        )],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
            decoration: BoxDecoration(
              color: AppColors().maincolor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors().coloroftextformfield,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterSymptoms,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: "Search Symptoms",
                      hintStyle: TextStyle(color: AppColors().colorofhint),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: AppColors().colorofhint),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children:
                  filteredSymptoms.map((symptom) {
                    int index = symptoms.indexOf(symptom);
                    return ListTile(
                      leading: Checkbox(
                        value: selectedSymptoms[index] == 1,
                        onChanged: (bool? value) {
                          setState(() {
                            selectedSymptoms[index] = value == true ? 1 : 0;
                          });
                        },
                        activeColor: AppColors().maincolor,
                        checkColor: Colors.white,
                        shape: const CircleBorder(),
                        side: BorderSide(color: AppColors().maincolor),
                      ),
                      title: Text(
                        symptom,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        setState(() {
                          selectedSymptoms[index] =
                              selectedSymptoms[index] == 1 ? 0 : 1;
                        });
                      },
                    );
                  }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DoctoryButton(
              context,
              color: AppColors().maincolor,
              text: "Predict",
              function: navigateToPrediction,
              textcolor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
