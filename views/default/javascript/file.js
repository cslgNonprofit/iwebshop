/**
 * @brief 客户端获取文件大小
 * @param file 表单元素file的id值
 * @return 如果检测出文件大小，返回文件大小；检测不出，返回null
 */
function getFileSize(file) {
	var fileIsSize;
	var dFile = document.getElementById(file);

	var Sys = {};
    var ua = navigator.userAgent.toLowerCase();
    var s;
    (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
    (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
    (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
    (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
    (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;

    if (Sys.ie=='6.0'){
    	file = dFile.value;
		var image = new Image();
		image.dynsrc = file;
		fileIsSize = image.fileSize;
		if(fileIsSize<0){
			return null;
		}
		return fileIsSize;
    }else if(Sys.ie=='7.0' || Sys.ie=='8.0'){
        return null;
	}else if(Sys.firefox || Sys.chrome || Sys.safari){
		fileIsSize = dFile.files[0].fileSize;
		return fileIsSize;
	}else if(Sys.opera){
		return null;
	}else{
		return null;
	}
}

/**
 * @brief 客户端获取文件类型
 * @param file 表单元素file的id值
 * @return 返回文件后缀名
 */
function getFileType(file) {
	var fileName = document.getElementById(file).value.toLowerCase();
	var pos = fileName.lastIndexOf(".");
	var ext = fileName.substring(pos+1,fileName.length)
	return ext;
}