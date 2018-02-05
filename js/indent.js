(function (window, document) {
    var contents = document.getElementsByClassName('content')[0].childNodes;
    var indent_level = 0;
    for (var i = 0; i < contents.length; ++i) {
        const elem = contents[i];
        const type = contents[i].tagName;
        if (type == "H2") {
            indent_level = 0;
        } else if (type == "H3") {
            indent_level = 1;
        } else if (type == "H4") {
            indent_level = 2;
        } else if (type == "H5") {
            indent_level = 3;
        } else if (type == "H6") {
            indent_level = 4;
        }
        if (typeof(elem.style) !== "undefined") {
            elem.style.marginLeft = indent_level + "em";
        }
    }
}(this, this.document));
