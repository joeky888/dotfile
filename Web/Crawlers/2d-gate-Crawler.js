var links = [];
var title = document.querySelector("#thread_subject").innerHTML;
//<a href="http://link/to/file" download="FileName">Download it!</a>
var tags = document.querySelectorAll("div.gd_thumb");
for (var i = 0; i < tags.length; i++) {
    var str = tags[i].getAttribute("onclick").replace("javascript:gdclick_2dg(this,'", '').replace("','html5');", '');
    str = "https://docs.google.com/file/d/" + str + "/view";
    console.log(str);
    links.push(str);
}

tags = document.querySelectorAll("div.yt_thumb");
for (var i = 0; i < tags.length; i++) {
    var str = tags[i].getAttribute("onclick").replace("javascript:ytclick_2dg(this,'", '').replace("','');", '');
    str = "https://www.youtube.com/watch?v=" + str;
    console.log(str);
    links.push(str);
}

tags = document.querySelectorAll("span[href]");
for (var i = 0; i < tags.length; i++) {
    var str = tags[i].getAttribute("href");
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