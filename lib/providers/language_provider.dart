import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'English';

  String get currentLanguage => _currentLanguage;

  void changeLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  String translate(String key) {
    const translations = {
      'English': {
        'welcome': 'Welcome',
        'check': 'Check',
        'set': 'Set',
        'contact_us': 'Contact Us',
        'send_us_a_message': 'Send us a message',
        'your_name': 'Your Name',
        'your_email': 'Your Email',
        'your_message': 'Your Message',
        'send_message': 'Send Message',
        'select_belt_pitch': 'Select Belt Pitch',
        'check_pre_tension': 'Check Pre-tension',
        'belt_width': 'Belt Width',
        'free_span_length': 'Free Span Length',
        'frequency': 'Frequency',
        'tension': 'Tension',
        'select_material': 'Select Material',
        'desired_tension': 'Desired Tension',
        'calculate_frequency': 'Calculate Frequency',
        'calculate': 'Calculate',
        'set_pretension': 'Set Pretension',
        'check_pretension': 'Check Pretension',
        'select_belt_series': 'Select Belt Series',
        'select_pitch': 'Select Pitch',
        'Companion_App': 'Companion App for use with BRECOflex Tension Meter',
        'check_tension': 'Check Tension',
        'set_tension': 'Set Tension'
      },
      'Spanish': {
        'welcome': 'Bienvenido',
        'check': 'Comprobar',
        'set': 'Configurar',
        'contact_us': 'Contáctenos',
        'send_us_a_message': 'Envíenos un mensaje',
        'your_name': 'Tu Nombre',
        'your_email': 'Tu Correo Electrónico',
        'your_message': 'Tu Mensaje',
        'send_message': 'Enviar Mensaje',
        'select_belt_pitch': 'Seleccione el paso de la correa',
        'check_pre_tension': 'Comprobar la pretensión',
        'belt_width': 'Ancho de la banda',
        'free_span_length': 'Longitud de tramo libre',
        'frequency': 'Frecuencia',
        'tension': 'Tensión',
        'select_material': 'Seleccione material',
        'desired_tension': 'Tensión deseada',
        'calculate_frequency': 'Calcular la frecuencia',
        'calculate': 'calcular',
        'set_pretension': 'Establecer pretensión',
        'check_pretension': 'Comprobar pretensión',
        'select_belt_series': 'Seleccionar serie de correas',
        'select_pitch': 'Seleccionar Pitch',
        'Companion_App':
            'Aplicación complementaria para usar con el tensiómetro BRECOflex',
        'set_tension': 'Establecer tensión',
        'check_tension': 'Verificar la tensión'
      },
      'German': {
        'welcome': 'Willkommen',
        'check': 'Überprüfen',
        'set': 'Einstellen',
        'contact_us': 'Kontaktieren Sie uns',
        'send_us_a_message': 'Senden Sie uns eine Nachricht',
        'your_name': 'Ihr Name',
        'your_email': 'Ihre E-Mail',
        'your_message': 'Ihre Nachricht',
        'send_message': 'Nachricht senden',
        'select_belt_pitch': 'Wählen Sie den Riemenpitch',
        'check_pre_tension': 'Prüfen Sie die Vorspannung',
        'belt_width': 'Belt Breite',
        'free_span_length': 'Freie Spannlänge',
        'frequency': 'Frequenz',
        'tension': 'Spannung',
        'select_material': 'Material auswählen',
        'desired_tension': 'Gewünschte Spannung',
        'calculate_frequency': 'Häufigkeit berechnen',
        'calculate': 'berechnen',
        'set_pretension': 'Vorspannung einstellen',
        'check_pretension': 'Vorspannung prüfen',
        'select_belt_series': 'Riemenserie auswählen',
        'select_pitch': 'Tonhöhe auswählen',
        'Companion_App':
            'Begleit-App zur Verwendung mit dem BRECOflex-Spannungsmessgerät',
        'check_tension': 'Spannung prüfen',
        'set_tension': 'Spannung einstellen'
      },
      'French': {
        'welcome': 'Bienvenue',
        'check': 'Vérifier',
        'set': 'Définir',
        'contact_us': 'Contactez-nous',
        'send_us_a_message': 'Envoyez-nous un message',
        'your_name': 'Votre Nom',
        'your_email': 'Votre Email',
        'your_message': 'Votre Message',
        'send_message': 'Envoyer le Message',
        'select_belt_pitch': 'Sélectionner le pas de la courroie',
        'check_pre_tension': 'Vérifier la pré-tension',
        'belt_width': 'Largeur de la courroie',
        'free_span_length': 'Longueur de portée libre',
        'frequency': 'Fréquence',
        'tension': 'Tension',
        'select_material': 'Sélectionner le matériau',
        'desired_tension': 'Tension désirée',
        'calculate_frequency': 'Calculer la fréquence',
        'calculate': 'Calculer',
        'set_pretension': 'Définir la prétension',
        'check_pretension': 'Vérifier la prétension',
        'select_belt_series': 'Sélectionner la série de courroies',
        'select_pitch': 'Sélectionnez Pitch',
        'Companion_App':
            'Application compagnon à utiliser avec le tensiomètre BRECOflex',
        'set_tension': 'Régler la tension',
        'check_tension': 'Vérifier la tension'
      },
    };

    return translations[_currentLanguage]?[key] ?? key;
  }
}
