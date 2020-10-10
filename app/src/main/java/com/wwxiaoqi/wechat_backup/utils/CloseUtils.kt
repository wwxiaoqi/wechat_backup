package com.wwxiaoqi.wechat_backup.utils

import java.io.Closeable
import java.io.IOException

/**
 * 关闭相关工具类
 */
object CloseUtils {
  /**
   * 关闭 IO
   *
   * @param closeables closeables
   */
  fun closeIO(vararg closeables: Closeable?) {
    for (closeable in closeables) {
      if (closeable != null) {
        try {
          closeable.close()
        } catch (e: IOException) {
          e.printStackTrace()
        }
      }
    }
  }

  /**
   * 安静关闭 IO
   *
   * @param closeables closeables
   */
  fun closeIOQuietly(vararg closeables: Closeable?) {
    for (closeable in closeables) {
      if (closeable != null) {
        try {
          closeable.close()
        } catch (ignored: IOException) {
        }
      }
    }
  }
}