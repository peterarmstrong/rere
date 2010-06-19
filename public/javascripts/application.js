$(window).load(function () {
	$("#sign_up input").bind({
		  focusin: function(){
          $(this).css("border", "1px solid black");
      },
      focusout: function(){
          $(this).css("border", "1px solid #9a9a9a");
      }
	});
    $("#sign_up code").toggle(
        function () {
            $(this).css("height","15em");
        },
        function () {
            $(this).css("height","");
        }
    );
});

(function($){
    $.fn.hintedInput = function(hint) {
        this.each(function() {
            $.extend(this,{
                "show_hint":function(){
                    $(this).val(hint).css("color","#9a9a9a");
                    $(this).parent("form").find(".submit").hide();
                    $(this).removeData("changed");
                },
                "for_input":function(){
                    $(this).css("color","#000");
                    $(this).parent("form").find(".submit").show();
                },
                "no_input":function(){
                    return $(this).data("changed") == undefined || $.trim($(this).val()) == ""
                }
            }); // extend
            this.show_hint(); // initial state is "hinted"
        }); // each

        this.bind({
            focusin: function(){
                if(this.no_input()) { $(this).val("") }
                this.for_input();
            },
            keypress: function() {
                $(this).data("changed",true);
            },
            focusout: function(){
                if(this.no_input()) { this.show_hint(); }
            },
        });
        this.autoResize();
        return this;
    }
})(jQuery);

$(window).load(function () {
    $("#share_prompt textarea").hintedInput("Say something or ask a question...");
    $(".comments textarea").hintedInput("share something...");

    $(".comments form").bind({
        "ajax:success":function(e,data,status,xhr) {
            var input = $(this).find("textarea[name]").each(function(){this.show_hint()});
        },
        "ajax:failure":function(e,xhr,status,error) {
            alert("oops, something went wrong");
        }
    });
});
