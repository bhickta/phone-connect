# Phone Setup

## Enable Developer Options

1. Open Android Settings.
2. Go to About phone.
3. Tap Build number seven times.
4. Enter the device PIN if prompted.

## Enable USB Debugging

1. Open Settings.
2. Go to System -> Developer options.
3. Enable USB debugging.
4. Connect the phone to this PC with a data-capable USB cable.
5. Accept the debugging authorization prompt on the phone.

## Verify

```bash
phone-control doctor
phone-control devices
phone-control mirror
```
