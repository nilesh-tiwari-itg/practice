package com.example.nativetest

import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.nativetest.databinding.ItemSubjectBinding
import com.example.nativetest.model.Subject
import android.view.LayoutInflater
import androidx.recyclerview.widget.DiffUtil


class SubjectAdapter(private val onClick: (Subject) -> Unit) :
    ListAdapter<Subject, SubjectAdapter.SubjectViewHolder>(DiffCallback) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SubjectViewHolder {
        val binding = ItemSubjectBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return SubjectViewHolder(binding, onClick)
    }

    override fun onBindViewHolder(holder: SubjectViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    class SubjectViewHolder(
        private val binding: ItemSubjectBinding,
        private val onClick: (Subject) -> Unit
    ) : RecyclerView.ViewHolder(binding.root) {
        fun bind(subject: Subject) {
            binding.subjectName.text = subject.name
            binding.root.setOnClickListener { onClick(subject) }
        }
    }

    companion object DiffCallback : DiffUtil.ItemCallback<Subject>() {
        override fun areItemsTheSame(oldItem: Subject, newItem: Subject) = oldItem.name == newItem.name
        override fun areContentsTheSame(oldItem: Subject, newItem: Subject) = oldItem == newItem
    }
}

