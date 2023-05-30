package wabot.utils.com.wabot_utils

import android.content.IntentFilter
import android.os.Bundle
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel


class MainActivity : FlutterActivity() {
    val callReceiverChannel = "CALL_RECEIVER_EVENT_CHANNEL";
    private lateinit var callReceiver: CallReceiver

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        registerCallReceiver();

    }

    private fun registerCallReceiver() {
        val eventChannel = flutterEngine?.dartExecutor?.let { executor ->
            EventChannel(executor.binaryMessenger, callReceiverChannel)
        }

        eventChannel?.setStreamHandler(object : EventChannel.StreamHandler {

            override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {

                // Pass the eventSink to the CallReceiver for communication
                callReceiver = CallReceiver()
                callReceiver.setEventSink(eventSink)
                registerReceiver(callReceiver,
                    IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED))
            }

            override fun onCancel(arguments: Any?) {
                callReceiver = CallReceiver()
                callReceiver.cleanUp();
            }
        })

    }


}
