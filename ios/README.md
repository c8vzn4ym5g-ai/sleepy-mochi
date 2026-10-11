# 晚安糰子 · iPhone 原生測試專案

狀態：原生初稿已建立，尚未在 Mac 編譯、Simulator 或真 iPhone 執行。不能將源碼完成視為功能通過。

## Mac 開始方式

安裝 Xcode 與 iOS Simulator、XcodeGen；執行 scripts/start-mac.command。

- MochiPreview：無 Screen Time 權限依賴的原生視覺版，打開即顯示貓咪，三姿勢以 1.2 秒交疊淡化，最後停在熟睡。
- Mochi：需配置 Apple 開發團隊、Family Controls 及 App Group。第一次系統授權並在 Apple 選擇器選 YouTube，保存後不再詢問。
- MochiProbe：同一個原生版的開發入口，另顯示阻擋／解除／下個姿勢，供工程量測使用。

## 第一條鏈路（待真機驗證）

授權 → 選 YouTube → 保存 → App 退背景 → 觀看累計達 1 分鐘 → DeviceActivity 回呼 → 系統 shield 顯示真貓。
當天之前的累計使用可能影響首次觸發；1 分鐘是測試門檻，不是精準倒數承諾。
Shield 的「晚安」按鈕解除阻擋並要求關閉被阻擋 App。這是最小測試版的退出路徑；尚未實作 10 秒後自動解除。
目前每天只安排一次門檻事件，並不構成完整睡前產品。監測期間結束會清除阻擋。

## 第二條鏈路（實驗，未證實）

使用 MochiProbe 依序 apply → clear → next pose/apply；錄製 YouTube 畫面，對照 Console 的 ShieldProbe 日誌。
日誌記錄的是要求更新和 configuration 回呼時間，**不是**像素真正出現時間。
必須另測 App 在背景時的再觸發。不能把前景操作結果當成背景成功。
不能假設 apply 相同 token 必定重新呼叫 configuration，不能假設移除 shield 會立即釋放畫面。
0/50/100/250/500/1000ms 是待比較的實验間隔，不是已量測結果。

## 明確未完成

- iOS 系統 shield 的連續換圖、重新出現延遲、淡化效果。
- 10–15 秒自動解除，以及背景下可靠的第二次、第三次觸發。
- 自動識別手機鎖屏或判定睡眠。App 進背景不代表使用者睡了。
- 寵物成長／活力／早晨回饋，待上述鏈路通過再接入。

## 環境選擇（2026-10-10）

目前工作區只有 Linux，沒有已連線的 Mac 或 Apple 簽署帳號。
優先：使用既有或借用的 Mac，裝免費 Xcode，做 Preview；取得 Mac 並不代表 Screen Time 權限問題已解決。
備選：MacinCloud Managed，官方支持頁列新客 US$0.99／24 小時試用。需帳號與付款，未購買、未開通；續費與操作連線方式須在結帳前確認。
https://support.macincloud.com/support/solutions/articles/8000061773-is-there-a-trial-for-macincloud-
Apple Family Controls 開發權限需確認開發者方案資格；不能沿用「一般 App 免費七天安裝」就推定可以用此能力。
https://developer.apple.com/documentation/xcode/configuring-family-controls
系統 shield 提供 icon/title 等欄位，非自訂動畫畫布：
https://developer.apple.com/documentation/managedsettingsui/shieldconfiguration
DeviceActivity 排程最短十五分鐘，不能拿它當 0.x 秒逐幀排程器；這是排程期間限制，不代表兩次 shield 一定要隔十五分鐘。
https://developer.apple.com/documentation/deviceactivity/deviceactivitycenter/monitoringerror/intervaltooshort

## 免費優先：GitHub Actions

新增 github/ios-simulator.yml。將完整 ios/ 放在專用 GitHub 專案根目錄，並把此 workflow 複製到 .github/workflows/ios-simulator.yml。
使用標準 macos-15 runner，啟動 iPhone Simulator，編譯及安裝 MochiPreview，錄製 16 秒影片並存成 artifact；另編譯 Screen Time 各 target。
此流程尚未送到 GitHub 執行。模擬器視覺結果不代表 Screen Time 跨 App 成功。
標準 GitHub-hosted runners 公開 repo 免費，私人 repo 視帳號免費額度；未核對帳號用量，不保證私人執行零費用。
https://docs.github.com/en/actions/concepts/billing-and-usage
https://github.com/actions/runner-images
