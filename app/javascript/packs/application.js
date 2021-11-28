// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require mypages/cropper.min.js
//= require jquery-cropper.min.js
//= require activestorage
// require_tree .
//= require popper
//= require bootstrap-sprockets

import 'bootstrap';
import '../stylesheets/application';
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
//import '@fortawesome/fontawesome-free/js/all'
import '../stylesheets/application';
import '@fortawesome/fontawesome-free/js/all';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("@rails/ujs").start()
//require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// 追記
require('jquery')
import "bootstrap";
import "../stylesheets/application";

