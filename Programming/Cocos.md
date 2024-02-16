Blake Note
=====
* 一般遊戲斜走會比較快，是因為沒有用相似三角形，把兩個向量的合成向量給縮減力道
  * 可用三角函數將斜走的向量 輸出成一個 x 向量 跟 y向量的總和
* RWD 要訣
  * 底圖超出攝影機畫布一些
  * 2D UI 佈局 -> 添加 UI -> Widget 組件 -> 選擇將該按鈕自動置頂/底/左/右 多少 px
  * 必殺 -> 使用 script 動態調整
* 2D UI 佈局
* 3D 透明投影是由 相機坐標 > 相機畫布 > 投射到世界坐標，適合 3D 物體 (房子)
* 3D 正交投影是由 相機畫布 > 投射到世界坐標，缺乏立體感 適合 2D 物體 (對話框)

TypeScript
=====
* 如果 Component 裡變數用了 @property 作為裝飾，則會出現在 Cocos Creator 的 UI 上可調
  * 不論是 public 還是 private 都可以從 UI 調整
* 如果 Component 裡的 Class 去掉了 @ccclass('ClassName') 的話，則 Cocos Creator 的 UI 上會搜尋不到這個 Script
* 第一次載入 Component 的時候會執行一次 onLoad() 適合用來初始化變數 -> 若使用 AddComponent 方法的話，這個會先行執行
* 第一次畫面刷新的時候會執行一次 start() 適合用來初始化變數 -> 第一次 update 之前會先執行一次
* 每次畫面刷新的時候都會執行 update() 適合寫邏輯