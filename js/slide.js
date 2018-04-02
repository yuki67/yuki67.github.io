window.onload =
    (function(document, Reveal) {
        return function() {
            function save(elem) {
                elem.oldCssText = elem.style.cssText;
            }
            function hide(elem) {
                elem.style.display = "none";
            }
            function adjust(elem) {
                elem.style.padding = "0px";
                elem.style.margin = "0px";
                elem.style.maxWidth = "none";
            }
            function restore(elem) {
                elem.style.cssText = elem.oldCssText;
                delete elem.style.oldCssText;
            }
            function forEach(collection, f) {
                for (i = 0; i < collection.length; ++i) {
                    f(collection[i]);
                }
            }

            // to delete
            var header = document.getElementsByClassName("header");
            var post_meta = document.getElementsByClassName("post-meta");
            var prev_next_post = document.getElementsByClassName("prev-next-post");
            var content = document.getElementsByClassName("content");
            var menu = document.getElementById("menu");

            // to adjust
            var reveal = document.getElementsByClassName("reveal")[0];
            var main = document.getElementById("main");
            var layout = document.getElementById("layout");

            // save current css texts. (ugly, but works.)
            forEach(header, save);
            forEach(post_meta, save);
            forEach(prev_next_post, save);
            forEach(content, save);
            save(menu);
            save(main);
            save(reveal);
            save(layout);

            // this checkbox will be provided in posts.
            // for example "<input id="fullScreenFlag"> full screen"
            var checkbox = document.getElementById("fullScreenFlag");
            var to_fullscreen = function() {
                forEach(header, hide);
                forEach(post_meta, hide);
                forEach(prev_next_post, hide);
                forEach(header, adjust);
                forEach(post_meta, adjust);
                forEach(prev_next_post, adjust);
                forEach(content, adjust);
                hide(menu);
                adjust(main);
                adjust(layout);
                reveal.style.cssText = "";
                reveal.style.height = "100vh";
            }
            var to_windowed = function() {
                forEach(header, restore);
                forEach(post_meta, restore);
                forEach(prev_next_post, restore);
                forEach(content, restore);
                restore(menu);
                restore(main);
                restore(reveal);
                restore(layout);
                Reveal.layout();
            }
            checkbox.onchange = function() {
                if (checkbox.checked) {
                    to_fullscreen();
                } else {
                    to_windowed();
                }
            };
        }
    })(document, Reveal);
