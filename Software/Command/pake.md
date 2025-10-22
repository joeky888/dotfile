Messenger
=====
* pnpm is required
* pnpm dlx is like npmx
* Download an app icon
* Save this to patch.js
```js
if (window.Notification && Notification.permission === "default") {
  Notification.requestPermission();
}
```
```bash
npm install -g pnpm@latest-10
mkdir app && cd app # Add ./patch.js here
pnpm dlx pake-cli https://www.messenger.com --name "Messenger" --inject ./patch.js --dark-mode --icon https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Facebook_Messenger_logo_2020.svg/32px-Facebook_Messenger_logo_2020.svg.png # With icon
```
