package com.wwxiaoqi.wechat_backup.utils;

import java.io.Closeable;
import java.io.IOException;

/**
 * 关闭相关工具类
 */
public final class CloseUtils {

  /**
   * 关闭 IO
   *
   * @param closeables closeables
   */
  public static void closeIO(Closeable... closeables) {
    if (closeables == null) return;
    for (Closeable closeable : closeables) {
      if (closeable != null) {
        try {
          closeable.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
  }

  /**
   * 安静关闭 IO
   *
   * @param closeables closeables
   */
  public static void closeIOQuietly(Closeable... closeables) {
    if (closeables == null) return;
    for (Closeable closeable : closeables) {
      if (closeable != null) {
        try {
          closeable.close();
        } catch (IOException ignored) {
        }
      }
    }
  }
}