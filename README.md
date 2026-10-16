# Sleepy Mochi · 晚安糰子

## 2026-10-16 階段成果

iPhone 原生視覺版已在 GitHub Actions 的 iPhone 模擬器執行，三個透明貓咪姿勢（清醒、打哈欠、熟睡）均可見，切換有交疊淡化，畫面與文字未超出螢幕。交疊期間可見短暫重影，尚未達最終視覺品質。

[觀看原生錄影](evidence/2026-10-16/mochi-iphone-preview.mp4)

[本輪完整執行紀錄](https://github.com/c8vzn4ym5g-ai/sleepy-mochi/actions/runs/38903087749)

- 來源提交：a74fd63d0cfcdd4837884f7382b30f9c62325196。
- 錄影來自實際 iPhone Simulator 的 MochiPreview，並非網頁或 YouTube 遮擋示意。
- 分享影片只縮小尺寸、轉為固定影格率並將最後一幀停留延長 3 秒；未生成新動作。
- 主程式與 Screen Time 擴充均編譯成功，這不代表背景監測或系統遮擋已實測成功。
- 此處狀態取代 ios/README.md 中「尚未在模擬器執行」的舊敘述。

## 下一個必須走通的鏈路

首次授權並選 YouTube → 寵物 App 進入背景 → 使用 YouTube 達門檻 → 系統顯示貓咪阻擋 → 解除阻擋。

尚未完成真機端到端測試，不能承諾系統阻擋畫面可連續動畫、短暫自動解除或無縫重複觸發。原生 App 內的淡化不等於其他 App 上的淡化。

## 手機實測環境缺口

目前可使用免費雲端 macOS／iPhone 模擬器。尚未接入可簽署 Family Controls 的 Apple 開發團隊、實機配置及實際 iPhone。Apple 官方說明此能力的開發存取經由 Apple Developer Program，TestFlight 分發另需申請分發權限；不能把一般免費七天 App 安裝當作這條鏈路已具備的條件。

https://developer.apple.com/documentation/xcode/configuring-family-controls

## 尚未完成的產品功能

- YouTube 背景觸發與真機遮擋。
- 系統遮擋換圖、淡化、短暫自動解除及重複出現。
- 鎖屏／睡眠辨識、成長與早晨回饋。

原生專案、啟動方式與實驗入口見 [ios/README.md](ios/README.md)。
