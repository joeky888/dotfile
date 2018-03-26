function FindProxyForURL(url,host) {
   if(check(host,",")) return "";
   if(check(host,"_")) return "";
   if(check(host,";")) return "DIRECT";

// TANet -> DIRECT
   if ( inDomain(host,"localhost")||
        inDomain(host,".edu.tw")||
	inNet(host,"140.109.")||
	inNet(host,"140.110.")||
	inNet(host,"140.112.")||
	inNet(host,"140.113.")||
	inNet(host,"140.114.")||
	inNet(host,"140.115.")||
 	inNet(host,"140.116.")||
	inNet(host,"140.117.")||
	inNet(host,"140.128.")||
	inNet(host,"140.136.")||
	inNet(host,"140.137.")||
	inNet(host,"140.138.")
   )
   	return "DIRECT";

// HiNet -> DIRECT
//   else if ( inDomain(host,".hinet.net")||
//	     inDomain(host,".hichannel.com.tw")
//   )
//	return "DIRECT";

// ETB -> DIRECT
//   else if ( inDomain(host,"ads.sina.com.tw")||
//	     inDomain(host,".ettoday.com")
//   )
//	return "DIRECT";

// TFN -> DIRECT
//   else if ( inDomain(host,".104.com.tw")||
//	     inDomain(host,".anet.net.tw")
//  )
//	return "DIRECT";

// -> proxy.nthu.edu.tw
   else 
       return "PROXY proxy.nthu.edu.tw:3128";
}

function check(target,term) {
  if(target.indexOf(term) > 0) {
        return true;
  }
  return false;
}

function inDomain(host,postfix) {
   var n = host.toLowerCase().lastIndexOf(postfix);
   return (n >= 0 && n + postfix.length == host.length);
}
    
function inNet(host,prefix) {
   return (host.toLowerCase().indexOf(prefix) == 0);
}

