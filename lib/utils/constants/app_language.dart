import 'package:get/get_navigation/src/root/internacionalization.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'uz_UZ': {
          'password_invalid':
              "Parolning uzunligi eng kamida \n8 ta belgidan iborat bo'lishi shart!",
          'email_not_valid': 'Elektron pochta xato kiritildi!',
          'referall_not_valid': 'Referallni kiritish lozim!',
          'name_not_valid': "Ismda eng kamida 4 ta \nbelgi bo'lishi lozim",
          'sign_up': "Ro'yxatdan o'tish",
          'login': 'Kirish',
          '': 'Login to your account',
          'do_not_have_an_account': "Shaxsiy hisobingiz yo'qmi?",
          'email': 'Elektron pochta',
          'password': "Maxfiy so'z",
          'create_account': 'Shaxsiy hisob oching, bu tekin ;) ',
          'login_to_your_account': 'Shaxsiy hisobga kirish',
          'name': 'Ism',
          'surname': 'Familiya',
          'Already have an account?': 'Allaqachon shaxsiy hisobingiz bormi? ',
          'Login': 'Kirish'
        },
        'en_En': {
          'password_invalid':
              'The password must contain at least \n8 characters!',
          'email_not_valid': 'E-mail entered incorrectly!',
          'referall_not_valid': 'You need to enter your referall!',
          'name_not_valid': 'Name must contain at \nleast 4 characters',
          'sign_up': 'Sign Up',
          'login': 'Login',
          'do_not_have_an_account': "Don't have an account?",
          'email': 'Email',
          'password': 'Password',
          'create_account': "Create an account, It's free ",
          'login_to_your_account': 'Login to your account',
          'name': 'Name',
          'surname': 'Surname'
        }
      };
}
