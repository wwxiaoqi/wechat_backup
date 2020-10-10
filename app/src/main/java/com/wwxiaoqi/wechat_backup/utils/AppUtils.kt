package com.wwxiaoqi.wechat_backup.utils

import android.content.Context

object AppUtils {

  /**
   * 判断 app 是否第一次运行
   * @param context Context
   */
  fun isFirstRunApp(context: Context): Boolean {
    val sharedPreferences = context.getSharedPreferences("share", Context.MODE_PRIVATE)
    val isFirstRun = sharedPreferences.getBoolean("isFirstRun", true)
    val editor = sharedPreferences.edit()
    if (isFirstRun) {
      editor.putBoolean("isFirstRun", false)
      editor.apply()
      return true
    }
    return false
  }
}