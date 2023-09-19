package wabot.utils.com.wabot_utils

import android.app.Activity.RESULT_OK
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.SmsManager
import android.util.Log
import io.flutter.plugin.common.EventChannel

class DeliveredSMSReceiver : BroadcastReceiver(), EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onReceive(context: Context?, intent: Intent?) {

        // Check intent if equal to INTENT_DELIVERED_SMS_ACTION
        if (intent?.action == INTENT_DELIVERED_SMS_ACTION) {
            try {
                val bundle = intent.extras
                val surveyRespondenId = bundle?.getString("surveyRespondenId")
                val surveyRespondenResponseId = bundle?.getString("surveyRespondenResponseId")

                if (surveyRespondenId == null) {
                    Log.wtf("DELIVERED_SMS_RECEIVER", "surveyRespondenId is null")
                    eventSink?.error("DELIVERED_SMS_RECEIVER", "surveyRespondenId is null", null)
                    return
                }

                var message = ""
                var code = 0
                var status = false
                when (resultCode) {
                    RESULT_OK -> {
                        message = "SMS_DELIVERED_RESULT_OK : SMS delivered successfully"
                        code = RESULT_OK
                        status = true
                        Log.wtf("DELIVERED_SMS_RECEIVER", "RESULT_OK")
                    }
                    SmsManager.RESULT_ERROR_GENERIC_FAILURE -> {
                        message = "SMS_DELIVERED_RESULT_ERROR_GENERIC_FAILURE : Generic failure"
                        code = SmsManager.RESULT_ERROR_GENERIC_FAILURE
                        status = false
                        Log.wtf("DELIVERED_SMS_RECEIVER", "RESULT_ERROR_GENERIC_FAILURE")
                    }
                    SmsManager.RESULT_ERROR_NO_SERVICE -> {
                        message = "SMS_DELIVERED_RESULT_ERROR_NO_SERVICE : No service"
                        code = SmsManager.RESULT_ERROR_NO_SERVICE
                        status = false
                        Log.wtf("DELIVERED_SMS_RECEIVER", "RESULT_ERROR_NO_SERVICE")
                    }
                    SmsManager.RESULT_ERROR_NULL_PDU -> {
                        message = "SMS_DELIVERED_RESULT_ERROR_NULL_PDU : Null PDU"
                        code = SmsManager.RESULT_ERROR_NULL_PDU
                        status = false
                        Log.wtf("DELIVERED_SMS_RECEIVER", "RESULT_ERROR_NULL_PDU")
                    }
                    SmsManager.RESULT_ERROR_RADIO_OFF -> {
                        message = "SMS_DELIVERED_RESULT_ERROR_RADIO_OFF : Radio off"
                        code = SmsManager.RESULT_ERROR_RADIO_OFF
                        status = false
                        Log.wtf("DELIVERED_SMS_RECEIVER", "RESULT_ERROR_RADIO_OFF")
                    }
                    else -> {
                        message =
                            "SMS_DELIVERED_RESULT_ERROR_UNKNOWN : Unknown error with code $resultCode"
                        code = resultCode
                        status = false
                        Log.wtf("DELIVERED_SMS_RECEIVER", "RESULT_ERROR_UNKNOWN")
                    }
                }

                val map = mapOf(
                    "message" to message,
                    "code" to code,
                    "status" to status,
                    "surveyRespondenId" to surveyRespondenId,
                    "surveyRespondenResponseId" to surveyRespondenResponseId
                )

                Log.wtf("DELIVERED_SMS_RECEIVER", "Called with $map")

                eventSink?.success(map)
            } catch (e: Exception) {
                Log.wtf("DELIVERED_SMS_RECEIVER", "Error: ${e.message}")
                eventSink?.error("DELIVERED_SMS_RECEIVER", "Error: ${e.message}", null)
            }
        }


    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}