package wabot.utils.com.wabot_utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.provider.Telephony
import android.telephony.SmsMessage
import android.telephony.TelephonyManager
import android.util.Log
import android.widget.Toast
import io.flutter.plugin.common.EventChannel
import java.util.*

class IncomingMessageReceiver : BroadcastReceiver(), EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private fun detectSim(bundle: Bundle): Int {
        var slot = -1
        val keySet: Set<String> = bundle.keySet()
        for (key in keySet) {
            when (key) {
                "phone" -> slot = bundle.getInt("phone", -1)
                "slot" -> slot = bundle.getInt("slot", -1)
                "simId" -> slot = bundle.getInt("simId", -1)
                "simSlot" -> slot = bundle.getInt("simSlot", -1)
                "slot_id" -> slot = bundle.getInt("slot_id", -1)
                "simnum" -> slot = bundle.getInt("simnum", -1)
                "slotId" -> slot = bundle.getInt("slotId", -1)
                "slotIdx" -> slot = bundle.getInt("slotIdx", -1)
                "android.telephony.extra.SLOT_INDEX" ->                 // Present on Pixel 4a with physical sim + eSIM configuration
                    slot = bundle.getInt("android.telephony.extra.SLOT_INDEX", -1)
                else -> try {
                    if (key.lowercase(Locale.getDefault())
                            .contains("slot") || key.lowercase(Locale.getDefault()).contains("sim")
                    ) {
                        val value: Int = bundle.getInt(key, -1)
                        if (value == 0 || value == 1) {
                            slot = value
                        }
                    }
                } catch (e: Error) {
                    throw Exception("Error while detecting sim slot")
                }
            }
        }
        return slot
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == Telephony.Sms.Intents.SMS_RECEIVED_ACTION) {
            val bundle = intent.extras
            val messages = Telephony.Sms.Intents.getMessagesFromIntent(intent)

            if (messages == null || messages.isEmpty()) {
                eventSink?.success(null)
                return
            };

            val message = messages[0]

            val body = message.messageBody
            val address = message.displayOriginatingAddress
            val date = message.timestampMillis
            val simSlot = detectSim(bundle!!)
            val map = mapOf(
                "body" to body,
                "address" to address,
                "date" to date,
                "simSlot" to simSlot,
            )
            Log.wtf("IncomingMessageReceiver", "onReceive: $map");

            // Show toast
            // Toast.makeText(context, "Incoming SMS detected", Toast.LENGTH_LONG).show();

            eventSink?.success(map);
        } else {
            // Send the message, sender, date, simSlot to Flutter
            eventSink?.success(null)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}