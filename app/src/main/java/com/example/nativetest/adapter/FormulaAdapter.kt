package com.example.nativetest.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.nativetest.R
import com.example.nativetest.databinding.ItemFormulaBinding
import com.example.nativetest.model.Formula
import com.example.nativetest.ui.FormulaBottomSheet
import com.google.android.material.chip.Chip

class FormulaAdapter(
    private val contextKey: String = "global" // e.g. fav_Algebra_9
) : ListAdapter<Formula, FormulaAdapter.FormulaViewHolder>(DiffCallback) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FormulaViewHolder {
        val binding = ItemFormulaBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return FormulaViewHolder(binding)
    }

    override fun onBindViewHolder(holder: FormulaViewHolder, position: Int) {
        holder.bind(getItem(position), contextKey)
    }

    class FormulaViewHolder(private val binding: ItemFormulaBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(formula: Formula, key: String) {
            binding.formulaTitle.text = formula.title
            binding.formulaExpression.text = formula.expression

            val prefs = itemView.context.getSharedPreferences("favorites", Context.MODE_PRIVATE)
            val currentSet = prefs.getStringSet(key, mutableSetOf()) ?: mutableSetOf()
            val isFav = currentSet.contains(formula.title)
            itemView.setOnClickListener {
                FormulaBottomSheet(formula).show((itemView.context as AppCompatActivity).supportFragmentManager, "FormulaSheet")
            }
            binding.favoriteIcon.setImageResource(
                if (isFav) R.drawable.ic_favorite else R.drawable.ic_favorite_border
            )


            binding.tagChipGroup.removeAllViews()
            formula.tags?.forEach { tag ->
                val chip = Chip(binding.root.context).apply {
                    text = tag
                    isClickable = false
                    isCheckable = false
                    setChipBackgroundColorResource(R.color.chip_background)
                }
                binding.tagChipGroup.addView(chip)
            }




            binding.favoriteIcon.setOnClickListener {
                val updated =
                    prefs.getStringSet(key, mutableSetOf())?.toMutableSet() ?: mutableSetOf()
                if (updated.contains(formula.title)) {
                    updated.remove(formula.title)
                    binding.favoriteIcon.setImageResource(R.drawable.ic_favorite_border)
                } else {
                    updated.add(formula.title)
                    binding.favoriteIcon.setImageResource(R.drawable.ic_favorite)
                }
                prefs.edit().putStringSet(key, updated).apply()
            }
        }
    }

    companion object DiffCallback : DiffUtil.ItemCallback<Formula>() {
        override fun areItemsTheSame(oldItem: Formula, newItem: Formula) =
            oldItem.title == newItem.title

        override fun areContentsTheSame(oldItem: Formula, newItem: Formula) = oldItem == newItem
    }
}
