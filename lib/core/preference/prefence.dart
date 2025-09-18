import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences?shared;
  static init()async{
    shared = await SharedPreferences.getInstance();
  }

  static saveTheme({required String key,required String value}){
    return shared?.setString(key, value);
  }

  static getTheme({required String key}){
    return shared?.getString(key);
  }


  static saveLang({required String key,required String value}){
    return shared?.setString(key, value);
  }

  static getLang({required String key}){
    return shared?.getString(key);
  }

}