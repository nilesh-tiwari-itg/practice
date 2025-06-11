package com.example.nativetest.ui

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.nativetest.R
import android.content.Intent
import android.view.animation.AnimationUtils
import android.widget.ImageView
import android.widget.TextView
import com.example.nativetest.MainActivity

class SplashActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_splash)
//        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
//            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
//            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
//            insets
//        }

        val logo = findViewById<ImageView>(R.id.logoImage)
        val title = findViewById<TextView>(R.id.splashText)

        val anim = AnimationUtils.loadAnimation(this, R.anim.zoom_fade)
        logo.startAnimation(anim)
        title.startAnimation(anim)

        logo.postDelayed({
            startActivity(Intent(this, MainActivity::class.java))
            finish()
        }, 2000)
    }
}
