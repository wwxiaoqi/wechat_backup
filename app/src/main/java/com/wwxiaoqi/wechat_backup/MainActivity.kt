package com.wwxiaoqi.wechat_backup

import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.wwxiaoqi.wechat_backup.base.AppConst
import com.wwxiaoqi.wechat_backup.thread.BackupThread
import com.wwxiaoqi.wechat_backup.thread.RestoreThread
import com.wwxiaoqi.wechat_backup.utils.AppUtils.isFirstRunApp
import com.wwxiaoqi.wechat_backup.utils.FileUtils.copyAssetManagerFiles
import com.wwxiaoqi.wechat_backup.utils.FileUtils.getFileSort
import com.wwxiaoqi.wechat_backup.utils.FileUtils.replaceFileStr
import com.wwxiaoqi.wechat_backup.utils.PermissionUtils.verifyStoragePermissions

class MainActivity : AppCompatActivity(), View.OnClickListener {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    init()
    initPermission()
    initView()
  }

  private fun init() {
    if (isFirstRunApp(this)) {
      copyAssetManagerFiles(assets, filesDir, "backup.sh")
      copyAssetManagerFiles(assets, filesDir, "recovery.sh")
    }
  }

  private fun initPermission() {
    verifyStoragePermissions(this)
  }

  private fun initView() {
    findViewById<View>(R.id.btn_backup).setOnClickListener(this)
    findViewById<View>(R.id.btn_restore).setOnClickListener(this)
  }

  override fun onClick(view: View) {
    when (view.id) {
      R.id.btn_backup -> runBackup()
      R.id.btn_restore -> runRestore()
    }
  }

  private fun runRestore() {
    val list = getFileSort(AppConst.WECHAT_BACKUP_PATH)
    val array = arrayOfNulls<String>(list.size)
    for ((index, value) in list.withIndex()) {
      array[index] = value.name
    }
    val builder = AlertDialog.Builder(this)
    builder.setItems(array) { _: DialogInterface?, which: Int ->
      var options = array[which]
      options = options!!.replace(AppConst.WECHAT_BACKUP_EXTENSION_NAME, "")
      replaceFileStr(
        "$filesDir/recovery.sh",
        "recovery_date=\"(.*)\"",
        "recovery_date=\"$options\""
      )
      val restoreThread = RestoreThread(this, filesDir)
      restoreThread.start()
    }
    builder.show()
  }

  private fun runBackup() {
    val backupThread = BackupThread(this, filesDir)
    backupThread.start()
  }
}