package com.example.nativetest.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.nativetest.databinding.ItemFormulaBinding
import com.example.nativetest.model.Formula

class FormulaAdapter : ListAdapter<Formula, FormulaAdapter.FormulaViewHolder>(DiffCallback) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FormulaViewHolder {
        val binding = ItemFormulaBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return FormulaViewHolder(binding)
    }

    override fun onBindViewHolder(holder: FormulaViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    class FormulaViewHolder(private val binding: ItemFormulaBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(formula: Formula) {
            binding.formulaTitle.text = formula.title
            binding.formulaExpression.text = formula.expression
        }
    }

    companion object DiffCallback : DiffUtil.ItemCallback<Formula>() {
        override fun areItemsTheSame(oldItem: Formula, newItem: Formula) = oldItem.title == newItem.title
        override fun areContentsTheSame(oldItem: Formula, newItem: Formula) = oldItem == newItem
    }
}