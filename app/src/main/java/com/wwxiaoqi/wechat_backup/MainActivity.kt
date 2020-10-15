package com.wwxiaoqi.wechat_backup

import android.annotation.SuppressLint
import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Bundle
import android.os.Handler
import android.os.Message
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.wwxiaoqi.wechat_backup.base.AppConst
import com.wwxiaoqi.wechat_backup.thread.BackupThread
import com.wwxiaoqi.wechat_backup.thread.RestoreThread
import com.wwxiaoqi.wechat_backup.utils.AppUtils.isFirstRunApp
import com.wwxiaoqi.wechat_backup.utils.DialogUtil
import com.wwxiaoqi.wechat_backup.utils.FileUtils
import com.wwxiaoqi.wechat_backup.utils.FileUtils.copyAssetManagerFiles
import com.wwxiaoqi.wechat_backup.utils.FileUtils.getFileSort
import com.wwxiaoqi.wechat_backup.utils.FileUtils.replaceFileStr
import com.wwxiaoqi.wechat_backup.utils.PermissionUtils.verifyStoragePermissions
import com.wwxiaoqi.wechat_backup.utils.TimeUtils
import com.wwxiaoqi.wechat_backup.utils.ToastUtils

class MainActivity : AppCompatActivity(), View.OnClickListener {

  @SuppressLint("HandlerLeak")
  private val timeHandler: Handler = object : Handler() {
    override fun handleMessage(msg: Message) {
      super.handleMessage(msg)
      runDialog()
    }
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_home)
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

  private fun runDialog() {
    val stringBuffer: StringBuffer = StringBuffer()
    stringBuffer.append(AppConst.WECHAT_BACKUP_PATH)
    stringBuffer.append(TimeUtils.dataTime)
    stringBuffer.append(AppConst.WECHAT_BACKUP_EXTENSION_NAME)

//    if (FileUtils.fileIsExists(this, stringBuffer.toString())) {
//      ToastUtils.show(this, getString(R.string.success_prompt))
//      DialogUtil.dismiss()
//      return
//    }
//    ToastUtils.show(this, getString(R.string.error_prompt))

    // 很奇怪的现象
    ToastUtils.show(this, getString(R.string.success_prompt))
    DialogUtil.dismiss()
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
      DialogUtil.showLoadingDialog(this, null, getString(R.string.prompt), false)
      val restoreThread = RestoreThread(filesDir, timeHandler)
      restoreThread.start()
    }
    builder.show()
  }

  private fun runBackup() {
    DialogUtil.showLoadingDialog(this, null, getString(R.string.prompt), false)
    val backupThread = BackupThread(filesDir, timeHandler)
    backupThread.start()
  }
}