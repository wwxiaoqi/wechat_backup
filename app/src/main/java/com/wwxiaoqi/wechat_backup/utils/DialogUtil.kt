package com.wwxiaoqi.wechat_backup.utils

import android.app.ProgressDialog
import android.content.Context
import android.content.DialogInterface
import java.lang.ref.WeakReference

object DialogUtil {
  private var weakReference: WeakReference<ProgressDialog?>? = null

  fun dismiss() {
    if (weakReference!!.get() != null && weakReference!!.get()!!.isShowing) {
      weakReference!!.get()!!.dismiss()
    }
  }

  /**
   * 圆形进度转圈
   *
   * @param context
   * @param title 标题
   * @param message 内容
   * @param cancelable 点击外部是否消失,为 true 可以点击消失
   * @param cancelListener dialog 取消监听器
   */
  fun showLoadingDialog(context: Context?, title: String?, message: String?, cancelable: Boolean?, cancelListener: DialogInterface.OnCancelListener?) {
    val progressDialog = ProgressDialog.show(
      context, title, message, false,
      cancelable!!, cancelListener
    )
    weakReference = WeakReference(progressDialog)
  }

  fun showLoadingDialog(context: Context?, title: String?, message: String?, cancelable: Boolean?) {
    val progressDialog = ProgressDialog.show(
      context, title, message, false,
      cancelable!!
    )
    weakReference = WeakReference(progressDialog)
  }

}