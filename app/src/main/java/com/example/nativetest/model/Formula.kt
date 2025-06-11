package com.example.nativetest.model

data class Formula(
    val title: String,
    val expression: String,
    val description: String? = null,
    val tags: List<String>? = null
)
