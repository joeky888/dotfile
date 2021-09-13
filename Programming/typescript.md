New empty project
=====
```sh
mkdir project && cd project
npm init -y
npm install typescript --save-dev
npx tsc --init
vim index.ts
`
console.log(`hello`);
`
npx tsc -w
```

json marsharl/unmarsharl
=====
* JSON.stringify()
* JSON.parse()

HTTP rxjs client with rate limit (max concurrency)
=====
* Support nodejs and browser (React-Native should work)
```typescript
import { ajax, AjaxConfig, AjaxResponse } from 'rxjs/ajax';
const xhr2 = require('xhr2');
import { lastValueFrom } from 'rxjs';

const githubUsers = `http://127.0.0.1:3000/`;
const MaxConcurrentRequest = 1
const DefaultTimeout = 3000 // ms

let currentRequest = 0
let callCount = 0
let waitQueue: Array<Function> = [];

async function ajaxFetch(config: AjaxConfig): Promise<AjaxResponse<any>> {
  const callIndex = callCount++;
  if (currentRequest >= MaxConcurrentRequest) {
    await new Promise<void>((resolve) => waitQueue.push(resolve));
  }
  console.log(callIndex, "get pool");
  currentRequest++;
  try {
    let ajaxConf = Object.assign({
      timeout: DefaultTimeout,
      method: "GET",
      headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Accept": "application/json",
      },
      createXHR: (typeof XMLHttpRequest !== 'undefined') ? undefined : (() => new xhr2() as XMLHttpRequest)
    }, config);
    const result = await lastValueFrom(ajax(ajaxConf))
    if (result.status > 299) {
      console.error(`Bad status: ${result.status}, response: ${JSON.stringify(result.response)}, reproduce: ${toCurl(ajaxConf)}`)
    }
    return result
  } catch (error) {
    throw error;
  } finally {
    console.log(callIndex, "release pool");
    currentRequest--;
    waitQueue.shift()?.()
  }
}

function toCurl(ajaxConf: AjaxConfig): String {
  return [
    `curl -i --compressed -X ${ajaxConf.method} ${ajaxConf.url}`,
    ...Object.entries(ajaxConf.headers ?? {}).map((key, value) => `-H "${key}: ${value}"`),
    ...ajaxConf.body ? [] : [`-d '${JSON.stringify(ajaxConf.body)}'`],
  ].join(" ");
}

ajaxFetch({ url: githubUsers }).then((e) => console.log(e.response), console.warn);
ajaxFetch({ url: githubUsers }).then((e) => console.log(e.response), console.warn);
```
