package com.psgpw.pickapp

import android.app.Application
import android.util.Log
import com.google.android.libraries.places.api.Places
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class PickApp : Application() {

    override fun onCreate() {
        super.onCreate()
        Log.d("PickApp", "Application onCreate()")

    }

}