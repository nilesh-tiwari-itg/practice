package com.example.nativetest

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.inputmethod.InputMethodManager
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.Fragment
import com.example.nativetest.R
import com.example.nativetest.databinding.ActivityMainBinding
import com.example.nativetest.ui.ClassWiseFormulasActivity
import com.example.nativetest.ui.ClassWiseFormulasFragment
import com.example.nativetest.ui.SettingsActivity
import com.example.nativetest.ui.SettingsFragment
import com.example.nativetest.ui.ToolSelectionFragment
import com.example.nativetest.ui.fragments.FavoritesFragment
import com.example.nativetest.ui.fragments.GameModeFragment
import com.example.nativetest.ui.fragments.QuizFragment

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        enableEdgeToEdge()
//        setContentView(R.layout.activity_main)
//        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
//            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
//            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
//            insets
//        }
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        //Dismiss keyboard when scrolling RecyclerView or tapping background:
        binding.root.setOnTouchListener { _, _ ->
            val imm = this.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.hideSoftInputFromWindow(binding.root.windowToken, 0)
            false
        }

        // Load default fragment
        loadFragment(ClassWiseFormulasFragment())

        binding.bottomNavigationView.setOnItemSelectedListener { item ->
            val fragment: Fragment = when (item.itemId) {
                R.id.menu_home -> ClassWiseFormulasFragment()
                R.id.menu_tools -> ToolSelectionFragment()
                R.id.menu_settings -> SettingsFragment()
                R.id.menu_favorites -> FavoritesFragment()
                R.id.menu_game_mode -> GameModeFragment()
                else -> ClassWiseFormulasFragment()
            }
            loadFragment(fragment)
            true
        }
    }

    private fun loadFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction()
            .setCustomAnimations(R.anim.slide_in_right, R.anim.slide_out_left)
            .replace(R.id.contentFrame, fragment)
//            .addToBackStack(null)
            .commit()
    }
}

