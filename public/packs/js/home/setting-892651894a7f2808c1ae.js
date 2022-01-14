/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/home/setting.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/home/setting.js":
/*!**********************************************!*\
  !*** ./app/javascript/packs/home/setting.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

particlesJS('hoge', {
  "particles": {
    //--シェイプの設定----------
    "number": {
      "value": 80,
      //シェイプの数
      "density": {
        "enable": true,
        //シェイプの密集度を変更するか否か
        "value_area": 200 //シェイプの密集度

      }
    },
    "shape": {
      "type": "circle",
      //シェイプの形（circle:丸、edge:四角、triangle:三角、polygon:多角形、star:星型、image:画像）
      "stroke": {
        "width": 0,
        //シェイプの外線の太さ
        "color": "#ffcc00" //シェイプの外線の色

      },
      //typeをpolygonにした時の設定
      "polygon": {
        "nb_sides": 5 //多角形の角の数

      },
      //typeをimageにした時の設定
      "image": {
        "src": "images/hoge.png",
        "width": 100,
        "height": 100
      }
    },
    "color": {
      "value": "#ffffff" //シェイプの色

    },
    "opacity": {
      "value": 1,
      //シェイプの透明度
      "random": false,
      //シェイプの透明度をランダムにするか否か
      "anim": {
        "enable": false,
        //シェイプの透明度をアニメーションさせるか否か
        "speed": 10,
        //アニメーションのスピード
        "opacity_min": 0.1,
        //透明度の最小値
        "sync": false //全てのシェイプを同時にアニメーションさせるか否か

      }
    },
    "size": {
      "value": 5,
      //シェイプの大きさ
      "random": true,
      //シェイプの大きさをランダムにするか否か
      "anim": {
        "enable": false,
        //シェイプの大きさをアニメーションさせるか否か
        "speed": 40,
        //アニメーションのスピード
        "size_min": 0.1,
        //大きさの最小値
        "sync": false //全てのシェイプを同時にアニメーションさせるか否か

      }
    },
    //--------------------
    //--線の設定----------
    "line_linked": {
      "enable": true,
      //線を表示するか否か
      "distance": 150,
      //線をつなぐシェイプの間隔
      "color": "#ffffff",
      //線の色
      "opacity": 0.4,
      //線の透明度
      "width": 1 //線の太さ

    },
    //--------------------
    //--動きの設定----------
    "move": {
      "speed": 10,
      //シェイプの動くスピード
      "straight": false,
      //個々のシェイプの動きを止めるか否か
      "direction": "none",
      //エリア全体の動き(none、top、top-right、right、bottom-right、bottom、bottom-left、left、top-leftより選択)
      "out_mode": "out" //エリア外に出たシェイプの動き(out、bounceより選択)

    } //--------------------

  },
  "interactivity": {
    "detect_on": "canvas",
    "events": {
      //--マウスオーバー時の処理----------
      "onhover": {
        "enable": true,
        //マウスオーバーが有効か否か
        "mode": "repulse" //マウスオーバー時に発動する動き(下記modes内のgrab、repulse、bubbleより選択)

      },
      //--------------------
      //--クリック時の処理----------
      "onclick": {
        "enable": true,
        //クリックが有効か否か
        "mode": "push" //クリック時に発動する動き(下記modes内のgrab、repulse、bubble、push、removeより選択)

      } //--------------------

    },
    "modes": {
      //--カーソルとシェイプの間に線が表示される----------
      "grab": {
        "distance": 400,
        //カーソルからの反応距離
        "line_linked": {
          "opacity": 1 //線の透明度

        }
      },
      //--------------------
      //--シェイプがカーソルから逃げる----------
      "repulse": {
        "distance": 200 //カーソルからの反応距離

      },
      //--------------------
      //--シェイプが膨らむ----------
      "bubble": {
        "distance": 400,
        //カーソルからの反応距離
        "size": 40,
        //シェイプの膨らむ大きさ
        "opacity": 8,
        //膨らむシェイプの透明度
        "duration": 2,
        //膨らむシェイプの持続時間(onclick時のみ)
        "speed": 3 //膨らむシェイプの速度(onclick時のみ)

      },
      //--------------------
      //--シェイプが増える----------
      "push": {
        "particles_nb": 4 //増えるシェイプの数

      },
      //--------------------
      //--シェイプが減る----------
      "remove": {
        "particles_nb": 2 //減るシェイプの数

      } //--------------------

    }
  },
  "retina_detect": true,
  //Retina Displayを対応するか否か
  "resize": true //canvasのサイズ変更にわせて拡大縮小するか否か

});

/***/ })

/******/ });
//# sourceMappingURL=setting-892651894a7f2808c1ae.js.map