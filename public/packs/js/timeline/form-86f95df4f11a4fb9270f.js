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
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/timeline/form.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/timeline/form.js":
/*!***********************************************!*\
  !*** ./app/javascript/packs/timeline/form.js ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

throw new Error("Module build failed (from ./node_modules/babel-loader/lib/index.js):\nSyntaxError: /Amica/app/javascript/packs/timeline/form.js: Unexpected token, expected \",\" (3:1)\n\n  1 | window.addEventListener(\"DOMContentLoaded\", function (utterance) {\n  2 |\n> 3 | }\n    |  ^\n    at Parser._raise (/Amica/node_modules/@babel/parser/lib/index.js:541:17)\n    at Parser.raiseWithData (/Amica/node_modules/@babel/parser/lib/index.js:534:17)\n    at Parser.raise (/Amica/node_modules/@babel/parser/lib/index.js:495:17)\n    at Parser.unexpected (/Amica/node_modules/@babel/parser/lib/index.js:3580:16)\n    at Parser.expect (/Amica/node_modules/@babel/parser/lib/index.js:3554:28)\n    at Parser.parseCallExpressionArguments (/Amica/node_modules/@babel/parser/lib/index.js:11775:14)\n    at Parser.parseCoverCallAndAsyncArrowHead (/Amica/node_modules/@babel/parser/lib/index.js:11698:29)\n    at Parser.parseSubscript (/Amica/node_modules/@babel/parser/lib/index.js:11628:19)\n    at Parser.parseSubscripts (/Amica/node_modules/@babel/parser/lib/index.js:11601:19)\n    at Parser.parseExprSubscripts (/Amica/node_modules/@babel/parser/lib/index.js:11590:17)\n    at Parser.parseUpdate (/Amica/node_modules/@babel/parser/lib/index.js:11564:21)\n    at Parser.parseMaybeUnary (/Amica/node_modules/@babel/parser/lib/index.js:11539:23)\n    at Parser.parseMaybeUnaryOrPrivate (/Amica/node_modules/@babel/parser/lib/index.js:11353:61)\n    at Parser.parseExprOps (/Amica/node_modules/@babel/parser/lib/index.js:11360:23)\n    at Parser.parseMaybeConditional (/Amica/node_modules/@babel/parser/lib/index.js:11330:23)\n    at Parser.parseMaybeAssign (/Amica/node_modules/@babel/parser/lib/index.js:11290:21)\n    at Parser.parseExpressionBase (/Amica/node_modules/@babel/parser/lib/index.js:11226:23)\n    at /Amica/node_modules/@babel/parser/lib/index.js:11220:39\n    at Parser.allowInAnd (/Amica/node_modules/@babel/parser/lib/index.js:13131:16)\n    at Parser.parseExpression (/Amica/node_modules/@babel/parser/lib/index.js:11220:17)\n    at Parser.parseStatementContent (/Amica/node_modules/@babel/parser/lib/index.js:13485:23)\n    at Parser.parseStatement (/Amica/node_modules/@babel/parser/lib/index.js:13352:17)\n    at Parser.parseBlockOrModuleBlockBody (/Amica/node_modules/@babel/parser/lib/index.js:13941:25)\n    at Parser.parseBlockBody (/Amica/node_modules/@babel/parser/lib/index.js:13932:10)\n    at Parser.parseProgram (/Amica/node_modules/@babel/parser/lib/index.js:13272:10)\n    at Parser.parseTopLevel (/Amica/node_modules/@babel/parser/lib/index.js:13263:25)\n    at Parser.parse (/Amica/node_modules/@babel/parser/lib/index.js:15037:10)\n    at parse (/Amica/node_modules/@babel/parser/lib/index.js:15089:38)\n    at parser (/Amica/node_modules/@babel/core/lib/parser/index.js:52:34)\n    at parser.next (<anonymous>)");

/***/ })

/******/ });
//# sourceMappingURL=form-86f95df4f11a4fb9270f.js.map