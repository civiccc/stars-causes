if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.Scene = (function($) {
  var initPaging = function() {
    $('a[data-remote]').live('ajax:beforeSend', function(e, xhr, status) {
      xhr.setRequestHeader("page", $(this).data("page"));
    });

    $('a[data-remote]').live('ajax:complete', function(e, xhr, status) {
      if (xhr.responseText.trim().length > 0) {
        html = $(xhr.responseText);
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

  var initStarChooser = function() {
    $("#star_chooser").dialog({width: 580, autoOpen: false, closeText: ''});
    $("#selected_star").click(function() {
      $("#star_chooser").dialog('open');
    });
    $(".star_image_container").click(function() {
      $(".star_image_container.selected").removeClass("selected");
      var id = $(this).data("label");
      $(this).addClass("selected");
      $("#" + id).attr("checked", true);
    });
    $("#confirm_star_selection").click(function(e) {
      e.preventDefault();
      var input = $("input:checked[name=star_type]");
      $("#selected_star_title").html(input.data('title'));
      $("#selected_star_image").attr("src", input.data('image-path'));
      $("#star_star_type").val(input.val());
      $("#star_chooser").dialog('close');
    })
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
    initStarChooser();
  };

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.Scene.init();
});
