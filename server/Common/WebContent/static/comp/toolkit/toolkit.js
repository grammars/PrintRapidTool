/** 支持渐变过度的图片查看器 */
var PicsViewer = {
			create: function(ctn, picsArr) {
				var pv = {"ctn":ctn, "picsArr":picsArr};
				/** tweenTime渐变时间，keepTime静止时间 */
				pv.run = function (tweenTime, keepTime) {
					var imgList = [];
					for(var i = 0; i < this.picsArr.length; i++) {
						var picUrl = this.picsArr[i];
						console.log("picUrl="+picUrl);
						var img = $("<img src='"+picUrl+"' />");
						ctn.append(img);
						console.log("img="+img);
						// img.css("width", "500px");
						img.css("position", "fixed");
						imgList.push(img);
					}
					// console.log("imgList.length="+imgList.length);
					var curInd = 0;
					setInterval(function(){
						imgList[curInd].animate({opacity: '1'}, tweenTime);
						for(var i = 0; i < imgList.length; i++) {
							if(i != curInd) {
								imgList[i].animate({opacity: '0'}, tweenTime);
							}
						}
						curInd++;
						if(curInd >= imgList.length) {
							curInd = 0;
						}
					}, keepTime+tweenTime);
				};
				return pv;
			}
		}


/**
 * 使固定居中
 * 
 * @param target
 *            jQuery对象
 */
function fixCentre(target) {
	target.css("position", "fixed");
	function setPos() {
		target.css("top",
				($(window).height() - target.height()) / 2);
		target.css("left",
				($(window).width() - target.width()) / 2);
	}
	setPos();
	$(window).resize(function() {
		setPos();
	});
}

/** 将json字符串转变为object */
function toJsonObj (jsonStr) {
	return eval('(' + jsonStr + ')');
}

