if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.Scene = (function($) {
  var init = function() {
    $("#stars, #logo").scrollingParallax({
      bgHeight: '100%',
      bgWidth: '100%',
      staticSpeed: 0.1
    });
    $("#flash .close_link").click(function(e) {
      e.preventDefault();
      $("#flash").hide();
    })
  };
  
  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.Scene.init();
});
