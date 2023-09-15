package wabot.utils.com.wabot_utils

import android.Manifest
import android.app.PendingIntent
import android.content.*
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.telephony.SmsManager
import android.telephony.SmsManager.getSmsManagerForSubscriptionId
import android.telephony.SubscriptionManager
import android.util.Log
import androidx.core.app.ActivityCompat
import java.io.File


class MethodChannelUtils(private val context: Context) {
    fun sendSMS(
        phoneNumber: String,
        message: String,
        sim: Int,
        surveyResponseId: String,
    ): Boolean {

        try {
            val subscriptionManager = context.getSystemService(SubscriptionManager::class.java)
            if (ActivityCompat.checkSelfPermission(context,
                    Manifest.permission.SEND_SMS) != PackageManager.PERMISSION_GRANTED
            ) {

                throw Exception("Permission not granted")
            }
            val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfoForSimSlotIndex(sim)
                ?: throw Exception("Sim not found")

            val subscriptionId = subscriptionInfo.subscriptionId
            val smsManager = getSmsManagerForSubscriptionId(subscriptionId)

            Log.wtf("METHOD_CHANNEL_UTILS", "Message content: $message")
            Log.wtf("METHOD_CHANNEL_UTILS", "Message length: ${message.length}")

            val iSentIntent = Intent(INTENT_SENT_SMS_ACTION)
            val iDeliveryIntent = Intent(INTENT_DELIVERED_SMS_ACTION)
            iSentIntent.putExtra("surveyResponseId", surveyResponseId)
            iDeliveryIntent.putExtra("surveyResponseId", surveyResponseId)

            val sentPendingIntent = PendingIntent.getBroadcast(
                context,
                0,
                iSentIntent,
                PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE,
            )

            // Create a PendingIntent for delivery status
            val deliveryPendingIntent = PendingIntent.getBroadcast(
                context,
                0,
                iDeliveryIntent,
                PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE,
            )

            val length = message.length
            if (length > 160) {
                val messageParts = smsManager.divideMessage(message)
                val sentIntentsArrayList = ArrayList<PendingIntent>()
                val deliveryIntentsArrayList = ArrayList<PendingIntent>()

                for (i in messageParts.indices) {
                    sentIntentsArrayList.add(sentPendingIntent)
                    deliveryIntentsArrayList.add(deliveryPendingIntent)
                }

                smsManager.sendMultipartTextMessage(
                    phoneNumber,
                    null,
                    messageParts,
                    sentIntentsArrayList,
                    deliveryIntentsArrayList,
                )


            } else {
                smsManager.sendTextMessage(
                    phoneNumber,
                    null,
                    message,
                    sentPendingIntent,
                    deliveryPendingIntent,
                )
            }
            // Register for SMS send action
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
            }, IntentFilter(INTENT_DELIVERED_SMS_ACTION))

            return true

        } catch (e: Exception) {
            Log.wtf("METHOD_CHANNEL_UTILS", "Error: ${e.message}")
            return false
        }
    }
}
