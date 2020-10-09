package com.wwxiaoqi.wechat_backup.utils;

import android.app.Activity;
import android.content.pm.PackageManager;
import androidx.core.app.ActivityCompat;

/**
 * android 权限
 */
public class PermissionUtils {
  private static final int REQUEST_EXTERNAL_STORAGE = 1;

  private static String[] PERMISSIONS_STORAGE = {
      "android.permission.READ_EXTERNAL_STORAGE",
      "android.permission.WRITE_EXTERNAL_STORAGE"
  };

  /***
   * 动态权限申请
   * @param activity Activity
   */
  public static void verifyStoragePermissions(Activity activity) {
    try {
      // 检测是否有写的权限
      int permission = ActivityCompat.checkSelfPermission(activity, "android.permission.WRITE_EXTERNAL_STORAGE");
      if (permission != PackageManager.PERMISSION_GRANTED) {
        // 没有写的权限，去申请写的权限，会弹出对话框
        ActivityCompat.requestPermissions(activity, PERMISSIONS_STORAGE, REQUEST_EXTERNAL_STORAGE);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}