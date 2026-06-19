#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${HOME}/.local/bin"
target="${target_dir}/phone-control"

mkdir -p "$target_dir"
ln -sf "${repo_dir}/bin/phone-control" "$target"
chmod +x "${repo_dir}/bin/phone-control"

cat <<MSG
Installed: ${target}

Make sure ${target_dir} is in PATH. Then run:
  phone-control doctor

Ubuntu dependencies:
  sudo apt update
  sudo apt install android-tools-adb scrcpy
MSG
