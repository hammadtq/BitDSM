"use strict";exports.id=402,exports.ids=[402],exports.modules={89402:(e,t,a)=>{a.d(t,{offchainLookup:()=>g,offchainLookupSignature:()=>m});var s=a(9599),r=a(92330),n=a(91270),o=a(33289);class c extends n.G{constructor({callbackSelector:e,cause:t,data:a,extraData:s,sender:r,urls:n}){super(t.shortMessage||"An error occurred while fetching for an offchain result.",{cause:t,metaMessages:[...t.metaMessages||[],t.metaMessages?.length?"":[],"Offchain Gateway Call:",n&&["  Gateway URL(s):",...n.map(e=>`    ${(0,o.G)(e)}`)],`  Sender: ${r}`,`  Data: ${a}`,`  Callback selector: ${e}`,`  Extra data: ${s}`].flat(),name:"OffchainLookupError"})}}class d extends n.G{constructor({result:e,url:t}){super("Offchain gateway response is malformed. Response data must be a hex value.",{metaMessages:[`Gateway URL: ${(0,o.G)(t)}`,`Response: ${(0,r.P)(e)}`],name:"OffchainLookupResponseMalformedError"})}}class i extends n.G{constructor({sender:e,to:t}){super("Reverted sender address does not match target contract address (`to`).",{metaMessages:[`Contract address: ${t}`,`OffchainLookup sender address: ${e}`],name:"OffchainLookupSenderMismatchError"})}}var u=a(54427),f=a(83928),l=a(20554),p=a(71204),h=a(73223),y=a(11317);let m="0x556f1830",w={name:"OffchainLookup",type:"error",inputs:[{name:"sender",type:"address"},{name:"urls",type:"string[]"},{name:"callData",type:"bytes"},{name:"callbackFunction",type:"bytes4"},{name:"extraData",type:"bytes"}]};async function g(e,{blockNumber:t,blockTag:a,data:r,to:n}){let{args:o}=(0,f.p)({data:r,abi:[w]}),[d,u,y,m,g]=o,{ccipRead:k}=e,G=k&&"function"==typeof k?.request?k.request:x;try{if(!(0,p.E)(n,d))throw new i({sender:d,to:n});let r=await G({data:y,sender:d,urls:u}),{data:o}=await (0,s.R)(e,{blockNumber:t,blockTag:a,data:(0,h.zo)([m,(0,l.E)([{type:"bytes"},{type:"bytes"}],[r,g])]),to:n});return o}catch(e){throw new c({callbackSelector:m,cause:e,data:r,extraData:g,sender:d,urls:u})}}async function x({data:e,sender:t,urls:a}){let s=Error("An unknown error occurred.");for(let n=0;n<a.length;n++){let o=a[n],c=o.includes("{data}")?"GET":"POST",i="POST"===c?{data:e,sender:t}:void 0;try{let a;let n=await fetch(o.replace("{sender}",t).replace("{data}",e),{body:JSON.stringify(i),method:c});if(a=n.headers.get("Content-Type")?.startsWith("application/json")?(await n.json()).data:await n.text(),!n.ok){s=new u.Gg({body:i,details:a?.error?(0,r.P)(a.error):n.statusText,headers:n.headers,status:n.status,url:o});continue}if(!(0,y.v)(a)){s=new d({result:a,url:o});continue}return a}catch(e){s=new u.Gg({body:i,details:e.message,url:o})}}throw s}}};