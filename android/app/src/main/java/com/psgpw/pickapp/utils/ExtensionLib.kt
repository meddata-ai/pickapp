package com.psgpw.pickapp.utils

import android.app.Activity
import android.content.Context
import android.content.res.Resources
import android.util.TypedValue
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import com.psgpw.pickapp.R
import java.security.MessageDigest


fun Activity.toastShow(message: String) {
    Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
}


fun Context.showTwoButtonAlert(message: String, function: () -> Unit) {
    val builder = AlertDialog.Builder(this, R.style.AlertDialogTheme)
    builder.setTitle("Message")
    builder.setMessage(message)

    builder.setNegativeButton("No") { dialogInterface, which ->

        dialogInterface.dismiss()
    }

    builder.setPositiveButton("Yes") { dialogInterface, which ->
        function.invoke()
    }

    val alertDialog: AlertDialog = builder.create()
    alertDialog.window?.setBackgroundDrawableResource(android.R.color.transparent)

    alertDialog.setCancelable(false)
    alertDialog.show()
}

fun Activity.showAlert(message: String) {
    val builder = AlertDialog.Builder(this, R.style.AlertDialogTheme)
    val layout = layoutInflater.inflate(R.layout.dialog_alert, null)
    builder.setView(layout)
    layout.findViewById<TextView>(R.id.tv_message).setText(message)
    //layout.findViewById<TextView>(R.id.tv_thanks).setText("Thank you")

    val alertDialog: AlertDialog = builder.create()
    alertDialog.window?.setBackgroundDrawableResource(android.R.color.transparent)
    layout.findViewById<ImageView>(R.id.close).setOnClickListener {
        alertDialog.dismiss()
    }
    alertDialog.setCancelable(false)
    alertDialog.show()
}

fun Activity.showLogoutAlert(function: () -> Unit) {
    val builder = AlertDialog.Builder(this, R.style.AlertDialogTheme)
    val layout = layoutInflater.inflate(R.layout.dialog_logout, null)
    builder.setView(layout)
    //layout.findViewById<TextView>(R.id.tv_message).setText(message)
    //layout.findViewById<TextView>(R.id.tv_thanks).setText("Thank you")

    val alertDialog: AlertDialog = builder.create()
    alertDialog.window?.setBackgroundDrawableResource(android.R.color.transparent)
    layout.findViewById<ImageView>(R.id.close).setOnClickListener {
        alertDialog.dismiss()
    }
    layout.findViewById<TextView>(R.id.tv_no).setOnClickListener {
        alertDialog.dismiss()
    }
    layout.findViewById<TextView>(R.id.tv_yes).setOnClickListener {
        function.invoke()
    }
    alertDialog.setCancelable(false)
    alertDialog.show()
}

val Number.toPx get() = TypedValue.applyDimension(
    TypedValue.COMPLEX_UNIT_DIP,
    this.toFloat(),
    Resources.getSystem().displayMetrics)