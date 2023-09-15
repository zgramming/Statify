package wabot.utils.com.wabot_utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.provider.Telephony
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.plugin.common.EventChannel

class CallReceiver : EventChannel.StreamHandler, BroadcastReceiver() {

    private var eventSink: EventChannel.EventSink? = null

//    override fun onReceive(context: Context, intent: Intent) {
//
//        if (intent.action == INTENT_INCOMING_CALL) {
//            val extras = intent.extras
//            if (extras != null) {
//                val state = extras.getString(TelephonyManager.EXTRA_STATE)
//                val incomingNumber = extras.getString(TelephonyManager.EXTRA_INCOMING_NUMBER)
//
//                // Send the call state and incoming number to Flutter
//                val eventData = mapOf("state" to state, "number" to incomingNumber)
//                println("CallReceiver: $eventData")
//                eventSink?.success(eventData)
//            }
//        }
//    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == TelephonyManager.ACTION_PHONE_STATE_CHANGED) {
            val extras = intent.extras
            Log.wtf("CallReceiver",
                "Intent Received from PhoneStateListener ACTION_PHONE_STATE_CHANGED | $extras")
            if (extras != null) {
                val state = extras.getString(TelephonyManager.EXTRA_STATE)
                val incomingNumber = extras.getString(TelephonyManager.EXTRA_INCOMING_NUMBER)

                // Send the call state and incoming number to Flutter
                val eventData = mapOf("state" to state, "number" to incomingNumber)
                println("CallReceiver: $eventData")
                eventSink?.success(eventData)
            }
        }
    }
}