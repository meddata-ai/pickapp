package com.psgpw.pickapp.customviews

import android.content.Context
import android.text.InputType
import android.text.method.HideReturnsTransformationMethod
import android.text.method.PasswordTransformationMethod
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.EditText
import com.psgpw.pickapp.R
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView

class AppEditText(context: Context, attrs: AttributeSet?) : LinearLayout(context, attrs) {
    private val tvTitle: TextView
    private val editText: EditText
    private lateinit var icon: ImageView

    init {
        val a = context.obtainStyledAttributes(
            attrs,
            R.styleable.AppEditText, 0, 0
        )
        val titleText = a.getString(R.styleable.AppEditText_titleText)
        val hintText = a.getString(R.styleable.AppEditText_hintText)
        val rightText = a.getString(R.styleable.AppEditText_rightText)
        val iconRes = a.getDrawable(R.styleable.AppEditText_icon)
        val maxLine = a.getInteger(R.styleable.AppEditText_maxLines, 0)
        a.recycle()
        val inflater = context
            .getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        inflater.inflate(R.layout.app_edittext, this, true)
        tvTitle = findViewById(R.id.tvTitle)
        tvTitle.text = titleText
        editText = findViewById(R.id.edittext)
        editText.hint = hintText
        if (maxLine != 0) {
            editText.setLines(maxLine)
        }
        if (rightText != null) {
            val text = findViewById<TextView>(R.id.tv_right_text)
            text.visibility = View.VISIBLE
            text.setText(rightText)
        }
        if (iconRes != null) {
            icon = findViewById(R.id.iv_icon)
            with(icon) {
                visibility = View.VISIBLE
                this.setImageDrawable(iconRes)
            }
        }
    }

    fun getEditText(): EditText {
        return editText
    }

    fun getIcon(): ImageView? {
        return icon
    }

    fun setTitleText(title: String?) {
        tvTitle.text = title
    }

    fun showHideText() {
        editText.transformationMethod = PasswordTransformationMethod.getInstance()
        icon.setOnClickListener {
            val start = editText.selectionStart
            val end = editText.selectionEnd
            if (editText.transformationMethod.equals(PasswordTransformationMethod.getInstance())) {
                editText.transformationMethod = HideReturnsTransformationMethod.getInstance()
                icon.setImageResource(R.drawable.ic_visibility_off)
                editText.setSelection(start, end)
            } else {
                editText.transformationMethod = PasswordTransformationMethod.getInstance()
                icon.setImageResource(R.drawable.ic_visibility)
                editText.moveCursorToVisibleOffset()
                editText.setSelection(start, end)
            }
        }
    }
}