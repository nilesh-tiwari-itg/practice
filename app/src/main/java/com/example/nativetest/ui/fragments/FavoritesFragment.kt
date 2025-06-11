package com.example.nativetest.ui.fragments

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.nativetest.R
import com.example.nativetest.adapter.FormulaAdapter
import com.example.nativetest.databinding.FragmentFavoritesBinding
import com.example.nativetest.model.Formula
import com.example.nativetest.util.FormulaLoader

class FavoritesFragment : Fragment() {

    private lateinit var binding: FragmentFavoritesBinding
    private lateinit var adapter: FormulaAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View {
        binding = FragmentFavoritesBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        adapter = FormulaAdapter() // You can reuse same one

        binding.favoritesRecyclerView.layoutManager = LinearLayoutManager(requireContext())
        binding.favoritesRecyclerView.adapter = adapter

        loadFavorites()
    }

    private fun loadFavorites() {
        val prefs = requireContext().getSharedPreferences("favorites", Context.MODE_PRIVATE)
        val allKeys = prefs.all.keys
        val allFavTitles =
            allKeys.flatMap { prefs.getStringSet(it, emptySet()) ?: emptySet() }.toSet()

        val formulas = mutableListOf<Formula>()

        val classRange = 8..12
        val subjects = listOf("Algebra", "Geometry", "Mensuration", "Statistics", "Arithmetic")

        for (classNum in classRange) {
            for (subject in subjects) {
                val loaded =
                    FormulaLoader.loadFormulasFromAssets(requireContext(), subject, classNum)
                formulas += loaded.filter { allFavTitles.contains(it.title) }
            }
        }

        if (formulas.isEmpty()) {
            binding.emptyStateText.visibility = View.VISIBLE
        } else {
            adapter.submitList(formulas)
        }
    }
}
