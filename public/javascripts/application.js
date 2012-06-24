if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.Scene = (function($) {
  var initPaging = function() {
    $('a[data-remote]').live('ajax:beforeSend', function(e, xhr, status) {
      xhr.setRequestHeader("page", $(this).data("page"));
    });

    $('a[data-remote]').live('ajax:complete', function(e, xhr, status) {
      if (xhr.responseText.trim().length > 0) {
        html = $(xhr.responseText);
        console.log(html);
        if ($(this).data("replace-id")) {
          replaceId = $(this).data("replace-id");
          $('#' + replaceId).replaceWith(html);
        } else {
          id = $(this).data("append-id");
          $('#' + id).append(html);
          var newPage = parseInt($(this).data("page")) + 1;
          $(this).data("page", newPage);
        }
      } else {
        $(this).hide();
      }
    });
  };

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
    $("#team_selector").chosen();
    initPaging();
  };

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.Scene.init();
});
