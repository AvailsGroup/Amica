!function(n){var e={};function t(A){if(e[A])return e[A].exports;var o=e[A]={i:A,l:!1,exports:{}};return n[A].call(o.exports,o,o.exports,t),o.l=!0,o.exports}t.m=n,t.c=e,t.d=function(n,e,A){t.o(n,e)||Object.defineProperty(n,e,{enumerable:!0,get:A})},t.r=function(n){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(n,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(n,"__esModule",{value:!0})},t.t=function(n,e){if(1&e&&(n=t(n)),8&e)return n;if(4&e&&"object"===typeof n&&n&&n.__esModule)return n;var A=Object.create(null);if(t.r(A),Object.defineProperty(A,"default",{enumerable:!0,value:n}),2&e&&"string"!=typeof n)for(var o in n)t.d(A,o,function(e){return n[e]}.bind(null,o));return A},t.n=function(n){var e=n&&n.__esModule?function(){return n.default}:function(){return n};return t.d(e,"a",e),e},t.o=function(n,e){return Object.prototype.hasOwnProperty.call(n,e)},t.p="/packs/",t(t.s=201)}({155:function(n,e,t){"use strict";var A,o=function(){return"undefined"===typeof A&&(A=Boolean(window&&document&&document.all&&!window.atob)),A},i=function(){var n={};return function(e){if("undefined"===typeof n[e]){var t=document.querySelector(e);if(window.HTMLIFrameElement&&t instanceof window.HTMLIFrameElement)try{t=t.contentDocument.head}catch(A){t=null}n[e]=t}return n[e]}}(),a=[];function r(n){for(var e=-1,t=0;t<a.length;t++)if(a[t].identifier===n){e=t;break}return e}function l(n,e){for(var t={},A=[],o=0;o<n.length;o++){var i=n[o],l=e.base?i[0]+e.base:i[0],d=t[l]||0,s="".concat(l," ").concat(d);t[l]=d+1;var c=r(s),m={css:i[1],media:i[2],sourceMap:i[3]};-1!==c?(a[c].references++,a[c].updater(m)):a.push({identifier:s,updater:p(m,e),references:1}),A.push(s)}return A}function d(n){var e=document.createElement("style"),A=n.attributes||{};if("undefined"===typeof A.nonce){var o=t.nc;o&&(A.nonce=o)}if(Object.keys(A).forEach((function(n){e.setAttribute(n,A[n])})),"function"===typeof n.insert)n.insert(e);else{var a=i(n.insert||"head");if(!a)throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");a.appendChild(e)}return e}var s,c=(s=[],function(n,e){return s[n]=e,s.filter(Boolean).join("\n")});function m(n,e,t,A){var o=t?"":A.media?"@media ".concat(A.media," {").concat(A.css,"}"):A.css;if(n.styleSheet)n.styleSheet.cssText=c(e,o);else{var i=document.createTextNode(o),a=n.childNodes;a[e]&&n.removeChild(a[e]),a.length?n.insertBefore(i,a[e]):n.appendChild(i)}}function C(n,e,t){var A=t.css,o=t.media,i=t.sourceMap;if(o?n.setAttribute("media",o):n.removeAttribute("media"),i&&"undefined"!==typeof btoa&&(A+="\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(i))))," */")),n.styleSheet)n.styleSheet.cssText=A;else{for(;n.firstChild;)n.removeChild(n.firstChild);n.appendChild(document.createTextNode(A))}}var f=null,b=0;function p(n,e){var t,A,o;if(e.singleton){var i=b++;t=f||(f=d(e)),A=m.bind(null,t,i,!1),o=m.bind(null,t,i,!0)}else t=d(e),A=C.bind(null,t,e),o=function(){!function(n){if(null===n.parentNode)return!1;n.parentNode.removeChild(n)}(t)};return A(n),function(e){if(e){if(e.css===n.css&&e.media===n.media&&e.sourceMap===n.sourceMap)return;A(n=e)}else o()}}n.exports=function(n,e){(e=e||{}).singleton||"boolean"===typeof e.singleton||(e.singleton=o());var t=l(n=n||[],e);return function(n){if(n=n||[],"[object Array]"===Object.prototype.toString.call(n)){for(var A=0;A<t.length;A++){var o=r(t[A]);a[o].references--}for(var i=l(n,e),d=0;d<t.length;d++){var s=r(t[d]);0===a[s].references&&(a[s].updater(),a.splice(s,1))}t=i}}}},156:function(n,e,t){"use strict";n.exports=function(n){var e=[];return e.toString=function(){return this.map((function(e){var t=function(n,e){var t=n[1]||"",A=n[3];if(!A)return t;if(e&&"function"===typeof btoa){var o=(a=A,r=btoa(unescape(encodeURIComponent(JSON.stringify(a)))),l="sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(r),"/*# ".concat(l," */")),i=A.sources.map((function(n){return"/*# sourceURL=".concat(A.sourceRoot||"").concat(n," */")}));return[t].concat(i).concat([o]).join("\n")}var a,r,l;return[t].join("\n")}(e,n);return e[2]?"@media ".concat(e[2]," {").concat(t,"}"):t})).join("")},e.i=function(n,t,A){"string"===typeof n&&(n=[[null,n,""]]);var o={};if(A)for(var i=0;i<this.length;i++){var a=this[i][0];null!=a&&(o[a]=!0)}for(var r=0;r<n.length;r++){var l=[].concat(n[r]);A&&o[l[0]]||(t&&(l[2]?l[2]="".concat(t," and ").concat(l[2]):l[2]=t),e.push(l))}},e}},201:function(n,e,t){var A=t(155),o=t(202);"string"===typeof(o=o.__esModule?o.default:o)&&(o=[[n.i,o,""]]);var i={insert:"head",singleton:!1};A(o,i);n.exports=o.locals||{}},202:function(n,e,t){(e=t(156)(!0)).push([n.i,'/*! normalize.css v7.0.0 | MIT License | github.com/necolas/normalize.css */html{line-height:1.15;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0}article,aside,footer,header,nav,section{display:block}h1{font-size:2em;margin:.67em 0}figcaption,figure,main{display:block}figure{margin:1em 40px}hr{box-sizing:content-box;height:0;overflow:visible}pre{font-family:monospace,monospace;font-size:1em}a{background-color:transparent;-webkit-text-decoration-skip:objects}abbr[title]{border-bottom:none;text-decoration:underline;-webkit-text-decoration:underline dotted;text-decoration:underline dotted}b,strong{font-weight:inherit}b,strong{font-weight:bolder}code,kbd,samp{font-family:monospace,monospace;font-size:1em}dfn{font-style:italic}mark{background-color:#ff0;color:#000}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-0.25em}sup{top:-0.5em}audio,video{display:inline-block}audio:not([controls]){display:none;height:0}img{border-style:none}svg:not(:root){overflow:hidden}button,input,optgroup,select,textarea{font-family:sans-serif;font-size:100%;line-height:1.15;margin:0}button,input{overflow:visible}button,select{text-transform:none}button,html [type=button],[type=reset],[type=submit]{-webkit-appearance:button}button::-moz-focus-inner,[type=button]::-moz-focus-inner,[type=reset]::-moz-focus-inner,[type=submit]::-moz-focus-inner{border-style:none;padding:0}button:-moz-focusring,[type=button]:-moz-focusring,[type=reset]:-moz-focusring,[type=submit]:-moz-focusring{outline:1px dotted ButtonText}fieldset{padding:.35em .75em .625em}legend{box-sizing:border-box;color:inherit;display:table;max-width:100%;padding:0;white-space:normal}progress{display:inline-block;vertical-align:baseline}textarea{overflow:auto}[type=checkbox],[type=radio]{box-sizing:border-box;padding:0}[type=number]::-webkit-inner-spin-button,[type=number]::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}[type=search]::-webkit-search-cancel-button,[type=search]::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}details,menu{display:block}summary{display:list-item}canvas{display:inline-block}template{display:none}[hidden]{display:none}html{font-size:100.01%}body{font-size:75%;font-family:"Helvetica Neue",Arial,Helvetica,sans-serif}h1,h2,h3,h4,h5,h6{font-weight:normal;color:#000}h1 img,h2 img,h3 img,h4 img,h5 img,h6 img{margin:0}h1{font-size:3em;line-height:1;margin-bottom:.5em}h2{font-size:2em;margin-bottom:.75em}h3{font-size:1.5em;line-height:1;margin-bottom:1em}h4{font-size:1.2em;line-height:1.25;margin-bottom:1.25em}h5{font-size:1em;font-weight:bold;margin-bottom:1.5em}h6{font-size:1em;font-weight:bold}p{margin:0 0 1.5em}p .left{margin:1.5em 1.5em 1.5em 0;padding:0}p .right{margin:1.5em 0 1.5em 1.5em;padding:0}.left{float:left !important}.right{float:right !important}blockquote{margin:1.5em;color:#666;font-style:italic}strong,dfn{font-weight:bold}em,dfn{font-style:italic}sup,sub{line-height:0}abbr,acronym{border-bottom:1px dotted #666}address{margin:0 0 1.5em;font-style:italic}del{color:#666}pre{margin:1.5em 0;white-space:pre}pre,code,tt{font:1em "andale mono","lucida console",monospace;line-height:1.5}li ul,li ol{margin:0}ul,ol{margin:0 1.5em 1.5em 0;padding-left:1.5em}ul{list-style-type:disc}ol{list-style-type:decimal}dl{margin:0 0 1.5em 0}dl dt{font-weight:bold}dd{margin-left:1.5em}table{margin-bottom:1.4em;width:100%}th{font-weight:bold}thead th{background:#c3d9ff}th,td,caption{padding:4px 10px 4px 5px}.small{font-size:.8em;margin-bottom:1.875em;line-height:1.875em}.large{font-size:1.2em;line-height:2.5em;margin-bottom:1.25em}.hide{display:none}.quiet{color:#666}.loud{color:#000}.highlight{background:#ff0}.added{background:#060;color:#fff}.removed{background:#900;color:#fff}.first{margin-left:0;padding-left:0}.last{margin-right:0;padding-right:0}.top{margin-top:0;padding-top:0}.bottom{margin-bottom:0;padding-bottom:0}body{font-family:Helvetica,Arial,sans-serif;line-height:150%;font-size:72%;background:#fff;width:99%;margin:0;padding:.5%;color:#000}a{color:#000;text-decoration:none}h3{font-weight:bold;margin-bottom:.5em}#header{float:left}#header #tabs,#header .tabs,#header #utility_nav{display:none}#header h1{font-weight:bold}.flashes{display:none}#title_bar{float:right}#title_bar h2{line-height:2em;margin:0}#title_bar .breadcrumb,#title_bar #titlebar_right{display:none}#active_admin_content{border-top:thick solid #000;clear:both;margin-top:2em;padding-top:3em}#footer{display:none}.table_tools ul{padding:0;margin:0;list-style-type:none}.table_tools ul li{display:none;padding:0;margin-bottom:1em}.table_tools ul li.scope.selected,.table_tools ul li.index.selected{display:block}.table_tools ul li.scope.selected:before,.table_tools ul li.index.selected:before{content:"Showing "}.table_tools ul li.scope.selected a,.table_tools ul li.index.selected a{font-weight:bold}.table_tools ul li.scope.selected span,.table_tools ul li.index.selected span{display:inline-block;font-weight:normal;font-size:.9em}table{margin-bottom:1.5em;text-align:left;width:100%}table thead{display:table-header-group}table thead th{background:none;border-bottom:medium solid #000;font-weight:bold}table thead th a{text-decoration:none}table th,table td{padding:.5em 1em}table th .member_link,table td .member_link{display:none}table td{border-bottom:thin solid #000}table tr{page-break-inside:avoid}#index_footer,.pagination_information{display:none}.index_grid td{border:none;text-align:center;vertical-align:middle}.index_grid td img{max-width:1in}.panel{border-bottom:thick solid #ccc;margin-bottom:3em;padding-bottom:2em;page-break-inside:avoid}.panel:last-child{border-bottom:none}.comments form{display:none}.comments .active_admin_comment{border-top:thin solid #000;padding-top:1em}.comments .active_admin_comment .active_admin_comment_meta h4{font-size:1em;font-weight:bold;float:left;margin-right:.5em;margin-bottom:0}.comments .active_admin_comment .active_admin_comment_meta span{font-size:.9em;font-style:italic;vertical-align:top}.comments .active_admin_comment .active_admin_comment_body{clear:both;margin-bottom:1em}.attributes_table{border-top:medium solid #000}.attributes_table th{border-bottom:thin solid #000;vertical-align:top}.attributes_table th:after{content:":"}.attributes_table td img{max-height:4in;max-width:6in}#filters_sidebar_section{display:none}form fieldset{border-top:thick solid #ccc;padding-top:2em;margin-bottom:2em}form fieldset:last-child{border-bottom:none}form .buttons,form abbr{display:none}form ol{list-style-type:none;padding:0;margin:0}form ol li{border-top:thin solid #000;margin:0;padding:1em 0;overflow:hidden}form ol li.password,form ol li.hidden{display:none}form ol li label{font-weight:bold;float:left;width:20%}form ol li input,form ol li textarea,form ol li select{background:none;border:0;font:Arial,Helvetica,sans-serif}form ol li input[type=file]{display:none}.unsupported_browser{display:none}',"",{version:3,sources:["C:\\Users\\yurisi\\RubymineProjects\\Amica\\node_modules\\@activeadmin\\activeadmin\\src\\scss\\_normalize.scss","C:\\Users\\yurisi\\RubymineProjects\\Amica\\node_modules\\@activeadmin\\activeadmin\\src\\scss\\_typography.scss","C:\\Users\\yurisi\\RubymineProjects\\Amica\\node_modules\\@activeadmin\\activeadmin\\src\\scss\\print.scss"],names:[],mappings:"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",file:"print.scss",sourcesContent:['/*! normalize.css v7.0.0 | MIT License | github.com/necolas/normalize.css */\n\n/* Document\n   ========================================================================== */\n\n/**\n * 1. Correct the line height in all browsers.\n * 2. Prevent adjustments of font size after orientation changes in\n *    IE on Windows Phone and in iOS.\n */\n\nhtml {\n  line-height: 1.15; /* 1 */\n  -ms-text-size-adjust: 100%; /* 2 */\n  -webkit-text-size-adjust: 100%; /* 2 */\n}\n\n/* Sections\n   ========================================================================== */\n\n/**\n * Remove the margin in all browsers (opinionated).\n */\n\nbody {\n  margin: 0;\n}\n\n/**\n * Add the correct display in IE 9-.\n */\n\narticle,\naside,\nfooter,\nheader,\nnav,\nsection {\n  display: block;\n}\n\n/**\n * Correct the font size and margin on `h1` elements within `section` and\n * `article` contexts in Chrome, Firefox, and Safari.\n */\n\nh1 {\n  font-size: 2em;\n  margin: 0.67em 0;\n}\n\n/* Grouping content\n   ========================================================================== */\n\n/**\n * Add the correct display in IE 9-.\n * 1. Add the correct display in IE.\n */\n\nfigcaption,\nfigure,\nmain { /* 1 */\n  display: block;\n}\n\n/**\n * Add the correct margin in IE 8.\n */\n\nfigure {\n  margin: 1em 40px;\n}\n\n/**\n * 1. Add the correct box sizing in Firefox.\n * 2. Show the overflow in Edge and IE.\n */\n\nhr {\n  box-sizing: content-box; /* 1 */\n  height: 0; /* 1 */\n  overflow: visible; /* 2 */\n}\n\n/**\n * 1. Correct the inheritance and scaling of font size in all browsers.\n * 2. Correct the odd `em` font sizing in all browsers.\n */\n\npre {\n  font-family: monospace, monospace; /* 1 */\n  font-size: 1em; /* 2 */\n}\n\n/* Text-level semantics\n   ========================================================================== */\n\n/**\n * 1. Remove the gray background on active links in IE 10.\n * 2. Remove gaps in links underline in iOS 8+ and Safari 8+.\n */\n\na {\n  background-color: transparent; /* 1 */\n  -webkit-text-decoration-skip: objects; /* 2 */\n}\n\n/**\n * 1. Remove the bottom border in Chrome 57- and Firefox 39-.\n * 2. Add the correct text decoration in Chrome, Edge, IE, Opera, and Safari.\n */\n\nabbr[title] {\n  border-bottom: none; /* 1 */\n  text-decoration: underline; /* 2 */\n  text-decoration: underline dotted; /* 2 */\n}\n\n/**\n * Prevent the duplicate application of `bolder` by the next rule in Safari 6.\n */\n\nb,\nstrong {\n  font-weight: inherit;\n}\n\n/**\n * Add the correct font weight in Chrome, Edge, and Safari.\n */\n\nb,\nstrong {\n  font-weight: bolder;\n}\n\n/**\n * 1. Correct the inheritance and scaling of font size in all browsers.\n * 2. Correct the odd `em` font sizing in all browsers.\n */\n\ncode,\nkbd,\nsamp {\n  font-family: monospace, monospace; /* 1 */\n  font-size: 1em; /* 2 */\n}\n\n/**\n * Add the correct font style in Android 4.3-.\n */\n\ndfn {\n  font-style: italic;\n}\n\n/**\n * Add the correct background and color in IE 9-.\n */\n\nmark {\n  background-color: #ff0;\n  color: #000;\n}\n\n/**\n * Add the correct font size in all browsers.\n */\n\nsmall {\n  font-size: 80%;\n}\n\n/**\n * Prevent `sub` and `sup` elements from affecting the line height in\n * all browsers.\n */\n\nsub,\nsup {\n  font-size: 75%;\n  line-height: 0;\n  position: relative;\n  vertical-align: baseline;\n}\n\nsub {\n  bottom: -0.25em;\n}\n\nsup {\n  top: -0.5em;\n}\n\n/* Embedded content\n   ========================================================================== */\n\n/**\n * Add the correct display in IE 9-.\n */\n\naudio,\nvideo {\n  display: inline-block;\n}\n\n/**\n * Add the correct display in iOS 4-7.\n */\n\naudio:not([controls]) {\n  display: none;\n  height: 0;\n}\n\n/**\n * Remove the border on images inside links in IE 10-.\n */\n\nimg {\n  border-style: none;\n}\n\n/**\n * Hide the overflow in IE.\n */\n\nsvg:not(:root) {\n  overflow: hidden;\n}\n\n/* Forms\n   ========================================================================== */\n\n/**\n * 1. Change the font styles in all browsers (opinionated).\n * 2. Remove the margin in Firefox and Safari.\n */\n\nbutton,\ninput,\noptgroup,\nselect,\ntextarea {\n  font-family: sans-serif; /* 1 */\n  font-size: 100%; /* 1 */\n  line-height: 1.15; /* 1 */\n  margin: 0; /* 2 */\n}\n\n/**\n * Show the overflow in IE.\n * 1. Show the overflow in Edge.\n */\n\nbutton,\ninput { /* 1 */\n  overflow: visible;\n}\n\n/**\n * Remove the inheritance of text transform in Edge, Firefox, and IE.\n * 1. Remove the inheritance of text transform in Firefox.\n */\n\nbutton,\nselect { /* 1 */\n  text-transform: none;\n}\n\n/**\n * 1. Prevent a WebKit bug where (2) destroys native `audio` and `video`\n *    controls in Android 4.\n * 2. Correct the inability to style clickable types in iOS and Safari.\n */\n\nbutton,\nhtml [type="button"], /* 1 */\n[type="reset"],\n[type="submit"] {\n  -webkit-appearance: button; /* 2 */\n}\n\n/**\n * Remove the inner border and padding in Firefox.\n */\n\nbutton::-moz-focus-inner,\n[type="button"]::-moz-focus-inner,\n[type="reset"]::-moz-focus-inner,\n[type="submit"]::-moz-focus-inner {\n  border-style: none;\n  padding: 0;\n}\n\n/**\n * Restore the focus styles unset by the previous rule.\n */\n\nbutton:-moz-focusring,\n[type="button"]:-moz-focusring,\n[type="reset"]:-moz-focusring,\n[type="submit"]:-moz-focusring {\n  outline: 1px dotted ButtonText;\n}\n\n/**\n * Correct the padding in Firefox.\n */\n\nfieldset {\n  padding: 0.35em 0.75em 0.625em;\n}\n\n/**\n * 1. Correct the text wrapping in Edge and IE.\n * 2. Correct the color inheritance from `fieldset` elements in IE.\n * 3. Remove the padding so developers are not caught out when they zero out\n *    `fieldset` elements in all browsers.\n */\n\nlegend {\n  box-sizing: border-box; /* 1 */\n  color: inherit; /* 2 */\n  display: table; /* 1 */\n  max-width: 100%; /* 1 */\n  padding: 0; /* 3 */\n  white-space: normal; /* 1 */\n}\n\n/**\n * 1. Add the correct display in IE 9-.\n * 2. Add the correct vertical alignment in Chrome, Firefox, and Opera.\n */\n\nprogress {\n  display: inline-block; /* 1 */\n  vertical-align: baseline; /* 2 */\n}\n\n/**\n * Remove the default vertical scrollbar in IE.\n */\n\ntextarea {\n  overflow: auto;\n}\n\n/**\n * 1. Add the correct box sizing in IE 10-.\n * 2. Remove the padding in IE 10-.\n */\n\n[type="checkbox"],\n[type="radio"] {\n  box-sizing: border-box; /* 1 */\n  padding: 0; /* 2 */\n}\n\n/**\n * Correct the cursor style of increment and decrement buttons in Chrome.\n */\n\n[type="number"]::-webkit-inner-spin-button,\n[type="number"]::-webkit-outer-spin-button {\n  height: auto;\n}\n\n/**\n * 1. Correct the odd appearance in Chrome and Safari.\n * 2. Correct the outline style in Safari.\n */\n\n[type="search"] {\n  -webkit-appearance: textfield; /* 1 */\n  outline-offset: -2px; /* 2 */\n}\n\n/**\n * Remove the inner padding and cancel buttons in Chrome and Safari on macOS.\n */\n\n[type="search"]::-webkit-search-cancel-button,\n[type="search"]::-webkit-search-decoration {\n  -webkit-appearance: none;\n}\n\n/**\n * 1. Correct the inability to style clickable types in iOS and Safari.\n * 2. Change font properties to `inherit` in Safari.\n */\n\n::-webkit-file-upload-button {\n  -webkit-appearance: button; /* 1 */\n  font: inherit; /* 2 */\n}\n\n/* Interactive\n   ========================================================================== */\n\n/*\n * Add the correct display in IE 9-.\n * 1. Add the correct display in Edge, IE, and Firefox.\n */\n\ndetails, /* 1 */\nmenu {\n  display: block;\n}\n\n/*\n * Add the correct display in all browsers.\n */\n\nsummary {\n  display: list-item;\n}\n\n/* Scripting\n   ========================================================================== */\n\n/**\n * Add the correct display in IE 9-.\n */\n\ncanvas {\n  display: inline-block;\n}\n\n/**\n * Add the correct display in IE.\n */\n\ntemplate {\n  display: none;\n}\n\n/* Hidden\n   ========================================================================== */\n\n/**\n * Add the correct display in IE 10-.\n */\n\n[hidden] {\n  display: none;\n}\n','// Adapted from Blueprint CSS Framework\n//\n// Copyright (c) 2007 - 2010 blueprintcss.org\n//\n// Permission is hereby granted, free of charge, to any person\n// obtaining a copy of this software and associated documentation\n// files (the "Software"), to deal in the Software without\n// restriction, including without limitation the rights to use,\n// copy, modify, merge, publish, distribute, sublicense, and/or sell\n// copies of the Software, and to permit persons to whom the\n// Software is furnished to do so, subject to the following\n// conditions:\n//\n// The above copyright notice and this permission notice shall be\n// included in all copies or substantial portions of the Software.\n//\n// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,\n// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES\n// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND\n// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT\n// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,\n// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING\n// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR\n// OTHER DEALINGS IN THE SOFTWARE.\n\n// Default font settings.  The font-size percentage is of 16px. (0.75 * 16px = 12px) */\nhtml { font-size:100.01%; }\nbody { font-size: 75%; font-family: "Helvetica Neue", Arial, Helvetica, sans-serif; }\n\n// Headings\nh1,h2,h3,h4,h5,h6 {\n  font-weight: normal;\n  color: $primary-color;\n  img { margin: 0; }\n}\n\nh1 { font-size: 3em; line-height: 1; margin-bottom: 0.5em; }\nh2 { font-size: 2em; margin-bottom: 0.75em; }\nh3 { font-size: 1.5em; line-height: 1; margin-bottom: 1em; }\nh4 { font-size: 1.2em; line-height: 1.25; margin-bottom: 1.25em; }\nh5 { font-size: 1em; font-weight: bold; margin-bottom: 1.5em; }\nh6 { font-size: 1em; font-weight: bold; }\n\n\np {\n  margin: 0 0 1.5em;\n\n  .left     { margin: 1.5em 1.5em 1.5em 0; padding: 0; }\n  .right { margin: 1.5em 0 1.5em 1.5em; padding: 0; }\n}\n\n.left              { float: left !important; }\n.right             { float: right !important; }\n\nblockquote  { margin: 1.5em; color: #666; font-style: italic; }\nstrong,dfn    { font-weight: bold; }\nem,dfn      { font-style: italic; }\nsup, sub    { line-height: 0; }\n\nabbr,\nacronym     { border-bottom: 1px dotted #666; }\naddress     { margin: 0 0 1.5em; font-style: italic; }\ndel         { color:#666; }\n\npre         { margin: 1.5em 0; white-space: pre; }\npre,code,tt { font: 1em \'andale mono\', \'lucida console\', monospace; line-height: 1.5; }\n\n// Lists\nli ul,\nli ol       { margin: 0; }\nul, ol      { margin: 0 1.5em 1.5em 0; padding-left: 1.5em; }\n\nul          { list-style-type: disc; }\nol          { list-style-type: decimal; }\n\ndl          { margin: 0 0 1.5em 0; }\ndl dt       { font-weight: bold; }\ndd          { margin-left: 1.5em;}\n\n// Tables\ntable       { margin-bottom: 1.4em; width:100%; }\nth          { font-weight: bold; }\nthead th    { background: #c3d9ff; }\nth,td,caption { padding: 4px 10px 4px 5px; }\n\n// Helper Classes\n.small      { font-size: .8em; margin-bottom: 1.875em; line-height: 1.875em; }\n.large      { font-size: 1.2em; line-height: 2.5em; margin-bottom: 1.25em; }\n.hide       { display: none; }\n\n.quiet      { color: #666; }\n.loud       { color: #000; }\n.highlight  { background:#ff0; }\n.added      { background:#060; color: #fff; }\n.removed    { background:#900; color: #fff; }\n\n.first      { margin-left:0; padding-left:0; }\n.last       { margin-right:0; padding-right:0; }\n.top        { margin-top:0; padding-top:0; }\n.bottom     { margin-bottom:0; padding-bottom:0; }\n','/* Active Admin Print Stylesheet */\n\n// Set colors used elsewhere\n$primary-color: black;\n$text-color: black;\n\n// Normalize\n@import "./normalize";\n\n// Partials\n@import "./typography";\n\nbody {\n  font-family: Helvetica, Arial, sans-serif;\n  line-height: 150%;\n  font-size: 72%;\n  background: #fff;\n  width: 99%;\n  margin: 0;\n  padding: .5%;\n  color: $text-color;\n}\n\na {\n  color: $text-color;\n  text-decoration: none;\n}\n\nh3 {\n  font-weight: bold;\n  margin-bottom: .5em;\n}\n\n// Header\n#header {\n  float: left;\n\n  #tabs, .tabs, #utility_nav {\n    display: none;\n  }\n\n  h1{\n    font-weight: bold;\n  }\n}\n\n.flashes {\n  display: none;\n}\n\n#title_bar {\n  float: right;\n\n  h2 {\n    line-height: 2em;\n    margin: 0;\n  }\n\n  .breadcrumb, #titlebar_right {\n    display: none;\n  }\n}\n\n// Content\n#active_admin_content {\n  border-top: thick solid black;\n  clear: both;\n  margin-top: 2em;\n  padding-top: 3em;\n}\n\n// Footer\n#footer {\n  display: none;\n}\n\n// Tables\n.table_tools {\n  ul {\n    padding: 0;\n    margin: 0;\n    list-style-type: none;\n\n    li {\n      display: none;\n      padding: 0;\n      margin-bottom: 1em;\n\n      &.scope.selected, &.index.selected {\n        display: block;\n\n        &:before {\n          content: "Showing ";\n        }\n\n        a {\n          font-weight: bold;\n        }\n\n        span {\n          display: inline-block;\n          font-weight: normal;\n          font-size: .9em;\n        }\n      }\n    }\n\n  }\n}\n\ntable {\n  margin-bottom: 1.5em;\n  text-align: left;\n  width: 100%;\n\n  thead {\n    display: table-header-group;\n\n    th {\n      background: none;\n      border-bottom: medium solid black;\n      font-weight: bold;\n\n      a{\n        text-decoration: none;\n      }\n    }\n  }\n\n  th, td {\n    padding: .5em 1em;\n\n    .member_link {\n      display: none;\n    }\n  }\n\n  td {\n    border-bottom: thin solid black;\n  }\n\n  tr{\n    page-break-inside: avoid;\n  }\n}\n\n// Index\n#index_footer, .pagination_information {\n  display: none;\n}\n\n.index_grid {\n  td {\n    border: none;\n    text-align: center;\n    vertical-align: middle;\n\n    img {\n      max-width: 1in;\n    }\n  }\n}\n\n// Show\n.panel {\n  border-bottom: thick solid #ccc;\n  margin-bottom: 3em;\n  padding-bottom: 2em;\n  page-break-inside: avoid;\n\n  &:last-child {\n    border-bottom: none;\n  }\n}\n\n.comments {\n  form {\n    display: none;\n  }\n\n  .active_admin_comment {\n    border-top: thin solid black;\n    padding-top: 1em;\n\n    .active_admin_comment_meta {\n      h4 {\n        font-size: 1em;\n        font-weight: bold;\n        float: left;\n        margin-right: .5em;\n        margin-bottom: 0;\n      }\n\n      span {\n        font-size: .9em;\n        font-style: italic;\n        vertical-align: top;\n      }\n    }\n\n    .active_admin_comment_body {\n      clear: both;\n      margin-bottom: 1em;\n    }\n  }\n}\n\n\n// Attribute Tables\n.attributes_table {\n  border-top: medium solid black;\n\n  th {\n    border-bottom: thin solid black;\n    vertical-align: top;\n\n    &:after {\n      content: \':\';\n    }\n  }\n\n  td {\n    img {\n      max-height: 4in;\n      max-width: 6in;\n    }\n  }\n}\n\n// Sidebars\n#filters_sidebar_section {\n  display: none;\n}\n\n// Forms\nform {\n  fieldset {\n    border-top: thick solid #ccc;\n    padding-top: 2em;\n    margin-bottom: 2em;\n\n    &:last-child {\n      border-bottom: none;\n    }\n  }\n\n  .buttons, abbr {\n    display: none;\n  }\n  ol {\n    list-style-type: none;\n    padding: 0;\n    margin: 0;\n\n    li{\n      border-top: thin solid black;\n      margin: 0;\n      padding: 1em 0;\n      overflow: hidden;\n\n      &.password, &.hidden {\n        display: none;\n      }\n\n      label {\n        font-weight: bold;\n        float: left;\n        width: 20%;\n      }\n\n      input, textarea, select {\n        background: none;\n        border: 0;\n        font: Arial, Helvetica, sans-serif;\n      }\n\n      input[type=file] {\n        display: none;\n      }\n\n    }\n  }\n}\n\n.unsupported_browser {\n  display: none;\n}\n']}]),n.exports=e}});
//# sourceMappingURL=print-eeab12967793e200e347.js.map