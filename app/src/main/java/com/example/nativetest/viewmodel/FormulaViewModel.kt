package com.example.nativetest.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.nativetest.model.Subject

class FormulaViewModel : ViewModel() {

    private val _subjects = MutableLiveData<List<Subject>>()
    val subjects: LiveData<List<Subject>> get() = _subjects
    val selectedClass = MutableLiveData<Int>()

    fun selectClass(classNumber: Int) {
        selectedClass.value = classNumber
        _subjects.value = getSubjectsForClass(classNumber)
    }

    private fun getSubjectsForClass(classNumber: Int): List<Subject> {
        return listOf(
            Subject("Algebra"),
            Subject("Geometry"),
            Subject("Mensuration"),
            Subject("Statistics"),
            Subject("Arithmetic")
        ) // Placeholder data
    }
}