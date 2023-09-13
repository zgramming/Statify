package wabot.utils.com.wabot_utils

import android.content.IntentFilter
import android.os.Bundle
import android.provider.Telephony
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val methodChannelUtils = MethodChannelUtils(this)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            MC).setMethodCallHandler { call, result ->
            if (call.method == "sendSMS") {
                val phoneNumber = call.argument<String>("phoneNumber")
                val message = call.argument<String>("message")
                val sim = call.argument<Int>("simSlot")
                val surveyResponseId = call.argument<String>("surveyResponseId")

                if (phoneNumber != null && message != null && sim != null && surveyResponseId != null) {
                    try {
                        val exec =
                            methodChannelUtils.sendSMS(phoneNumber, message, sim, surveyResponseId)

                        if (!exec) {
                            result.error("ERROR", "Permission not granted", null)
                        }

                        result.success(exec)
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }


                } else {
                    result.error("ERROR", "Arguments are null", null)
                }
            } else {
                result.notImplemented()
            }
        }

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        registerIncomingMessage()
        registerSentSMSReceiver()
//        registerDeliveredSMSReceiver()

    }

    private fun registerSentSMSReceiver() {
        val sentSMSReceiver = SentSMSReceiver()
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, ECSentSMS)
        }
        registerReceiver(
            sentSMSReceiver,
            IntentFilter(INTENT_SENT_SMS_ACTION),
        )
        eventChannel?.setStreamHandler(sentSMSReceiver)
    }

    private fun registerDeliveredSMSReceiver() {
        val deliveredSMSReceiver = DeliveredSMSReceiver()
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, ECDeliveredSMS)
        }
        registerReceiver(
            deliveredSMSReceiver,
            IntentFilter(INTENT_DELIVERED_SMS_ACTION),
        )
        eventChannel?.setStreamHandler(deliveredSMSReceiver)
    }

    private fun registerIncomingMessage() {
        val incomingMessageReceiver = IncomingMessageReceiver()
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, ECIncomingSMS)
        }
        registerReceiver(
            incomingMessageReceiver,
            IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION),
        )
        eventChannel?.setStreamHandler(incomingMessageReceiver)
    }

//    private fun registerCallReceiver() {
//        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
//            EventChannel(executor.binaryMessenger, EC)
//        }
//        callReceiver = CallReceiver()
//        registerReceiver(callReceiver,
//            IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED))
//        eventChannel?.setStreamHandler(callReceiver)
//    }


}
