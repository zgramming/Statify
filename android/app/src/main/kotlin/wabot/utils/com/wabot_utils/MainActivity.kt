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
    val EC = "STATIFY_EVENT_CHANNEL"
    val MC = "STATIFY_METHOD_CHANNEL"
    private val methodChannelUtils = MethodChannelUtils(this)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            MC
        ).setMethodCallHandler { call, result ->


            if (call.method == "sendSMS") {
                val phoneNumber = call.argument<String>("phoneNumber")
                val message = call.argument<String>("message")
                val sim = call.argument<Int>("simSlot")
                if (phoneNumber != null && message != null && sim != null) {
                    result.success(methodChannelUtils.sendSMS(phoneNumber, message, sim))
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
    }

    private fun registerIncomingMessage() {
        val incomingMessageReceiver = ListenIncomingMessage()
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, EC)
        }
        registerReceiver(
            incomingMessageReceiver,
            IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION),
        )
        eventChannel?.setStreamHandler(incomingMessageReceiver)
    }

//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        registerCallReceiver();
//    }

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
