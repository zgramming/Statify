package wabot.utils.com.wabot_utils

import android.Manifest
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.telephony.SmsManager.getSmsManagerForSubscriptionId
import android.telephony.SubscriptionManager
import androidx.core.app.ActivityCompat


class MethodChannelUtils(private val context: Context) {
    fun sendSMS(
        phoneNumber: String,
        message: String,
        sim: Int,
        surveyResponseId: String,
    ): Boolean {
        val subscriptionManager = context.getSystemService(SubscriptionManager::class.java)
        if (ActivityCompat.checkSelfPermission(context,
                Manifest.permission.SEND_SMS) != PackageManager.PERMISSION_GRANTED
        ) {

            throw Exception("Permission not granted")
        }
        val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfoForSimSlotIndex(sim)
        if (subscriptionInfo != null) {
            val subscriptionId = subscriptionInfo.subscriptionId
            val smsManager = getSmsManagerForSubscriptionId(subscriptionId)
            // Create a PendingIntent for sent status

            val iSentIntent = Intent(INTENT_SENT_SMS_ACTION)
            iSentIntent.putExtra("surveyResponseId", surveyResponseId)
            val sentPendingIntent = PendingIntent.getBroadcast(context,
                0,
                iSentIntent,
                PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE)

            // Create a PendingIntent for delivery status
            val iDeliveryIntent = Intent(INTENT_DELIVERED_SMS_ACTION)
            val deliveryPendingIntent = PendingIntent.getBroadcast(context,
                0,
                iDeliveryIntent,
                PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE)

            smsManager.sendTextMessage(
                phoneNumber,
                null,
                message,
                sentPendingIntent,
                deliveryPendingIntent,
            )

//            // Register for SMS send action
            context.registerReceiver(object : BroadcastReceiver() {
                override fun onReceive(context: Context?, intent: Intent?) {
                    if (intent?.action == INTENT_SENT_SMS_ACTION) {
                        val bundle = intent.extras
                        val surveyResponseIdX = bundle?.getString("surveyResponseId") ?: ""

                        intent.putExtra("surveyResponseId", surveyResponseIdX)

                    }
                }
            }, IntentFilter(INTENT_SENT_SMS_ACTION))

            // Register for delivery action
            context.registerReceiver(object : BroadcastReceiver() {
                override fun onReceive(context: Context?, intent: Intent?) {
                    if (intent?.action == INTENT_DELIVERED_SMS_ACTION) {
                        val bundle = intent.extras
                        val surveyResponseIdX = bundle?.getString("surveyResponseId") ?: ""

                        intent.putExtra("surveyResponseId", surveyResponseIdX)
                    }
                }
            }, IntentFilter("DELIVERED_SMS_ACTION"))

            return true
        } else {
            throw Exception("Sim not found")
        }
    }
}
