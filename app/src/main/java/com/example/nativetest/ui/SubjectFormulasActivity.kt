package com.example.nativetest.ui

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.DefaultItemAnimator
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.nativetest.R
import com.example.nativetest.adapter.FormulaAdapter
import com.example.nativetest.util.FormulaLoader
import com.example.nativetest.databinding.ActivitySubjectFormulasBinding
import com.example.nativetest.model.Formula
import com.example.nativetest.util.ReminderReceiver
import com.google.android.material.chip.Chip
import java.io.File
import java.util.Calendar

class SubjectFormulasActivity : AppCompatActivity() {

    private lateinit var binding: ActivitySubjectFormulasBinding
    private lateinit var adapter: FormulaAdapter
    private lateinit var recentAdapter: FormulaAdapter
    private var allFormulas: List<Formula> = emptyList()
    private var subjectName = ""
    private var classNumber = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setTheme(R.style.AppTheme)
        binding = ActivitySubjectFormulasBinding.inflate(layoutInflater)
        setContentView(binding.root)

        subjectName = intent.getStringExtra("subject_name") ?: ""
        classNumber = intent.getIntExtra("class_number", 0)
        binding.subjectTitle.text = subjectName

        adapter = FormulaAdapter()
        recentAdapter = FormulaAdapter()

        binding.formulaRecyclerView.layoutManager = LinearLayoutManager(this)
        binding.formulaRecyclerView.adapter = adapter
        (binding.formulaRecyclerView.itemAnimator as? DefaultItemAnimator)?.apply {
            addDuration = 150
            removeDuration = 150
            moveDuration = 150
            changeDuration = 150
        }

        binding.recentRecyclerView.layoutManager =
            LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false)
        binding.recentRecyclerView.adapter = recentAdapter

        allFormulas = FormulaLoader.loadFormulasFromAssets(this, subjectName, classNumber)
        adapter.submitList(allFormulas)

        //----tag-based filtering with UI chips
        val allTags = allFormulas.flatMap { it.tags ?: emptyList() }.distinct()
        binding.tagFilterGroup.removeAllViews()
        allTags.forEach { tag ->
            val chip = Chip(this).apply {
                text = tag
                isCheckable = true
                isClickable = true
            }
            binding.tagFilterGroup.addView(chip)
        }
        binding.tagFilterGroup.setOnCheckedChangeListener { group, checkedId ->
            val chip = group.findViewById<Chip>(checkedId)
            val selectedTag = chip?.text?.toString()

            val filtered = if (selectedTag != null) {
                allFormulas.filter { it.tags?.contains(selectedTag) == true }
            } else allFormulas

            adapter.submitList(filtered)
        }
        //tag-based filtering with UI chips


        loadRecentFormulas()

        binding.searchInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}
            override fun afterTextChanged(s: Editable?) {
                val query = s.toString().lowercase()
                val filtered = allFormulas.filter {
                    it.title.lowercase().contains(query) ||
                            it.expression.lowercase().contains(query)
                }
                adapter.submitList(filtered)
            }
        })

        // Back button ripple and navigation
        binding.backButton.apply {
            background = ContextCompat.getDrawable(
                this@SubjectFormulasActivity,
                R.drawable.ripple_background
            )
            setOnClickListener { finish() }
        }

        // Schedule reminder notification (1 per day at 8PM)
        scheduleDailyReminder()

        binding.shareRecentButton.setOnClickListener {
            val fileName = "test_app_recent_formulas_${subjectName}_${classNumber}.txt"
            val file = File(filesDir, fileName)

            if (!file.exists()) {
                android.widget.Toast.makeText(
                    this,
                    "No recent formulas to share yet!",
                    android.widget.Toast.LENGTH_SHORT
                ).show()
                return@setOnClickListener
            }

            val uri = androidx.core.content.FileProvider.getUriForFile(
                this,
                "${packageName}.fileprovider",
                file
            )

            val shareIntent = Intent(Intent.ACTION_SEND).apply {
                type = "text/plain"
                putExtra(Intent.EXTRA_STREAM, uri)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            startActivity(Intent.createChooser(shareIntent, "Share via"))
        }

    }

    override fun onResume() {
        super.onResume()
        maybeShowRatePrompt()
    }

    private fun maybeShowRatePrompt() {
        val prefs = getSharedPreferences("user_feedback", Context.MODE_PRIVATE)
        val launches = prefs.getInt("launch_count", 0) + 1
        prefs.edit().putInt("launch_count", launches).apply()

        if (launches == 3 || launches == 7 || launches == 15) {
            android.app.AlertDialog.Builder(this)
                .setTitle("Enjoying Test App?")
                .setMessage("If you find this app helpful, please consider leaving a review!")
                .setPositiveButton("Rate Now") { _, _ ->
                    val intent = Intent(Intent.ACTION_VIEW)
                    intent.data =
                        android.net.Uri.parse("https://play.google.com/store/apps/details?id=$packageName")
                    startActivity(intent)
                }
                .setNegativeButton("Maybe Later", null)
                .show()
        }
    }

    private fun loadRecentFormulas() {
        val prefs = getSharedPreferences("recent_formulas", Context.MODE_PRIVATE)
        val recentTitles =
            prefs.getStringSet("recent_${subjectName}_${classNumber}", emptySet()) ?: emptySet()
        val recentList = allFormulas.filter { recentTitles.contains(it.title) }
        if (recentList.isNotEmpty()) {
            binding.recentTitle.visibility = View.VISIBLE
            binding.recentRecyclerView.visibility = View.VISIBLE
            recentAdapter.submitList(recentList)
        }
    }

    override fun onPause() {
        super.onPause()
        saveRecentFormulas()
//        exportRecentFormulas()
    }

    private fun saveRecentFormulas() {
        val prefs = getSharedPreferences("recent_formulas", Context.MODE_PRIVATE)
        val editor = prefs.edit()
        val viewedTitles = adapter.currentList.take(5).map { it.title }.toSet()
        editor.putStringSet("recent_${subjectName}_${classNumber}", viewedTitles)
        editor.apply()
    }

    private fun scheduleDailyReminder() {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, ReminderReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val calendar = Calendar.getInstance().apply {
            timeInMillis = System.currentTimeMillis()
            set(Calendar.HOUR_OF_DAY, 20)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
        }

        alarmManager.setRepeating(
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            AlarmManager.INTERVAL_DAY,
            pendingIntent
        )
    }

    private fun exportRecentFormulas() {
        val prefs = getSharedPreferences("recent_formulas", Context.MODE_PRIVATE)
        val recentTitles =
            prefs.getStringSet("recent_${subjectName}_${classNumber}", emptySet()) ?: emptySet()
        val fileName = "test_recent_formulas_${subjectName}_${classNumber}.txt"
        val fileContent = recentTitles.joinToString(separator = " ")
        try {
            openFileOutput(fileName, Context.MODE_PRIVATE).use {
                it.write(fileContent.toByteArray())
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}

