// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap';
import '../stylesheets/application';
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '@fortawesome/fontawesome-free/js/all';
import "lity"
import "cropperjs"
import "sal.js"
import "particles.js"
import "cookieconsent"


Rails.start()
ActiveStorage.start()

require("@rails/activestorage").start()
require("channels")
require("jquery")
require('jquery-ui/ui/widgets/autocomplete')
require('jquery-ui/ui/widget')
require('tag-it')
