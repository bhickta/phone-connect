#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${HOME}/.local/bin"
target="${target_dir}/phone-control"
apps_dir="${HOME}/.local/share/applications"

mkdir -p "$target_dir"
ln -sf "${repo_dir}/bin/phone-control" "$target"
chmod +x "${repo_dir}/bin/phone-control"

mkdir -p "$apps_dir"
cat > "${apps_dir}/phone-control-screen-off.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Phone Control Screen Off
Comment=Start Android phone control with the phone screen off
Exec=${target} start-off
Terminal=false
Categories=Utility;
EOF

cat > "${apps_dir}/phone-control.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Phone Control
Comment=Start Android phone control
Exec=${target} start
Terminal=false
Categories=Utility;
EOF

chmod +x "${apps_dir}/phone-control.desktop" "${apps_dir}/phone-control-screen-off.desktop"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$apps_dir" >/dev/null 2>&1 || true
fi

cat <<MSG
Installed: ${target}
Desktop launchers:
  ${apps_dir}/phone-control.desktop
  ${apps_dir}/phone-control-screen-off.desktop

Make sure ${target_dir} is in PATH. Then run:
  phone-control doctor

Ubuntu dependencies:
  sudo apt update
  sudo apt install android-tools-adb scrcpy qrencode
MSG
