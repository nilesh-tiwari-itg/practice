package com.example.nativetest.util


import android.content.Context
import com.example.nativetest.model.Formula
import org.json.JSONArray
import java.nio.charset.Charset

object FormulaLoader {
    fun loadFormulasFromAssets(context: Context, subject: String, classNumber: Int): List<Formula> {
//        val fileName = subject.lowercase().replace(" ", "_") + ".json"
        val fileName = "class_${classNumber}/${subject.lowercase().replace(" ", "_")}.json"
        return try {
            val inputStream = context.assets.open(fileName)
            val size = inputStream.available()
            val buffer = ByteArray(size)
            inputStream.read(buffer)
            inputStream.close()
            val json = String(buffer, Charset.forName("UTF-8"))
            val jsonArray = JSONArray(json)
            List(jsonArray.length()) {
                val obj = jsonArray.getJSONObject(it)
                Formula(obj.getString("title"), obj.getString("expression"))
            }
        } catch (e: Exception) {
            emptyList()
        }
    }
}
