import 'package:flutter/material.dart';
import 'NewsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> allTopics = [
    'الرياضة', 'كرة القدم', 'كرة السلة', 'كأس العالم', 'الأولمبياد',
    'السياسة', 'الانتخابات', 'الحروب', 'الأمم المتحدة', 'السلام',
    'الاقتصاد', 'البورصة', 'الذهب', 'النفط', 'العملات الرقمية',
    'الصحة', 'الطب', 'الفيروسات', 'كورونا', 'اللقاحات',
    'التكنولوجيا', 'الذكاء الاصطناعي', 'الذكاء الاصطناعي التوليدي', 'الأمن السيبراني', 'الروبوتات',
    'الهواتف الذكية', 'جوجل', 'آبل', 'مايكروسوفت', 'أمازون',
    'السفر', 'الطيران', 'السياحة', 'المعالم السياحية', 'المدن الكبرى',
    'التعليم', 'الجامعات', 'المدارس', 'البحث العلمي', 'الابتكار',
    'البرمجة', 'تطوير الويب', 'تطوير التطبيقات', 'البرمجيات', 'الأجهزة الذكية',
    'البيئة', 'التلوث', 'الاحتباس الحراري', 'الطاقة الشمسية', 'الطاقة المتجددة',
    'الفضاء', 'ناسا', 'سبيس إكس', 'المريخ', 'القمر',
    'الأفلام', 'المسلسلات', 'السينما', 'هوليوود', 'الأنمي',
    'الموسيقى', 'الفن', 'الغناء', 'الحفلات', 'المهرجانات الثقافية',
    'التاريخ', 'الآثار', 'الحضارات', 'المعارك التاريخية', 'الثقافة العامة',
    'الكتب', 'الأدب', 'الروايات', 'الشعر', 'اللغة العربية',
    'المناخ', 'الطقس', 'الأمطار', 'الزلازل', 'الكوارث الطبيعية',
    'السيارات', 'السيارات الكهربائية', 'تسلا', 'الطرق السريعة', 'حوادث السير',
    'الأعمال', 'ريادة الأعمال', 'المشاريع الصغيرة', 'التجارة الإلكترونية', 'التمويل',
    'المجتمع', 'المرأة', 'الشباب', 'الأسرة', 'القضايا الاجتماعية',
    'مصر', 'السعودية', 'الإمارات', 'فلسطين', 'القدس',
    'التمثيل', 'الموضة', 'الذكاء العاطفي', 'التصوير', 'الابتكار التقني'
  ];

  final Map<String, IconData> topicIcons = {
    'الرياضة': Icons.sports,
    'كرة القدم': Icons.sports_soccer,
    'كرة السلة': Icons.sports_basketball,
    'كأس العالم': Icons.emoji_events,
    'الأولمبياد': Icons.sports_handball,
    'السياسة': Icons.gavel,
    'الانتخابات': Icons.how_to_vote,
    'الحروب': Icons.warning,
    'الأمم المتحدة': Icons.flag,
    'السلام': Icons.handshake,
    'الاقتصاد': Icons.attach_money,
    'البورصة': Icons.trending_up,
    'الذهب': Icons.star,
    'النفط': Icons.local_gas_station,
    'العملات الرقمية': Icons.currency_bitcoin,
    'الصحة': Icons.health_and_safety,
    'الطب': Icons.local_hospital,
    'الفيروسات': Icons.coronavirus,
    'كورونا': Icons.coronavirus,
    'اللقاحات': Icons.vaccines,
    'التكنولوجيا': Icons.devices,
    'الذكاء الاصطناعي': Icons.memory,
    'الذكاء الاصطناعي التوليدي': Icons.auto_awesome,
    'الأمن السيبراني': Icons.security,
    'الروبوتات': Icons.precision_manufacturing,
    'الهواتف الذكية': Icons.smartphone,
    'جوجل': Icons.language,
    'آبل': Icons.apple,
    'مايكروسوفت': Icons.window,
    'أمازون': Icons.shopping_cart,
    'السفر': Icons.flight,
    'الطيران': Icons.airplanemode_active,
    'السياحة': Icons.card_travel,
    'المعالم السياحية': Icons.location_city,
    'المدن الكبرى': Icons.apartment,
    'التعليم': Icons.school,
    'الجامعات': Icons.account_balance,
    'المدارس': Icons.cast_for_education,
    'البحث العلمي': Icons.search,
    'الابتكار': Icons.lightbulb,
    'البرمجة': Icons.code,
    'تطوير الويب': Icons.web,
    'تطوير التطبيقات': Icons.phone_android,
    'البرمجيات': Icons.computer,
    'الأجهزة الذكية': Icons.devices_other,
    'البيئة': Icons.eco,
    'التلوث': Icons.smoking_rooms,
    'الاحتباس الحراري': Icons.thermostat,
    'الطاقة الشمسية': Icons.sunny,
    'الطاقة المتجددة': Icons.energy_savings_leaf,
    'الفضاء': Icons.rocket_launch,
    'ناسا': Icons.public,
    'سبيس إكس': Icons.rocket,
    'المريخ': Icons.travel_explore,
    'القمر': Icons.nightlight,
    'الأفلام': Icons.movie,
    'المسلسلات': Icons.live_tv,
    'السينما': Icons.theaters,
    'هوليوود': Icons.stars,
    'الأنمي': Icons.animation,
    'الموسيقى': Icons.music_note,
    'الفن': Icons.brush,
    'الغناء': Icons.mic,
    'الحفلات': Icons.event,
    'المهرجانات الثقافية': Icons.festival,
    'التاريخ': Icons.history_edu,
    'الآثار': Icons.account_balance,
    'الحضارات': Icons.museum,
    'المعارك التاريخية': Icons.shield,
    'الثقافة العامة': Icons.light_mode,
    'الكتب': Icons.book,
    'الأدب': Icons.menu_book,
    'الروايات': Icons.menu_book,
    'الشعر': Icons.format_quote,
    'اللغة العربية': Icons.translate,
    'المناخ': Icons.eco,
    'الطقس': Icons.wb_sunny,
    'الأمطار': Icons.grain,
    'الزلازل': Icons.crisis_alert,
    'الكوارث الطبيعية': Icons.report_problem,
    'السيارات': Icons.directions_car,
    'السيارات الكهربائية': Icons.electric_car,
    'تسلا': Icons.electric_car,
    'الطرق السريعة': Icons.add_road,
    'حوادث السير': Icons.car_crash,
    'الأعمال': Icons.business_center,
    'ريادة الأعمال': Icons.trending_up,
    'المشاريع الصغيرة': Icons.work,
    'التجارة الإلكترونية': Icons.shopping_cart,
    'التمويل': Icons.account_balance_wallet,
    'المجتمع': Icons.people,
    'المرأة': Icons.female,
    'الشباب': Icons.group,
    'الأسرة': Icons.family_restroom,
    'القضايا الاجتماعية': Icons.forum,
    'مصر': Icons.flag,
    'السعودية': Icons.flag,
    'الإمارات': Icons.flag,
    'فلسطين': Icons.flag,
    'القدس': Icons.location_city,
    'التمثيل': Icons.theater_comedy,
    'الموضة': Icons.checkroom,
    'الذكاء العاطفي': Icons.psychology,
    'التصوير': Icons.camera_alt,
    'الابتكار التقني': Icons.science,
  };

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredTopics =
    allTopics.where((topic) => topic.contains(searchQuery)).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('مواضيع الأخبار')),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.teal[100],
                  filled: true,
                  hintText: 'ابحث عن المواضيع...',
                  hintStyle: TextStyle(color: Colors.teal[900]),
                  prefixIcon: Icon(Icons.search, color: Colors.teal[800]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3,
                ),
                itemCount: filteredTopics.length,
                itemBuilder: (context, index) {
                  final topic = filteredTopics[index];
                  final icon = topicIcons[topic] ?? Icons.article;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsScreen(query: topic),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(icon, size: 26, color: Colors.teal[800]),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              topic,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.teal[900],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
