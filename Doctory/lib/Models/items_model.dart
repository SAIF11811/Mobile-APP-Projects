class homeitem {
  final String imgPath;
  final String name;
  final String brief;
  final int dest;

  homeitem({
    required this.imgPath,
    required this.name,
    required this.brief,
    required this.dest,
  });
}

List<homeitem> home = [
  homeitem(
    imgPath: 'assets/firstaid.png',
    name: 'First Aid',
    brief: 'Provides quick medical guidance for common emergencies and injuries',
    dest: 5,
  ),

  homeitem(
    imgPath: 'assets/feature1.png',
    name: 'Health Care',
    brief: 'A quick method to check your muscle and fat to improve your health',
    dest: 0,
  ),

  homeitem(
    imgPath: 'assets/predict5.jpg',
    name: 'Predict Disease',
    brief:
        'Helps you identify possible illnesses based on the symptoms you enter ',
    dest: 1,
  ),

  homeitem(
    imgPath: 'assets/heart2.jpg',
    name: 'Heart Disease Prediction',
    brief:
        'Predicts whether you have heart disease based on the symptoms you provide',
    dest: 2,
  ),

  homeitem(
    imgPath: 'assets/diabeteimage.png',
    name: 'Diabetes Detection',
    brief:
        'Predicts whether you have diabetes based on the symptoms you provide',
    dest: 4,
  ),

  homeitem(
    imgPath: 'assets/women.jpg',
    name: 'Breast Cancer Detection',
    brief: 'Detects breast cancer by analyzing the X-ray image you provide',
    dest: 3,
  ),

  homeitem(
    imgPath: 'assets/burn.jpg',
    name: 'Skin Burn Detection',
    brief: 'Instant analysis and guidance for identifying and treating skin burns effectively',
    dest: 6,
  ),
];

class FirstAidItem {
  final String img;
  final String title;
  final int ScreenNo;

  FirstAidItem({
    required this.img,
    required this.title,
    required this.ScreenNo,
  });
}

List<FirstAidItem> firstaid = [
  FirstAidItem(
    img: 'assets/images/heatstroke.png',
    title: 'Heat Stroke',
    ScreenNo: 0,
  ),
  FirstAidItem(
    img: 'assets/images/biting.png',
    title: 'Bites and Stings',
    ScreenNo: 1,
  ),
  FirstAidItem(img: 'assets/images/wounds.png', title: 'Wounds', ScreenNo: 2),
  FirstAidItem(
    img: 'assets/images/hypothermia.png',
    title: 'Hypothermia',
    ScreenNo: 3,
  ),
  FirstAidItem(
    img: 'assets/images/sugarlevel.png',
    title: 'Low Blood Sugar',
    ScreenNo: 4,
  ),
];
