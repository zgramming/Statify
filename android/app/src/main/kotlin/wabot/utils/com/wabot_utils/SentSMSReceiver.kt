package wabot.utils.com.wabot_utils

import android.app.Activity.RESULT_OK
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.SmsManager
import android.util.Log
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler

class SentSMSReceiver : BroadcastReceiver(), StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == INTENT_SENT_SMS_ACTION) {
            val bundle = intent.extras
            val surveyResponseId = bundle?.getString("surveyResponseId") ?: ""
            var message = ""
            var code = 0
            var status = false
            when (resultCode) {
                RESULT_OK -> {
                    message = "SMS_RESULT_OK : SMS sent successfully"
                    code = RESULT_OK
                    status = true
                }
                SmsManager.RESULT_ERROR_GENERIC_FAILURE -> {
                    message = "SMS_RESULT_ERROR_GENERIC_FAILURE : Generic failure"
                    code = SmsManager.RESULT_ERROR_GENERIC_FAILURE
                    status = false
                }
                SmsManager.RESULT_ERROR_NO_SERVICE -> {
                    message = "SMS_RESULT_ERROR_NO_SERVICE : No service"
                    code = SmsManager.RESULT_ERROR_NO_SERVICE
                    status = false
                }
                SmsManager.RESULT_ERROR_NULL_PDU -> {
                    message = "SMS_RESULT_ERROR_NULL_PDU : Null PDU"
                    code = SmsManager.RESULT_ERROR_NULL_PDU
                    status = false
                }
                SmsManager.RESULT_ERROR_RADIO_OFF -> {
                    message = "SMS_RESULT_ERROR_RADIO_OFF : Radio off"
                    code = SmsManager.RESULT_ERROR_RADIO_OFF
                    status = false
                }
                else -> {
                    message = "SMS_RESULT_ERROR_UNKNOWN : Unknown error"
                    code = 0
                    status = false
                }
            }

            val map = mapOf(
                "message" to message,
                "code" to code,
                "status" to status,
                "surveyResponseId" to surveyResponseId
            )
            Log.wtf("SENT_SMS_RECEIVER", "Map : $map")
            eventSink?.success(map)
        }

    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}