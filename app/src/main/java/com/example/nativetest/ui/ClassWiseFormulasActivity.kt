package com.example.nativetest.ui

import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DefaultItemAnimator
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.nativetest.R
import com.example.nativetest.SubjectAdapter
import com.example.nativetest.databinding.ActivityClassWiseFormulasBinding
import com.example.nativetest.viewmodel.FormulaViewModel

class ClassWiseFormulasActivity : AppCompatActivity() {

    private lateinit var binding: ActivityClassWiseFormulasBinding
    private val viewModel: FormulaViewModel by viewModels()
    private lateinit var adapter: SubjectAdapter
    private var selectedIndex: Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setTheme(R.style.AppTheme) // Automatically handles light/dark
        binding = ActivityClassWiseFormulasBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupRecyclerView()
        setupTabs()
        observeSubjects()
    }

    private fun setupRecyclerView() {
        adapter = SubjectAdapter { subject ->
            val intent = Intent(this, SubjectFormulasActivity::class.java)
            intent.putExtra("subject_name", subject.name)
            intent.putExtra("class_number", viewModel.selectedClass.value ?: 0)
            startActivity(intent)
        }
        binding.subjectRecyclerView.layoutManager = LinearLayoutManager(this)
        binding.subjectRecyclerView.adapter = adapter
        (binding.subjectRecyclerView.itemAnimator as? DefaultItemAnimator)?.apply {
            addDuration = 150
            removeDuration = 150
            moveDuration = 150
            changeDuration = 150
        }
    }

    private fun setupTabs() {
        val classes = listOf("Class 8", "Class 9", "Class 10", "Class 11", "Class 12")
        binding.classTabLayout.removeAllViews()
        classes.forEachIndexed { index, className ->
            val button = layoutInflater.inflate(R.layout.item_class_tab, binding.classTabLayout, false)
            val textView = button.findViewById<TextView>(R.id.classTabText)
            textView.text = className
            textView.scaleX = if (index == selectedIndex) 1.1f else 1f
            textView.scaleY = if (index == selectedIndex) 1.1f else 1f
            textView.setBackgroundResource(
                if (index == selectedIndex) R.drawable.selected_tab_background
                else android.R.color.transparent
            )
            textView.setTextColor(
                ContextCompat.getColor(
                    this,
                    if (index == selectedIndex) R.color.white else R.color.textPrimary
                )
            )
            viewModel.selectClass(8)
            textView.setOnClickListener {
                selectedIndex = index
                viewModel.selectClass(index + 8)
                setupTabs() // Refresh to update styles
            }
            binding.classTabLayout.addView(button)
        }
    }

    private fun observeSubjects() {
        viewModel.subjects.observe(this, Observer {
            adapter.submitList(it)
        })
    }
}
