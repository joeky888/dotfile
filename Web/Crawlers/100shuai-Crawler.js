var links = [];
var title = document.querySelector("div.headline > h1").innerHTML;
console.log(title);
var tags = document.querySelectorAll("#youku > a[href]");
for (var i = 0; i < tags.length; i++) {
    var str = tags[i].getAttribute("onclick").replace("getplayParas('", '');
    if(str.indexOf("wwe100") > 0) {
        str = str.replace("_youku','wwe100');", '');
    } else {
        str = str.replace("','youku');", '');
    }
    str = "http://v.youku.com/v_show/id_" + str + ".html";
    console.log(str);
    links.push(str);
}

tags = document.querySelectorAll("#tudou > a[href]");
for (var i = 0; i < tags.length; i++) {
    var str = tags[i].getAttribute("onclick").replace("getplayParas('", '').replace("','tudou');", '');
    str = "http://www.tudou.com/v/" + str + "/&withRecommendList=false&autoPlay=true&videoClickNavigate=false&withSearchBar=false&withRecommendList=false/v.swf";
    console.log(str);
    links.push(str);
}

tags = document.querySelectorAll("#pptv > a[href]");
for (var i = 0; i < tags.length; i++) {
    var str = tags[i].getAttribute("onclick").replace("getplayParas('", '').replace("','pptv');", '');
    str = "http://player.pptv.com/v/" + str + ".swf";
    console.log(str);
    links.push(str);
}

(function downloadAsFile(){
    var textToSave = "";
    if(links.length == 0) {
        console.log("Can not find any video");
        return;
    } else {
        textToSave += links[0];
    }
    for (var i = 1; i < links.length; i++) {
        textToSave += "\n" + links[i];
    }
    
    var textToSaveAsBlob = new Blob([textToSave], {type:"text/plain"});
    var textToSaveAsURL = window.URL.createObjectURL(textToSaveAsBlob);
    var fileNameToSaveAs = title + ".txt";
 
    var downloadLink = document.createElement("a");
    downloadLink.download = fileNameToSaveAs;
    downloadLink.innerHTML = "Download File";
    downloadLink.href = textToSaveAsURL;
    downloadLink.style.display = "none";
    
    /*
    downloadLink.onclick = function(event){
        document.body.removeChild(event.target);
    };
    document.body.appendChild(downloadLink);*/
 
    downloadLink.click();
})();