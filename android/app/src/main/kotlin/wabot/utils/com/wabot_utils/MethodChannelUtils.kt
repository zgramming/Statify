package wabot.utils.com.wabot_utils

import android.Manifest
import android.app.Activity
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.telephony.SmsManager
import android.telephony.SubscriptionManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat.getSystemService
import io.flutter.embedding.android.FlutterFragmentActivity


class MethodChannelUtils(private val context: Context) {
    fun sendSMS(
        phoneNumber: String,
        message: String,
        sim: Int,
    ): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
            val subscriptionManager = context.getSystemService(SubscriptionManager::class.java)
            if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.SEND_SMS
                ) != PackageManager.PERMISSION_GRANTED
            ) {

                throw Exception("Permission not granted")
            }
            val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfoForSimSlotIndex(sim)
            if (subscriptionInfo != null) {
                val subscriptionId = subscriptionInfo.subscriptionId
                val smsManager =
                    android.telephony.SmsManager.getSmsManagerForSubscriptionId(subscriptionId)
                // Create a PendingIntent for sent status
                val sentPendingIntent = PendingIntent.getBroadcast(
                    context,
                    0,
                    Intent("SENT_SMS_ACTION"), PendingIntent.FLAG_MUTABLE
                )

                // Create a PendingIntent for delivery status
                val deliveryPendingIntent = PendingIntent.getBroadcast(
                    context,
                    0,
                    Intent("DELIVERED_SMS_ACTION"), PendingIntent.FLAG_MUTABLE
                )

                smsManager.sendTextMessage(
                    phoneNumber,
                    null,
                    message,
                    sentPendingIntent,
                    deliveryPendingIntent,
                )
                return true;
            } else {
                throw Exception("Sim not found")
            }
        } else {
            val smsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(phoneNumber, null, message, null, null)
            return true;
        }
    }
}