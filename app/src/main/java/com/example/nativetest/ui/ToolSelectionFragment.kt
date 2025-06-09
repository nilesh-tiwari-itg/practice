package com.example.nativetest.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.nativetest.R

import com.example.nativetest.databinding.FragmentToolSelectionBinding

class ToolSelectionFragment : Fragment() {

    private var _binding: FragmentToolSelectionBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentToolSelectionBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        // TODO: Add your tool UI logic here
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}