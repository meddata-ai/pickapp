package com.psgpw.pickapp.utils

import android.text.Editable
import android.text.TextWatcher
import android.util.Patterns
import android.widget.EditText

private fun EditText.afterTextChanged(afterTextChanged: (String) -> Unit) {
    this.addTextChangedListener(object : TextWatcher {
        override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
        }

        override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        }

        override fun afterTextChanged(s: Editable?) {
            afterTextChanged.invoke(s.toString().trim())
        }

    })
}

private fun EditText.validate(message: String, validator: (String) -> Boolean) {
    this.afterTextChanged {
        this.error = if (validator(it)) null else message
    }
     this.error = if (validator(this.text.toString())) null else message
}

fun EditText.isValidEmail(message: String) {
    this.validate(message) {
        it.isValidEmail()
    }
}

fun EditText.isNotEmpty(message: String) {
    validate(message) {
        it.isNotEmpty()
    }
}

fun EditText.isValidName(message: String) {
    this.validate(message) {
        it.isValidName()
    }
}

fun EditText.isValidPassword(message: String) {
    this.validate(message) {
        it.isValidPassword()
    }
}

fun EditText.isValidConfirmPassword(message: String, password: EditText) {
    this.validate(message) {
        //Log.d("Password", password.text.toString())
        it.isValidConfirmPassword(password.text.toString())
    }
}


fun String.isValidConfirmPassword(password: String): Boolean {

    return this.compareTo(password,false) == 0
   // return true
}

fun String.isValidPassword(): Boolean {
    return this.length > 2
}


fun String.isValidName(): Boolean {
    return this.isNotEmpty() && this.length > 2
}

fun String.isValidEmail(): Boolean =
    this.isNotEmpty() && Patterns.EMAIL_ADDRESS.matcher(this).matches()
