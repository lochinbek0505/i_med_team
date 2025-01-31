import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutUsPage extends StatelessWidget {
  final String phoneNumber = "tel:+998914929802";
  final String telegramUrl = "https://t.me/iMed_team";
  final String videoUrl = "https://youtu.be/ubsvKHwQxF4?si=TDYNLITsr1oLfAdU";
  final String youtubeUrl = "https://youtube.com/@imedteam?si=bN2ePCMFr4dJGAgL";
  final String instagramUrl =
      "https://instagram.com/imed_team?igshid=YmMyMTA2M2Y=";
  final String facebookUrl =
      "https://www.facebook.com/share/19pqHfrUDf/?mibextid=wwXIfr";
  final String websiteUrl = "https://imedteam.uz";

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biz haqimizda '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16.0),
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: "ubsvKHwQxF4?si=TDYNLITsr1oLfAdU",
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                    loop: true,
                  ),
                ),
              ),
              builder: (context, player) {
                return player;
              },
            ),
            SizedBox(height: 16.0),
            Text(
              """“iMed Team” tibbiy platformasi 2021-yildan buyon o‘z faoliyatlarini olib bormoqda. Shu kungacha biz 3000 dan ziyod bo’lgan talaba va shifokorlarni o’qitib keldik. Bizning talabalar turli xil davlat va xususiy shifoxonalarda malakali mutaxasis bo’lib ishlab kelishmoqda. Shuningdek, ularning turli xalqaro hamda milliy olimpiadalarda faxrli o’rinlarni egallab kelayotganlari diqqatga sazovordir. Bizning fundamental fanlarimiz barchasi klinik fanlarga o’tishingiz uchun debocha bo’lib xizmat qilsa, klinik fanlarimiz bemorlar bilan ishlashda sizga ancha qulayliklar paydo qiladi. Siz oddiy bilimlar olmaysiz, balkim aniq instrumental bilimlar olasiz, bu bilimlarni o’z amaliyotingizga tatbiq qilgan holda, yuqori natijalarga erishishingizga aminmiz!
Shiorimiz: 

• Talaba va shifokorlarni zamonaviy va isbotli tibbiyot bilan to’laqonli tanishtirish.
• Nazariy va amaliy bilimlarni birgalikda uyg’unlashtira olish.
• Har bir bemorga o’z yaqini sifatida individual yondashuvni o’rgatish.
• Bir so’z bilan aytganda: O’zbekiston tibbiyotini yangi darajaga olib chiqish, bu - bizning eng ustuvor vazifalarimizdandir!""",
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(height: 24.0),
            _buildContactCard(
              image: "assets/phone.png",
              title: "+998914929802",
              subtitle:
                  "Manager telefoniga soat 09:00 dan 21:00 gacha qo'ng'iroq qiling",
              onTap: () => _launchUrl(phoneNumber),
              color: Colors.blue,
            ),
            SizedBox(height: 16.0),
            _buildContactCard(
              image: "assets/telegram.png",
              title: "Telegram",
              subtitle:
                  "Istalgan qulay vaqtda yozing, mutaxassislarimiz sizga imkon qadar tezroq javob berishadi",
              onTap: () => _launchUrl(telegramUrl),
              color: Colors.blueAccent,
            ),
            SizedBox(height: 16.0),
            _buildContactCard(
              image: "assets/youtube.png",
              title: "YouTube",
              subtitle: "Bizning YouTube kanalimizni kuzatib boring",
              onTap: () => _launchUrl(youtubeUrl),
              color: Colors.red,
            ),
            SizedBox(height: 16.0),
            _buildContactCard(
              image: "assets/social.png",
              title: "Instagram",
              subtitle: "Bizni Instagramda kuzatib boring",
              onTap: () => _launchUrl(instagramUrl),
              color: Colors.purple,
            ),
            SizedBox(height: 16.0),
            _buildContactCard(
              image: "assets/facebook.png",
              title: "Facebook",
              subtitle: "Bizni Facebookda kuzatib boring",
              onTap: () => _launchUrl(facebookUrl),
              color: Colors.blue,
            ),
            SizedBox(height: 16.0),
            _buildContactCard(
              image: "assets/web.png",
              title: "Website",
              subtitle: "Rasmiy veb-saytimizga tashrif buyuring",
              onTap: () => _launchUrl(websiteUrl),
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required String image,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                image,
                width: 45,
                height: 45,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
