package com.example.nativetest.ui.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.AnimationUtils
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import com.example.nativetest.R
import com.example.nativetest.databinding.FragmentQuizBinding
import com.example.nativetest.model.Formula
import com.example.nativetest.util.FormulaLoader

class QuizFragment : Fragment() {

    private lateinit var binding: FragmentQuizBinding
    private val questions = mutableListOf<Question>()
    private var currentIndex = 0
    private var score = 0
    private var answered = false

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View {
        binding = FragmentQuizBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        loadQuestions()
        showCurrentQuestion()

        binding.nextButton.setOnClickListener {
            if (!answered) {
                Toast.makeText(requireContext(), "Select an answer first.", Toast.LENGTH_SHORT)
                    .show()
                return@setOnClickListener
            }

            currentIndex++
            answered = false
            if (currentIndex < questions.size) {
                showCurrentQuestion()
            } else {
                showFinalScore()
            }
        }
    }

    private fun loadQuestions() {
        val allFormulas = mutableListOf<Formula>()
        val subjects = listOf("Algebra", "Geometry", "Mensuration", "Statistics", "Arithmetic")

        for (classNum in 8..12) {
            for (subject in subjects) {
                allFormulas += FormulaLoader.loadFormulasFromAssets(
                    requireContext(),
                    subject,
                    classNum
                )
            }
        }

        allFormulas.shuffle()

        questions.clear()
        val selected = allFormulas.take(5)

        selected.forEach { correct ->
            val options = allFormulas.shuffled().map { it.expression }
                .filter { it != correct.expression }
                .take(3)
                .toMutableList()
                .apply { add((0..3).random(), correct.expression) }

            questions.add(
                Question(
                    title = correct.title,
                    correctAnswer = correct.expression,
                    options = options
                )
            )
        }
    }

    private fun showCurrentQuestion() {
        val question = questions[currentIndex]
        binding.quizQuestion.text =
            "Q${currentIndex + 1}: What is the formula for ${question.title}?"

        val buttons = listOf(
            binding.optionA, binding.optionB, binding.optionC, binding.optionD
        )

        question.options.forEachIndexed { index, option ->
//            buttons[index].apply {
//                text = option
//                isEnabled = true
//                setBackgroundResource(R.drawable.default_option_background)
//                setOnClickListener {
//                    answered = true
//                    buttons.forEach { it.isEnabled = false }
//
//                    if (option == question.correctAnswer) {
//                        score++
//                        setBackgroundResource(R.drawable.correct_option_background)
//                    } else {
//                        setBackgroundResource(R.drawable.incorrect_option_background)
//                        buttons.find { it.text == question.correctAnswer }
//                            ?.setBackgroundResource(R.drawable.correct_option_background)
//                    }
//                }
//            }
            buttons[index].apply {
                alpha = 0f
                animate().alpha(1f).setDuration(250).start()

                setOnClickListener {
                    answered = true
                    buttons.forEach { it.isEnabled = false }

                    if (option == question.correctAnswer) {
                        score++
                        setBackgroundResource(R.drawable.correct_option_background)
                    } else {
                        setBackgroundResource(R.drawable.incorrect_option_background)
                        startAnimation(AnimationUtils.loadAnimation(context, R.anim.shake))
                        buttons.find { it.text == question.correctAnswer }
                            ?.setBackgroundResource(R.drawable.correct_option_background)
                    }
                }
            }

        }
    }

    private fun showFinalScore() {
        AlertDialog.Builder(requireContext())
            .setTitle("Quiz Complete!")
            .setMessage("You scored $score out of ${questions.size}.")
            .setPositiveButton("Restart") { _, _ ->
                currentIndex = 0
                score = 0
                loadQuestions()
                showCurrentQuestion()
            }
            .setNegativeButton("Close", null)
            .show()
    }

    data class Question(val title: String, val correctAnswer: String, val options: List<String>)
}
