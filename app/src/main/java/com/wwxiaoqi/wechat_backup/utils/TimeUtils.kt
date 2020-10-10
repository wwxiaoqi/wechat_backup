package com.wwxiaoqi.wechat_backup.utils

import java.text.SimpleDateFormat
import java.util.*

/**
 * 时间工具类
 */
object TimeUtils {
  /***
   * 获取当前时间日期
   * @return 返回 yyyyMMdd 格式
   */
  val dataTime: String
    get() {
      val format = SimpleDateFormat("yyyyMMdd", Locale.CHINA)
      return format.format(Calendar.getInstance().time)
    }
}