package com.wwxiaoqi.wechat_backup.thread

import android.os.Handler
import android.os.Message
import com.wwxiaoqi.wechat_backup.utils.ShellUtils
import java.io.File

class BackupThread(
  private val fileDir: File,
  private val timeHandler: Handler
) : Thread() {
  override fun run() {
    try {
      Thread {
        val cmd = arrayOf("su", "source $fileDir/backup.sh")
        ShellUtils.execCmd(cmd, true)
      }.start()
      sleep(3000)
      val message: Message = Message.obtain()
      message.what = 0
      timeHandler.sendMessage(message)
    } catch (e: InterruptedException) {
      e.printStackTrace()
    }
  }
}