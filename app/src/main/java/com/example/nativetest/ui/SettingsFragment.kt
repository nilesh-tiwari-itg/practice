package com.example.nativetest.ui

import android.app.AlarmManager
import android.app.PendingIntent
import android.app.TimePickerDialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.Button
import com.example.nativetest.R
import android.widget.CompoundButton
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatDelegate
import com.example.nativetest.databinding.FragmentSettingsBinding
import com.example.nativetest.util.ReminderReceiver
import java.io.File
import java.util.Calendar


class SettingsFragment : Fragment() {

    private var _binding: FragmentSettingsBinding? = null
    private val binding get() = _binding!!
    private val classList = listOf("8", "9", "10", "11", "12")
    private val subjectList =
        listOf("Algebra", "Geometry", "Mensuration", "Statistics", "Arithmetic")
    private var selectedHour = 20
    private var selectedMinute = 0


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentSettingsBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val prefs = requireContext().getSharedPreferences("user_prefs", Context.MODE_PRIVATE)
        val isDarkMode = prefs.getBoolean("dark_mode", false)

        binding.switchDarkMode.isChecked = isDarkMode
        binding.switchDarkMode.setOnCheckedChangeListener { _: CompoundButton, isChecked: Boolean ->
            prefs.edit().putBoolean("dark_mode", isChecked).apply()
            AppCompatDelegate.setDefaultNightMode(
                if (isChecked) AppCompatDelegate.MODE_NIGHT_YES else AppCompatDelegate.MODE_NIGHT_NO
            )
        }
        val classAdapter =
            ArrayAdapter(requireContext(), android.R.layout.simple_spinner_item, classList)
        binding.classSpinner.adapter = classAdapter

        val subjectAdapter =
            ArrayAdapter(requireContext(), android.R.layout.simple_spinner_item, subjectList)
        binding.subjectSpinner.adapter = subjectAdapter
        binding.viewExportedButton.setOnClickListener {
            val selectedClass = binding.classSpinner.selectedItem.toString()
            val selectedSubject = binding.subjectSpinner.selectedItem.toString()
            val fileName = "mathmate_recent_formulas_${selectedSubject}_${selectedClass}.txt"
            val file = File(requireContext().filesDir, fileName)

            if (!file.exists()) {
                Toast.makeText(
                    requireContext(),
                    "No file found for Class $selectedClass - $selectedSubject",
                    Toast.LENGTH_SHORT
                ).show()
                return@setOnClickListener
            }

            val content = file.readText()

            AlertDialog.Builder(requireContext())
                .setTitle("Exported Formulas")
                .setMessage(content)
                .setPositiveButton("Close", null)
                .show()
        }

        binding.clearFavoritesButton.setOnClickListener {
            val prefs = requireContext().getSharedPreferences("favorites", Context.MODE_PRIVATE)
            prefs.edit().clear().apply()
            Toast.makeText(requireContext(), "All favorites cleared.", Toast.LENGTH_SHORT).show()
        }


//        custom topic -based reminders

        binding.reminderSubjectSpinner.adapter = subjectAdapter

        binding.pickTimeButton.setOnClickListener {
            TimePickerDialog(requireContext(), { _, hour, minute ->
                selectedHour = hour
                selectedMinute = minute
                binding.pickTimeButton.text = "Time: %02d:%02d".format(hour, minute)
            }, selectedHour, selectedMinute, true).show()
        }
        binding.setReminderButton.setOnClickListener {
            val subject = binding.reminderSubjectSpinner.selectedItem.toString()
            scheduleReminder(subject)
        }

    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }


    private fun scheduleReminder(subject: String) {
        val intent = Intent(requireContext(), ReminderReceiver::class.java).apply {
            putExtra("topic", subject)
        }

        val requestCode = subject.hashCode()
        val pendingIntent = PendingIntent.getBroadcast(
            requireContext(),
            requestCode,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val calendar = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, selectedHour)
            set(Calendar.MINUTE, selectedMinute)
            set(Calendar.SECOND, 0)
            if (before(Calendar.getInstance())) add(Calendar.DAY_OF_MONTH, 1)
        }

        val alarmManager = requireContext().getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.setRepeating(
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            AlarmManager.INTERVAL_DAY,
            pendingIntent
        )

        Toast.makeText(
            requireContext(),
            "Reminder set for $subject at $selectedHour:$selectedMinute",
            Toast.LENGTH_SHORT
        ).show()
        saveScheduledTopic(subject, selectedHour, selectedMinute)
    }

    private fun saveScheduledTopic(topic: String, hour: Int, minute: Int) {
        val prefs = requireContext().getSharedPreferences("topic_reminders", Context.MODE_PRIVATE)
        prefs.edit().putString(topic, "$hour:$minute").apply()
        showScheduledReminders()
    }

    private fun removeScheduledTopic(topic: String) {
        val prefs = requireContext().getSharedPreferences("topic_reminders", Context.MODE_PRIVATE)
        prefs.edit().remove(topic).apply()
        cancelReminder(topic)
        showScheduledReminders()
    }

    private fun cancelReminder(subject: String) {
        val intent = Intent(requireContext(), ReminderReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(
            requireContext(),
            subject.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        val alarmManager = requireContext().getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.cancel(pendingIntent)
    }


    private fun showScheduledReminders() {
        binding.reminderListContainer.removeAllViews()

        val prefs = requireContext().getSharedPreferences("topic_reminders", Context.MODE_PRIVATE)
        prefs.all.forEach { entry ->
            val subject = entry.key
            val time = entry.value.toString()

            val textView = TextView(requireContext()).apply {
                text = "🔔 $subject at $time"
                textSize = 14f
                setPadding(16, 12, 16, 12)
            }

            val removeBtn = Button(requireContext()).apply {
                text = "Cancel"
                textSize = 12f
                setOnClickListener { removeScheduledTopic(subject) }
            }

            val row = LinearLayout(requireContext()).apply {
                orientation = LinearLayout.HORIZONTAL
                addView(
                    textView,
                    LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f)
                )
                addView(removeBtn)
            }

            binding.reminderListContainer.addView(row)
        }
    }

}
