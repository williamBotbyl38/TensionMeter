import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Method to open phone dialer with the BRECOflex number
  Future<void> _launchPhoneDialer() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '9734609500',
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not open phone dialer.';
    }
  }

  // Method to open an email client with the BRECOflex email address
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'cs@brecoflex.com',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email client.';
    }
  }

  // Method to launch the BRECOflex homepage
  Future<void> _launchHomepage() async {
    const url = 'https://www.brecoflex.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.translate('contact_us')),
        backgroundColor: const Color(0xFF579039),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with opacity
          Opacity(
            opacity: 0.3, // Set opacity to 30%
            child: Image.asset(
              'assets/tension_meter_contact.png', // Your background image
              fit: BoxFit.cover,
            ),
          ),
          // Centered logo image
          Center(
            child: Image.asset(
              'assets/bfxLogo.png', // Your logo image
              width: 400, // Adjust the width as needed
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add the note text here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Note: Contact us for special belts with non-standard mass such as with backings, profiles or machining.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
          ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
                label: '(973) 460-9500',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.email),
                label: 'cs@brecoflex.com',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.web),
                label: 'www.Brecoflex.com',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  _launchPhoneDialer();
                  break;
                case 1:
                  _launchEmail();
                  break;
                case 2:
                  _launchHomepage();
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';
// import '../providers/language_provider.dart';

// class ContactScreen extends StatelessWidget {
//   const ContactScreen({super.key});

//   // Method to open phone dialer with the BRECOflex number
//   Future<void> _launchPhoneDialer() async {
//     final Uri phoneUri = Uri(
//       scheme: 'tel',
//       path: '9734609500',
//     );

//     if (await canLaunchUrl(phoneUri)) {
//       await launchUrl(phoneUri);
//     } else {
//       throw 'Could not open phone dialer.';
//     }
//   }

//   // Method to open an email client with the BRECOflex email address
//   Future<void> _launchEmail() async {
//     final Uri emailUri = Uri(
//       scheme: 'mailto',
//       path: 'cs@brecoflex.com',
//     );

//     if (await canLaunchUrl(emailUri)) {
//       await launchUrl(emailUri);
//     } else {
//       throw 'Could not open email client.';
//     }
//   }

//   // Method to launch the BRECOflex homepage
//   Future<void> _launchHomepage() async {
//     const url = 'https://www.brecoflex.com';
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final languageProvider = Provider.of<LanguageProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(languageProvider.translate('contact_us')),
//         backgroundColor: const Color(0xFF579039),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background image with opacity
//           Opacity(
//             opacity: 0.3, // Set opacity to 30%
//             child: Image.asset(
//               'assets/tension_meter_contact.png', // Your background image
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Centered logo image
//           Center(
//             child: Image.asset(
//               'assets/bfxLogo.png', // Your logo image
//               width: 400, // Adjust the width as needed
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.phone),
//             label: '(973) 460-9500',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.email),
//             label: 'cs@brecoflex.com',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.web),
//             label: 'www.Brecoflex.com',
//           ),
//           // BottomNavigationBarItem(
//           //     icon: Icon(Icons.house),
//           //     label: '222 Industrial Way W, Eatontown, NJ 07724')
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               _launchPhoneDialer();
//               break;
//             case 1:
//               _launchEmail();
//               break;
//             case 2:
//               _launchHomepage();
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
