package com.wwxiaoqi.wechat_backup.utils;

import android.content.Context;
import android.content.SharedPreferences;

public class AppUtils {

  public static boolean isFirstRunApp(Context context) {
    SharedPreferences sharedPreferences = context.getSharedPreferences("share", Context.MODE_PRIVATE);
    boolean isFirstRun = sharedPreferences.getBoolean("isFirstRun", true);
    SharedPreferences.Editor editor = sharedPreferences.edit();
    if (isFirstRun) {
      editor.putBoolean("isFirstRun", false);
      editor.apply();
      return true;
    }
    return false;
  }

}