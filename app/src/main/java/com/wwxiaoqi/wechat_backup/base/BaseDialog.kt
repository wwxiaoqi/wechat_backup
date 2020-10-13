package com.wwxiaoqi.wechat_backup.base

import android.app.ProgressDialog
import android.content.Context
import android.os.Handler

object BaseDialog {
  private lateinit var progressDialog: ProgressDialog

  fun init(context: Context) {
    progressDialog = ProgressDialog(context)
  }

  fun startDialog(str: String) {
    modifyDialog(str)
    progressDialog.setCancelable(false)
    progressDialog.show()
  }

  fun modifyDialog(str: String) {
    progressDialog.setMessage(str)
  }

  fun hideDialog() {
    progressDialog.dismiss()
  }
}