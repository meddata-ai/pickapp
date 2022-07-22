package com.psgpw.pickapp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import androidx.appcompat.widget.Toolbar
import androidx.navigation.NavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.Navigation
import androidx.navigation.findNavController
import androidx.navigation.fragment.findNavController
import androidx.navigation.ui.NavigationUI
import com.google.android.material.bottomnavigation.BottomNavigationItemView
import com.google.android.material.bottomnavigation.BottomNavigationView

class HomeActivity : AppCompatActivity() {
    //private lateinit var binding: ActivityHomeBinding
    private var navController: NavController? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //binding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(R.layout.activity_home)

        val navView = findViewById<BottomNavigationView>(R.id.nav_view)
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        val appBarConfiguration = AppBarConfiguration.Builder(
            R.id.navigation_sender_list, R.id.navigation_deliver_list, R.id.navigation_fav_list
        )
            .build()
        navController =
            Navigation.findNavController(this, R.id.nav_host_fragment_activity_home)
        //NavigationUI.setupActionBarWithNavController(this, navController, appBarConfiguration);
        NavigationUI.setupWithNavController(navView, navController!!)

    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        if (intent != null) {
            val navigateKey = intent.getStringExtra("NAVIGATE_KEY")
            when (navigateKey) {
                "SETTING" -> navController?.navigate(R.id.action_navigate_to_settingFragment)
                "FIND_SENDER" -> navController?.navigate(R.id.navigation_sender_list)
                "FIND_DELIVER" -> navController?.navigate(R.id.navigation_deliver_list)
            }
        }
    }
}