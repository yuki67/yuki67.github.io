// onloadという名前はjavascript側で予約されている
onload = function () {
    // documentとい名前もjavascript側で予約済み
    // canvasという名前はこのスクリプトを使うhtmlソースで指定したもの
    var cnv = document.getElementById('canvas');
    cnv.width = 750;
    cnv.height = 750;
    var gl = cnv.getContext('webgl');
    gl.clearColor(0.3, 0.7, 0.4, 1.0);
    gl.clear(gl.COLOR_BUFFER_BIT);
};
