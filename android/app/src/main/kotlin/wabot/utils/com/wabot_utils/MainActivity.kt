package wabot.utils.com.wabot_utils

import android.content.IntentFilter
import android.provider.Telephony
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val methodChannelUtils = MethodChannelUtils(this)
    private val incomingMessageRCV = IncomingMessageReceiver()
    private val incomingCallRCV = CallReceiver()
    private val sentSMSRCV = SentSMSReceiver()
    private val deliveredSMSRCV = DeliveredSMSReceiver()


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Setup method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            MC).setMethodCallHandler { call, result ->
            if (call.method == "sendSMS") {
                val phoneNumber = call.argument<String>("phoneNumber")
                val message = call.argument<String>("message")
                val sim = call.argument<Int>("simSlot")
                val surveyRespondenId = call.argument<String>("surveyRespondenId")
                val surveyRespondenResponseId = call.argument<String>("surveyRespondenResponseId")
                if (phoneNumber != null && message != null && sim != null && surveyRespondenId != null && surveyRespondenResponseId != null) {
                    try {
                        Log.wtf("sendSMS", "sendSMS")
                        val exec = methodChannelUtils.sendSMS(
                            phoneNumber,
                            message,
                            sim,
                            surveyRespondenId,
                            surveyRespondenResponseId
                        )

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

        // Setup event channels
        registerIncomingMessageEventChannel()
        registerIncomingCallEventChannel()
        registerSentSMSEventChannel()
        registerDeliveredSMSEventChannel()
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.wtf("MainActivity", "onDestroy")
        unregisterReceiver(incomingMessageRCV)
        unregisterReceiver(incomingCallRCV)
        unregisterReceiver(sentSMSRCV)
        unregisterReceiver(deliveredSMSRCV)
    }

    private fun registerIncomingMessageEventChannel() {
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, ECIncomingSMS)
        }
        eventChannel?.setStreamHandler(incomingMessageRCV)
        registerReceiver(incomingMessageRCV,
            IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION))

    }

    private fun registerIncomingCallEventChannel() {
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, ECIncomingCall)
        }
        eventChannel?.setStreamHandler(incomingCallRCV)
        registerReceiver(incomingCallRCV, IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED))
    }

    private fun registerSentSMSEventChannel() {
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, ECSentSMS)
        }
        eventChannel?.setStreamHandler(sentSMSRCV)
        // Register the broadcast receiver.
        registerReceiver(sentSMSRCV, IntentFilter(INTENT_SENT_SMS_ACTION))
    }

    private fun registerDeliveredSMSEventChannel() {
        val receiver = DeliveredSMSReceiver()
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, ECDeliveredSMS)
        }
        eventChannel?.setStreamHandler(receiver)
        // Register the broadcast receiver.
        registerReceiver(deliveredSMSRCV, IntentFilter(INTENT_DELIVERED_SMS_ACTION))
    }


}
