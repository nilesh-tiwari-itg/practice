package com.example.nativetest.util

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.os.Build
import androidx.core.app.NotificationCompat
import com.example.nativetest.R
import com.example.nativetest.ui.ClassWiseFormulasActivity

class ReminderReceiver : BroadcastReceiver() {
//    override fun onReceive(context: Context, intent: Intent) {
//        val channelId = "math_reminder_channel"
//        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val channel = NotificationChannel(
//                channelId,
//                "Formula Reminder",
//                NotificationManager.IMPORTANCE_DEFAULT
//            )
//            notificationManager.createNotificationChannel(channel)
//        }
//
//        val activityIntent = Intent(context, ClassWiseFormulasActivity::class.java)
//        val pendingIntent = PendingIntent.getActivity(context, 0, activityIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
//
//        val notification = NotificationCompat.Builder(context, channelId)
//            .setContentTitle("Time to practice a formula!")
//            .setContentText("Open Test app and revise your concepts today.")
//            .setSmallIcon(R.drawable.ic_notification)
//            .setContentIntent(pendingIntent)
//            .setAutoCancel(true)
//            .build()
//
//        notificationManager.notify(1, notification)
//    }

    override fun onReceive(context: Context, intent: Intent) {
        val topic = intent.getStringExtra("topic") ?: "your selected math topic"

        val notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val channelId = "mathmate_reminders"

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel =
                NotificationChannel(channelId, "Reminders", NotificationManager.IMPORTANCE_HIGH)
            notificationManager.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle("Time to Revise!")
            .setContentText("Revise $topic today 📘")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .build()

        notificationManager.notify(topic.hashCode(), notification)
    }
}