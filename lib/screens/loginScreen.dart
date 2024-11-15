import 'package:flutter/material.dart';
import 'package:sm5/screens/check.dart';
import 'package:sm5/screens/contactUs.dart';
import 'package:sm5/screens/set.dart';
import 'package:provider/provider.dart';
import 'package:sm5/providers/language_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _showLanguagePanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('English'),
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLanguage('English');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Spanish'),
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLanguage('Spanish');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('German'),
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLanguage('German');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('French'),
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLanguage('French');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    String currentLanguage = languageProvider.currentLanguage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF579039),
        title: const Text.rich(
          TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: 'BRECO'),
              TextSpan(
                text: 'flex',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(text: ' Tension Meter App'),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/thumbnail.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/bfxLogo.png',
                      width: 350,
                    ),
                  ),
                  Center(
                    child: Text(
                      languageProvider.translate('Companion_App'),
                      textAlign:
                          TextAlign.center, // Optional: Centers the text itself
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF579039),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckScreen()),
                        );
                      },
                      child: Text(languageProvider.translate('check')),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF579039),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SetScreen()),
                        );
                      },
                      child: Text(languageProvider.translate('set')),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF579039),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactScreen()),
                        );
                      },
                      child: Text(languageProvider.translate('contact_us')),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _showLanguagePanel(context),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.language, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      currentLanguage,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
