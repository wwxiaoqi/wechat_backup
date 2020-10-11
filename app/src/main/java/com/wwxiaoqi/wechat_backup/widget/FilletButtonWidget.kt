package com.wwxiaoqi.wechat_backup.widget

import android.annotation.SuppressLint
import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.AppCompatTextView
import androidx.cardview.widget.CardView
import com.wwxiaoqi.wechat_backup.R

/**
 * @author: wwxiaoqi
 * @description: Fillet Button Widget
 * @date: 6/2/2020 3:22 PM
 */
class FilletButtonWidget : CardView {
  constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {
    init(context, attrs)
  }

  constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(
    context,
    attrs,
    defStyleAttr
  ) {
    init(context, attrs)
  }

  @SuppressLint("CustomViewStyleable", "InflateParams")
  private fun init(context: Context, attrs: AttributeSet?) {
    val view = LayoutInflater.from(context).inflate(R.layout.widget_button_view, null)

    val typedArray = context.obtainStyledAttributes(attrs, R.styleable.WidgetButton)
    cardElevation = typedArray.getDimension(R.styleable.WidgetButton_elevation, 0.0f)
    radius = typedArray.getDimension(
      R.styleable.WidgetButton_radius,
      getDisplayView(context, 4.0f).toFloat()
    )

    val appCompatImageView: AppCompatImageView = view.findViewById(R.id.item_button_icon)
    val appCompatTextView: AppCompatTextView = view.findViewById(R.id.item_button_text)
    appCompatTextView.setTextColor(
      typedArray.getColor(
        R.styleable.WidgetButton_text_color,
        -1
      )
    )
    appCompatTextView.text = typedArray.getString(R.styleable.WidgetButton_text)

    val mColorView = typedArray.getColor(R.styleable.WidgetButton_bg_color, 0)
    if (mColorView != 0) {
      view.setBackgroundColor(mColorView)
    }

    val resource = typedArray.getResourceId(R.styleable.WidgetButton_src, -1)
    if (resource == -1) {
      appCompatImageView.visibility = View.GONE
    } else {
      appCompatImageView.setImageResource(resource)
    }

    val mColorTint = typedArray.getColor(R.styleable.WidgetButton_tint_color, -1)
    if (mColorTint != -1) {
      appCompatImageView.setColorFilter(mColorTint)
    }

    typedArray.recycle()
    addView(view)
  }

  companion object {
    fun getDisplayView(context: Context, f: Float): Int {
      return (f * context.resources.displayMetrics.density + 0.5f).toInt()
    }
  }

}