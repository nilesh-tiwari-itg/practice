package com.example.nativetest.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.nativetest.R
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.nativetest.SubjectAdapter
import com.example.nativetest.databinding.FragmentClassWiseFormulasBinding
import com.example.nativetest.viewmodel.FormulaViewModel

class ClassWiseFormulasFragment : Fragment() {

    private var _binding: FragmentClassWiseFormulasBinding? = null
    private val binding get() = _binding!!
    private val viewModel: FormulaViewModel by viewModels()
    private lateinit var adapter: SubjectAdapter
    private var selectedIndex: Int = 0

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentClassWiseFormulasBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupRecyclerView()
        setupTabs()
        observeSubjects()
    }

    private fun setupRecyclerView() {
        adapter = SubjectAdapter { subject ->
            val intent =
                android.content.Intent(requireContext(), SubjectFormulasActivity::class.java)
            intent.putExtra("subject_name", subject.name)
            intent.putExtra("class_number", viewModel.selectedClass.value ?: 0)
            startActivity(intent)
        }
        binding.subjectRecyclerView.layoutManager = LinearLayoutManager(context)
        binding.subjectRecyclerView.adapter = adapter
    }

    private fun setupTabs() {
        val classes = listOf("Class 8", "Class 9", "Class 10", "Class 11", "Class 12")
        binding.classTabLayout.removeAllViews()
        classes.forEachIndexed { index, className ->
            val button =
                layoutInflater.inflate(R.layout.item_class_tab, binding.classTabLayout, false)
            val textView = button.findViewById<android.widget.TextView>(R.id.classTabText)
            textView.text = className
            textView.scaleX = if (index == selectedIndex) 1.1f else 1f
            textView.scaleY = if (index == selectedIndex) 1.1f else 1f
            textView.setBackgroundResource(
                if (index == selectedIndex) R.drawable.selected_tab_background
                else android.R.color.transparent
            )
            textView.setTextColor(
                androidx.core.content.ContextCompat.getColor(
                    requireContext(),
                    if (index == selectedIndex) R.color.white else R.color.textPrimary
                )
            )
            viewModel.selectClass(8)
            textView.setOnClickListener {
                selectedIndex = index
                viewModel.selectClass(index + 8)
                setupTabs()
            }
            binding.classTabLayout.addView(button)
        }
    }

    private fun observeSubjects() {
        viewModel.subjects.observe(viewLifecycleOwner) {
            adapter.submitList(it)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
