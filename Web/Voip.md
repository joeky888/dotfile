VoIP vs PSTN
=====
* VoIP 網路電話：Skype
* PSTN 電話網路：市話/手機

上下車
=====
* 網路(Internet)連上PSTN俗稱為「下車」
* 由PSTN 連上Internet則俗稱為「上車」
* Trunk Gateway 負責介接 VoIP 與 PSTN 使得雙方的電話機可以通話，俗稱上下車設備

穿越防火牆
=====
* UPnP(即插即用)：未得到所有的UA及NAT的支援，棄用
* ALG：未得到所有的UA及NAT的支援，棄用
* STUN：
    * 不可穿透Symmetric NAT 防火牆
    * 最著名和最常被使用的VoIP穿越NAT防火牆的解決辦法
    * P2P
    * 利用位於 Internet 上的伺服器幫助防火牆內的UA獲知他們被NAT 轉換過的外部位址
* TURN：
    * 足以穿透Symmetric NAT 防火牆
    * 一個VoIP session 中的兩個端點所送出的封包全部先送給TURN server，再由 TURN server 轉送給對方
    * TURN server 流量負擔大，不得已下才能考慮使用
* ICE：
    * 結合STUN和TURN 的 framwork，不是協議
    * 先嘗試使用 STUN 做 P2P 連線，失敗則轉用 TURN server
    * WebRTC 即使用 ICE

PBX 電話交換機
=====
* 企業內部使用的私有電話網絡(內線)
* PBX電話系統的用戶們須共用一定數量的外線，才能向外界撥打電話
* 如果支援聯網功能的話稱爲 VOIP PBX 或 IP PBX
    * 可以上下車(連接網際網路跟電話網)
    * Skype 打給 市話
