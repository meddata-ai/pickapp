package com.psgpw.pickapp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.lifecycleScope
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.databinding.ActivitySplashBinding
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.collect

class SplashActivity : AppCompatActivity() {
    private lateinit var binding: ActivitySplashBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySplashBinding.inflate(layoutInflater)

        lifecycleScope.launchWhenCreated {
            delay(1000)
            DataStoreManager(this@SplashActivity).isUserLogin().collect { loginStatus ->
                if (loginStatus) {
                    openHomeActivity()
                } else {
                    openLoginActivity()
                }
                finish()
            }
        }

        setContentView(binding.root)
    }

    private fun openLoginActivity() {
        startActivity(
            Intent(
                this@SplashActivity,
                LoginSignUpActivity::class.java
            )
        )
    }

    private fun openHomeActivity() {
        startActivity(
            Intent(
                this@SplashActivity,
                HomeActivity::class.java
            )
        )
    }
}