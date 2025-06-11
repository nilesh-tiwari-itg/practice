package com.example.nativetest.ui.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AlertDialog
import com.example.nativetest.R
import com.example.nativetest.databinding.FragmentPuzzleBinding
import com.example.nativetest.model.Formula
import com.example.nativetest.util.FormulaLoader

class PuzzleFragment : Fragment() {

    private lateinit var binding: FragmentPuzzleBinding
    private var pairs: List<Pair<String, String>> = emptyList()
    private var correctCount = 0

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View {
        binding = FragmentPuzzleBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        loadPairs()
        showPuzzle()

        binding.checkButton.setOnClickListener {
            val inputs = listOf(
                binding.matchInput1.text.toString().trim(),
                binding.matchInput2.text.toString().trim(),
                binding.matchInput3.text.toString().trim()
            )

            correctCount = inputs.zip(pairs).count { it.first == it.second.first }

            AlertDialog.Builder(requireContext())
                .setTitle("Result")
                .setMessage("You matched $correctCount out of ${pairs.size} correctly.")
                .setPositiveButton("Try Again") { _, _ -> showPuzzle() }
                .setNegativeButton("Close", null)
                .show()
        }
    }

    private fun loadPairs() {
        val formulas = mutableListOf<Formula>()
        for (classNum in 8..12) {
            listOf("Algebra", "Geometry", "Mensuration", "Statistics", "Arithmetic").forEach {
                formulas += FormulaLoader.loadFormulasFromAssets(requireContext(), it, classNum)
            }
        }

        val selected = formulas.shuffled().take(3)
        pairs = selected.map { it.title to it.expression }.shuffled()
    }

    private fun showPuzzle() {
        pairs = pairs.shuffled()

        binding.puzzleTitle1.text = pairs[0].second
        binding.puzzleTitle2.text = pairs[1].second
        binding.puzzleTitle3.text = pairs[2].second

        binding.matchInput1.setText("")
        binding.matchInput2.setText("")
        binding.matchInput3.setText("")
    }
}

