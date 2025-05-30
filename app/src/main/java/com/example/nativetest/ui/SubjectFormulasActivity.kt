package com.example.nativetest.ui

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
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
import java.util.Calendar

class SubjectFormulasActivity : AppCompatActivity() {

    private lateinit var binding: ActivitySubjectFormulasBinding
    private lateinit var adapter: FormulaAdapter
    private var allFormulas: List<Formula> = emptyList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setTheme(R.style.AppTheme)
        binding = ActivitySubjectFormulasBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val subjectName = intent.getStringExtra("subject_name") ?: ""
        val classNumber = intent.getIntExtra("class_number", 0)
        binding.subjectTitle.text = subjectName

        adapter = FormulaAdapter()
        binding.formulaRecyclerView.layoutManager = LinearLayoutManager(this)
        binding.formulaRecyclerView.adapter = adapter
        (binding.formulaRecyclerView.itemAnimator as? DefaultItemAnimator)?.apply {
            addDuration = 150
            removeDuration = 150
            moveDuration = 150
            changeDuration = 150
        }

        allFormulas = FormulaLoader.loadFormulasFromAssets(this, subjectName, classNumber)
        adapter.submitList(allFormulas)

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
            background = ContextCompat.getDrawable(this@SubjectFormulasActivity, R.drawable.ripple_background)
            setOnClickListener { finish() }
        }

        // Schedule reminder notification (1 per day at 8PM)
        scheduleDailyReminder()
    }

    private fun scheduleDailyReminder() {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, ReminderReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

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
}
