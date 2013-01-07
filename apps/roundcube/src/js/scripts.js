// roundcube javascript namespace
var rc = document.rc || {};
rc.logdebug = false; // always as false committed, otherwise errors in internet explorer
// dirty fix for JS errors
$.fn.extend({showPassword: function(c) {  }});
$.fn.extend({inFieldLabels: function(d) {  }});
$.fn.extend({tipsy: function(e) {  }});