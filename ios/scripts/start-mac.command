#!/bin/bash
set -e
cd "$(dirname "$0")/.."
if ! command -v xcodebuild >/dev/null; then
  echo '需要先在這台 Mac 安裝並開啟 Xcode，下載 iOS Simulator。'; exit 1
fi
if ! command -v xcodegen >/dev/null; then
  echo '請先安裝 XcodeGen（brew install xcodegen），再執行此檔。'; exit 1
fi
xcodegen generate
open SleepyMochi.xcodeproj
