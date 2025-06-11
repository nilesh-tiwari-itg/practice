package com.example.nativetest.ui.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.nativetest.R
import com.example.nativetest.databinding.FragmentGameModeBinding

class GameModeFragment : Fragment() {

    private lateinit var binding: FragmentGameModeBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View {
        binding = FragmentGameModeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.quizButton.setOnClickListener {
            parentFragmentManager.beginTransaction()
                .setCustomAnimations(R.anim.slide_in_right, R.anim.slide_out_left)
                .replace(R.id.contentFrame, QuizFragment())
                .addToBackStack(null)
                .commit()
        }

        binding.puzzleButton.setOnClickListener {
            parentFragmentManager.beginTransaction()
                .setCustomAnimations(R.anim.slide_in_right, R.anim.slide_out_left)
                .replace(R.id.contentFrame, PuzzleFragment())
                .addToBackStack(null)
                .commit()
        }
    }
}

