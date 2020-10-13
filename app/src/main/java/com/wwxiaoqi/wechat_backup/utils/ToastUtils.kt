package com.wwxiaoqi.wechat_backup.utils

import android.content.Context
import android.view.Gravity
import android.widget.Toast


object ToastUtils {
  fun show(context: Context?, text: CharSequence?) {
    val toast: Toast = Toast.makeText(context, text, Toast.LENGTH_LONG)
    toast.setGravity(Gravity.CENTER, 0, 0)
    toast.show()
  }
}