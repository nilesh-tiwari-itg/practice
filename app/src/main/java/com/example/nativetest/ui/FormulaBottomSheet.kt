package com.example.nativetest.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.example.nativetest.R
import com.example.nativetest.model.Formula
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

class FormulaBottomSheet(private val formula: Formula) : BottomSheetDialogFragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val view = inflater.inflate(R.layout.bottom_sheet_formula, container, false)

        view.findViewById<TextView>(R.id.bottomSheetTitle).text = formula.title
        view.findViewById<TextView>(R.id.bottomSheetExpression).text = formula.expression

        val descView = view.findViewById<TextView>(R.id.bottomSheetDescription)
        if (!formula.description.isNullOrBlank()) {
            descView.text = formula.description
        } else {
            descView.visibility = View.GONE
        }

        return view
    }
}
