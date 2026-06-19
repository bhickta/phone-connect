# Android Phone Control

Control an Android phone from this PC with a small wrapper around `adb` and `scrcpy`.

## What It Does

- Mirror and control the phone screen from the PC.
- Mirror and control while the phone's physical screen is off.
- Pair/connect over wireless debugging.
- Take screenshots and screen recordings.
- Push/pull files.
- Install APKs.
- Send common Android key events.
- Open apps by package name.

## Requirements

On Ubuntu:

```bash
sudo apt update
sudo apt install android-tools-adb scrcpy
```

On the phone:

1. Enable Developer options.
2. Enable USB debugging.
3. Connect the phone by USB.
4. Accept the RSA debugging prompt on the phone.

## Install This Repo's CLI

```bash
./install.sh
phone-control doctor
```

Or run it directly:

```bash
./bin/phone-control doctor
```

The installer also creates two desktop launchers:

- `Phone Control`
- `Phone Control Screen Off`

They start `scrcpy` in the background, so no terminal needs to stay open.

## Install On Another PC

Copy or clone this repository on the other Linux PC, then run:

```bash
sudo apt update
sudo apt install android-tools-adb scrcpy
cd android-phone-control
./install.sh
phone-control doctor
```

After pairing or connecting the phone:

```bash
phone-control start-off
phone-control sessions
```

## Common Commands

```bash
phone-control devices
phone-control mirror
phone-control mirror-off
phone-control start
phone-control start-off
phone-control sessions
phone-control stop SESSION_ID_OR_PID
phone-control stop-all
phone-control mirror --stay-awake --turn-screen-off
phone-control screenshot ~/Pictures/phone.png
phone-control record ~/Videos/phone.mp4
phone-control key home
phone-control key back
phone-control apps
phone-control open com.android.settings
```

## Wireless Debugging

Android 11+ can connect without USB after pairing.

On the phone, open:

`Developer options` -> `Wireless debugging` -> `Pair device with pairing code`

Then run:

```bash
phone-control wireless-pair PHONE_IP:PAIR_PORT PAIR_CODE
phone-control wireless-connect PHONE_IP:ADB_PORT
phone-control mirror
```

The pair port and ADB port are different. Android shows both in the Wireless debugging screen.

## Control With Phone Screen Off

After the phone is connected through USB or wireless ADB:

```bash
phone-control mirror-off
```

This starts `scrcpy` with `--turn-screen-off --stay-awake`, so the phone display turns off while the mirrored window on the PC stays usable.

To disable audio too:

```bash
phone-control mirror-off --no-audio
```

## Background Sessions

Use `start` when you want the terminal to return immediately:

```bash
phone-control start
phone-control start-off
```

Manage active sessions:

```bash
phone-control sessions
phone-control stop SESSION_ID_OR_PID
phone-control stop-all
phone-control logs SESSION_ID_OR_PID
```

Session metadata and logs are stored under `~/.local/state/phone-control`.

## File Transfer

```bash
phone-control push ./local-file.txt /sdcard/Download/
phone-control pull /sdcard/Download/remote-file.txt .
```

## Shell Access

```bash
phone-control shell -- settings get system screen_brightness
phone-control shell -- input text hello
```

## Troubleshooting

If `phone-control doctor` shows no device:

- Reconnect the USB cable.
- Check that USB mode allows data, not charge-only.
- Disable and re-enable USB debugging.
- Revoke USB debugging authorizations, reconnect, and accept the prompt again.
- Run `adb kill-server` then `adb start-server`.

If wireless connection fails:

- Keep PC and phone on the same Wi-Fi network.
- Recheck the ADB port shown under Wireless debugging.
- Pair again if the phone changed networks.

## Security Notes

ADB gives this PC powerful access to the phone while debugging is enabled. Turn off USB debugging or wireless debugging when you are done, especially on shared networks.
