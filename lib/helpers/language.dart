// ignore_for_file: unnecessary_string_escapes, equal_keys_in_map

import 'package:get/get.dart';

final class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE
        'en_US': {
          "Delivery Man Info": "Delivery Man Info",
          "Do you want to exit the app?": "Do you want to exit the app?",
        },

        //Portuguese LANGUAGE
        'pt_PT': {
          "Delivery Man Info": "Informações do entregador",
          "Do you want to exit the app?": "Queres sair da aplicação",
        },

        //Spanish Language
        'es_ES': {
          "Delivery Man Info": "Información del repartidor",
          "Do you want to exit the app?": "¿Quieres salir de la aplicación?",
        },

        //Russian Language
        'ru_RU': {
          "Delivery Man Info": "Информация о курьере",
          "Do you want to exit the app?": "Хотите выйти из приложения?",
        },

        //Dutch Language
        'de_DE': {
          "Delivery Man Info": "Informatie Bezorger",
          "Do you want to exit the app?": "Wilt u de app afsluiten?",
        },

        //French Language
        'fr_FR': {
          "Delivery Man Info": "Informations sur le livreur",
          "Do you want to exit the app?": "Voulezvous quitter l'application?",
        }
      };
}
