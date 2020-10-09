package com.wwxiaoqi.wechat_backup.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

/**
 * 时间工具类
 */
public class TimeUtils {

  /***
   * 获取当前时间日期
   * @return 返回 yyyyMMdd 格式
   */
  public static String getDataTime() {
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.CHINA);
    return format.format(Calendar.getInstance().getTime());
  }

}
