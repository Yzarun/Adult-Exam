
var elemIsExist = function(elem) {
    	if($(elem).length > 0) return true;
    	else return false;
    };
var loginTips = function() {
	layer.confirm("你还没有登录，请先登录",{icon:2,title:"提示",closeBtn:0,btn:['确定']},function() {top.location.href= "back_login.jsp";});
};

var App = function () {

	var currentPage = ''; // current page
	var collapsed = false; //sidebar collapsed
	var is_mobile = false; //is screen mobile?
	var is_mini_menu = false; //is mini-menu activated
	var is_fixed_header = false; //is fixed header activated
	var responsiveFunctions = []; //responsive function holder
	
	/*-----------------------------------------------------------------------------------*/
	/*	Runs callback functions set by App.addResponsiveFunction()
	/*-----------------------------------------------------------------------------------*/
    var runResponsiveFunctions = function () {
        // reinitialize other subscribed elements
        for (var i in responsiveFunctions) {
            var each = responsiveFunctions[i];
            each.call();
        }
    }
	/*-----------------------------------------------------------------------------------*/
	/*	To get the correct viewport width based on  http://andylangton.co.uk/articles/javascript/get-viewport-size-javascript/
	/*-----------------------------------------------------------------------------------*/
    var getViewPort = function () {
        var e = window, a = 'inner';
        if (!('innerWidth' in window)) {
            a = 'client';
            e = document.documentElement || document.body;
        }
        return {
            width: e[a + 'Width'],
            height: e[a + 'Height']
        };
    };
	/*-----------------------------------------------------------------------------------*/
	/*	Check layout size
	/*-----------------------------------------------------------------------------------*/
	var checkLayout = function() {
		//Check if sidebar has mini-menu
		is_mini_menu = $('#sidebar').hasClass('mini-menu');
		//Check if fixed header is activated
		is_fixed_header = $('#header').hasClass('navbar-fixed-top');
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Sidebar & Main Content size match
	/*-----------------------------------------------------------------------------------*/
	var handleSidebarAndContentHeight = function () {
        var content = $('#content');
        var sidebar = $('#sidebar');
        var body = $('body');
        var height;

        if (body.hasClass('sidebar-fixed')) {
            height = $(window).height() - $('#header').height() + 1;
        } else {
            height = sidebar.height() + 20;
        }
        if (height >= content.height()) {
            content.attr('style', 'min-height:' + height + 'px !important');
        }
    };
	/*-----------------------------------------------------------------------------------*/
	/*	Sidebar
	/*-----------------------------------------------------------------------------------*/
	var handleSidebar = function () {
	jQuery('.sidebar-menu .has-sub > a').click(function () {
            var last = jQuery('.has-sub.open', $('.sidebar-menu'));
            last.removeClass("open");
            jQuery('.arrow', last).removeClass("open");
            jQuery('.sub', last).slideUp(200);
            
			var thisElement = $(this);
			var slideOffeset = -200;
            var slideSpeed = 200;
			
            var sub = jQuery(this).next();
            if (sub.is(":visible")) {
                jQuery('.arrow', jQuery(this)).removeClass("open");
                jQuery(this).parent().removeClass("open");
				sub.slideUp(slideSpeed, function () {
					if ($('#sidebar').hasClass('sidebar-fixed') == false) {
						App.scrollTo(thisElement, slideOffeset);
					}
					handleSidebarAndContentHeight();
                });
            } else {
                jQuery('.arrow', jQuery(this)).addClass("open");
                jQuery(this).parent().addClass("open");
                sub.slideDown(slideSpeed, function () {
					if ($('#sidebar').hasClass('sidebar-fixed') == false) {
						App.scrollTo(thisElement, slideOffeset);
					}
					handleSidebarAndContentHeight();
                });
            }
        });
		
	// Handle sub-sub menus
	jQuery('.sidebar-menu .has-sub .sub .has-sub-sub > a').click(function () {
            var last = jQuery('.has-sub-sub.open', $('.sidebar-menu'));
            last.removeClass("open");
            jQuery('.arrow', last).removeClass("open");
            jQuery('.sub', last).slideUp(200);
                
            var sub = jQuery(this).next();
            if (sub.is(":visible")) {
                jQuery('.arrow', jQuery(this)).removeClass("open");
                jQuery(this).parent().removeClass("open");
                sub.slideUp(200);
            } else {
                jQuery('.arrow', jQuery(this)).addClass("open");
                jQuery(this).parent().addClass("open");
                sub.slideDown(200);
            }
        });
	};
	
	/*-----------------------------------------------------------------------------------*/
	/*	Collapse Sidebar Programatically
	/*-----------------------------------------------------------------------------------*/
	var collapseSidebar = function () {
		var iconElem = document.getElementById("sidebar-collapse").querySelector('[class*="fa-"]');
		var iconLeft = iconElem.getAttribute("data-icon1");
		var iconRight = iconElem.getAttribute("data-icon2");
		/* For Navbar */
		jQuery('.navbar-brand').addClass("mini-menu");
		/* For sidebar */
		jQuery('#sidebar').addClass("mini-menu");
		jQuery('#main-content').addClass("margin-left-50");
		jQuery('.sidebar-collapse i').removeClass(iconLeft);
		jQuery('.sidebar-collapse i').addClass(iconRight);
		/* Remove placeholder from Search Bar */
		jQuery('.search').attr('placeholder', '');
		collapsed = true;
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Responsive Sidebar Collapse
	/*-----------------------------------------------------------------------------------*/
	var responsiveSidebar = function () {
		//Handle sidebar collapse on screen width
		var width = $(window).width();
		if ( width < 768 ) {
			is_mobile = true;
			//Hide the sidebar completely
			jQuery('#main-content').addClass("margin-left-0");
		}
		else {
			is_mobile = false;
			//Show the sidebar completely
			jQuery('#main-content').removeClass("margin-left-0");
			var menu = $('.sidebar');
			if (menu.parent('.slimScrollDiv').size() === 1) { // destroy existing instance before resizing
				menu.slimScroll({
					destroy: true
				});
				menu.removeAttr('style');
				$('#sidebar').removeAttr('style');
			}
		}
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Sidebar Collapse
	/*-----------------------------------------------------------------------------------*/
	var handleSidebarCollapse = function () {
		var viewport = getViewPort();
		//Handle sidebar collapse on user interaction
		jQuery('.sidebar-collapse').click(function () {
			//Handle mobile sidebar toggle
			if(is_mobile && !(is_mini_menu)){
				//If sidebar is collapsed
				if(collapsed){
					jQuery('body').removeClass("slidebar");
					jQuery('.sidebar').removeClass("sidebar-fixed");
					//Add fixed top nav if exists
					if(is_fixed_header) {
						jQuery('#header').addClass("navbar-fixed-top");
						jQuery('#main-content').addClass("margin-top-100");
					}
					collapsed = false;
				}
				else {
					jQuery('body').addClass("slidebar");
					jQuery('.sidebar').addClass("sidebar-fixed");
					//Remove fixed top nav if exists
					if(is_fixed_header) {
						jQuery('#header').removeClass("navbar-fixed-top");
						jQuery('#main-content').removeClass("margin-top-100");
					}
					collapsed = true;
					handleMobileSidebar();
				}
			}
			else { //Handle regular sidebar toggle
				var iconElem = document.getElementById("sidebar-collapse").querySelector('[class*="fa-"]');
				var iconLeft = iconElem.getAttribute("data-icon1");
				var iconRight = iconElem.getAttribute("data-icon2");
				//If sidebar is collapsed
				if(collapsed){
					/* For Navbar */
					jQuery('.navbar-brand').removeClass("mini-menu");
					/* For sidebar */
					jQuery('#sidebar').removeClass("mini-menu");
					jQuery('#main-content').removeClass("margin-left-50");
					jQuery('.sidebar-collapse i').removeClass(iconRight);
					jQuery('.sidebar-collapse i').addClass(iconLeft);
					/* Add placeholder from Search Bar */
					jQuery('.search').attr('placeholder', "Search");
					collapsed = false;
				}
				else {
					/* For Navbar */
					jQuery('.navbar-brand').addClass("mini-menu");
					/* For sidebar */
					jQuery('#sidebar').addClass("mini-menu");
					jQuery('#main-content').addClass("margin-left-50");
					jQuery('.sidebar-collapse i').removeClass(iconLeft);
					jQuery('.sidebar-collapse i').addClass(iconRight);
					/* Remove placeholder from Search Bar */
					jQuery('.search').attr('placeholder', '');
					collapsed = true;
				}
				$("#main-content").on('resize', function (e) {
					e.stopPropagation();
				});
			}
        });
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handle Fixed Sidebar on Mobile devices
	/*-----------------------------------------------------------------------------------*/
	var handleMobileSidebar = function () {
        var menu = $('.sidebar');
		if (menu.parent('.slimScrollDiv').size() === 1) { // destroy existing instance before updating the height
            menu.slimScroll({
                destroy: true
            });
            menu.removeAttr('style');
            $('#sidebar').removeAttr('style');
        }
        menu.slimScroll({
            size: '7px',
            color: '#a1b2bd',
            opacity: .3,
            height: "100%",
            allowPageScroll: false,
            disableFadeOut: false
        });
    };
	/*-----------------------------------------------------------------------------------*/
	/*	Handle Fixed Sidebar
	/*-----------------------------------------------------------------------------------*/
	var handleFixedSidebar = function () {
        var menu = $('.sidebar-menu');

        if (menu.parent('.slimScrollDiv').size() === 1) { // destroy existing instance before updating the height
            menu.slimScroll({
                destroy: true
            });
            menu.removeAttr('style');
            $('#sidebar').removeAttr('style');
        }

        if ($('.sidebar-fixed').size() === 0) {
            handleSidebarAndContentHeight();
            return;
        }

        var viewport = getViewPort();
        if (viewport.width >= 992) {
            var sidebarHeight = $(window).height() - $('#header').height() + 1;

            menu.slimScroll({
                size: '7px',
                color: '#a1b2bd',
                opacity: .3,
                height: sidebarHeight,
                allowPageScroll: false,
                disableFadeOut: false
            });
            handleSidebarAndContentHeight();
        }
    };
	/*-----------------------------------------------------------------------------------*/
	/*	Windows Resize function
	/*-----------------------------------------------------------------------------------*/
	jQuery(window).resize(function() {
		setTimeout(function () {
			checkLayout();
			handleSidebarAndContentHeight();
			responsiveSidebar();
			handleFixedSidebar();
			handleNavbarFixedTop();
			runResponsiveFunctions(); 
		}, 50); // wait 50ms until window resize finishes.
	});
	/*-----------------------------------------------------------------------------------*/
	/*	Date Range Picker
	/*-----------------------------------------------------------------------------------*/
	var handleDateTimePickers = function () {

        $('#reportrange').daterangepicker(
            {
               startDate: moment().subtract('days', 29),
               endDate: moment(),
               minDate: '2012-01-01',
               maxDate: '2114-12-31',
               dateLimit: { days: 60 },
               showDropdowns: true,
               showWeekNumbers: true,
               timePicker: false,
               timePickerIncrement: 1,
               timePicker12Hour: true,
               ranges: {
                  'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
                  'Last 30 Days': [moment().subtract('days', 29), moment()],
                  'This Month': [moment().startOf('month'), moment().endOf('month')]
               },
               opens: 'left',
               buttonClasses: ['btn btn-default'],
               applyClass: 'btn-small btn-primary',
               cancelClass: 'btn-small',
               format: 'YYYY-MM-DD',
               separator: ' to ',
               locale: {
                   applyLabel: 'Submit',
                   fromLabel: 'From',
                   toLabel: 'To',
                   customRangeLabel: 'Custom Range',
                   daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr','Sa'],
                   monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                   firstDay: 1
               }
            },
            function(start, end) {
             console.log("Callback has been called!");
             $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            }
         );
         //Set the initial state of the picker label
         $('#reportrange span').html('Custom');
    };
	
	/*-----------------------------------------------------------------------------------*/
	/*	Team View
	/*-----------------------------------------------------------------------------------*/
	var handleTeamView = function () {
		c();
		$(".team-status-toggle").click(function (y) {
            y.preventDefault();
            w(this);
            $(this).parent().toggleClass("open");
            var z = x(this);
            $(z).slideToggle(200, function () {
                $(this).toggleClass("open");
            });
        });
        $("body").click(function (z) {
            var y = z.target.className.split(" ");
            if ($.inArray("team-status", y) == -1 && $.inArray("team-status-toggle", y) == -1 && $(z.target).parents().index($(".team-status")) == -1 && $(z.target).parents(".team-status-toggle").length == 0) {
                w();
            }
        });
        $(".team-status #teamslider").each(function () {
            $(this).slimScrollHorizontal({
                width: "100%",
                alwaysVisible: true,
                color: "#fff",
                opacity: "0.5",
                size: "5px"
            });
        });
        var w = function (y) {
            $(".team-status").each(function () {
                var z = $(this);
                if (z.is(":visible")) {
                    var A = x(y);
                    if (A != ("#" + z.attr("id"))) {
                        $(this).slideUp(200, function () {
                            $(this).toggleClass("open");
                            $(".team-status-toggle").each(function () {
                                var B = x(this);
                                if (B == ("#" + z.attr("id"))) {
                                    $(this).parent().removeClass("open");
                                }
                            });
                        });
                    }
                }
            });
        };
        var x = function (y) {
            var z = $(y).data("teamStatus");
            if (typeof z == "undefined") {
                z = "#team-status";
            }
            return z;
        };
	};
	var c = function () {
        $(".team-status").each(function () {
            var x = $(this);
            x.css("position", "absolute").css("margin-top", "-1000px").show();
            var w = 0;
            $("ul li", this).each(function () {
                w += $(this).outerWidth(true) + 15;
            });
            x.css("position", "relative").css("margin-top", "0").hide();
            $("ul", this).width(w);
        });
    };
	
	/*-----------------------------------------------------------------------------------*/
	/*	Homepage tooltips
	/*-----------------------------------------------------------------------------------*/
	var handleHomePageTooltips = function () {
		//On Hover
		//Default tooltip (Top)
		$('.tip').tooltip();
		//Bottom tooltip
		$('.tip-bottom').tooltip({
			placement : 'bottom'
		});
		//Left tooltip
		$('.tip-left').tooltip({
			placement : 'left'
		});
		//Right tooltip
		$('.tip-right').tooltip({
			placement : 'right'
		});
		//On Focus
		//Default tooltip (Top)
		$('.tip-focus').tooltip({
			trigger: 'focus'
		});
	};
	
	/*-----------------------------------------------------------------------------------*/
	/* Box tools
	/*-----------------------------------------------------------------------------------*/
	var handleBoxTools = function () {
		//Collapse
		jQuery('.box .tools .collapse, .box .tools .expand').click(function () {
            var el = jQuery(this).parents(".box").children(".box-body");
            if (jQuery(this).hasClass("collapse")) {
				jQuery(this).removeClass("collapse").addClass("expand");
                var i = jQuery(this).children(".fa-chevron-up");
				i.removeClass("fa-chevron-up").addClass("fa-chevron-down");
                el.slideUp(200);
            } else {
				jQuery(this).removeClass("expand").addClass("collapse");
                var i = jQuery(this).children(".fa-chevron-down");
				i.removeClass("fa-chevron-down").addClass("fa-chevron-up");
                el.slideDown(200);
            }
        });
		
		/* Close */
		jQuery('.box .tools a.remove').click(function () {
            var removable = jQuery(this).parents(".box");
            if (removable.next().hasClass('box') || removable.prev().hasClass('box')) {
                jQuery(this).parents(".box").remove();
            } else {
                jQuery(this).parents(".box").parent().remove();
            }
        });
		
		/* Reload */
		jQuery('.box .tools a.reload').click(function () {
            var el = jQuery(this).parents(".box");
            App.blockUI(el);
            window.setTimeout(function () {
                App.unblockUI(el);
            }, 1000);
        });
	};
	/*-----------------------------------------------------------------------------------*/
	/*	SlimScroll
	/*-----------------------------------------------------------------------------------*/
	var handleSlimScrolls = function () {
        if (!jQuery().slimScroll) {
            return;
        }

        $('.scroller').each(function () {
            $(this).slimScroll({
                size: '7px',
                color: '#a1b2bd',
				height: $(this).attr("data-height"),
                alwaysVisible: ($(this).attr("data-always-visible") == "1" ? true : false),
                railVisible: ($(this).attr("data-rail-visible") == "1" ? true : false),
				railOpacity: 0.1,
                disableFadeOut: true
            });
        });
    };
	
	/*-----------------------------------------------------------------------------------*/
	/*	Bootbox alerts
	/*-----------------------------------------------------------------------------------*/
	var handleBootbox = function () {
		$(".basic-alert").click(function(){
			bootbox.alert("Hello World");
		});
		$(".confirm-dialog").click(function(){
			bootbox.confirm("Are you sure?", function(result){});
		});
		$(".multiple-buttons").click(function(){
			bootbox.dialog({
			message: "I am a custom dialog",
			title: "Custom title",
			buttons: {
				success: {
					label: "Success!",
					className: "btn-success",
					callback: function() {
					Example.show("great success");
					}
				},
				danger: {
					label: "Danger!",
					className: "btn-danger",
					callback: function() {
					Example.show("uh oh, look out!");
					}
				},
				main: {
					label: "Click ME!",
					className: "btn-primary",
					callback: function() {
					Example.show("Primary button");
					}
				}
			}
			});
		});
		$(".multiple-dialogs").click(function(){
			bootbox.alert("In 1 second a new modal will open");
			setTimeout(function() {
				bootbox.dialog({
			message: "Will you purchase this awesome theme",
			title: "Pop quiz",
			buttons: {
				success: {
					label: "Yes!",
					className: "btn-success",
					callback: function() {
						bootbox.alert("Congratulations! You made the right decision.", function(){
							$(".bootbox").modal("hide");
						});
					}
				},
				danger: {
					label: "No!",
					className: "btn-danger",
					callback: function() {
						bootbox.alert("Oops, we're sorry to hear that!", function(){
							$(".bootbox").modal("hide");
						});
						
					}
				},
				main: {
					label: "Click ME!",
					className: "btn-primary",
					callback: function() {
						bootbox.alert("Hello World", function(){
							$(".bootbox").modal("hide");
						});
					}
				}
			}
			});
			}, 1000);
		});
		$(".programmatic-close").click(function(){
			bootbox.alert("In 3 second this modal will close..");
			setTimeout(function() {
				$(".bootbox").modal("hide");
			}, 3000);
		});
		
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Popovers
	/*-----------------------------------------------------------------------------------*/
	var handlePopovers = function () {
		//Default (Right)
		$('.pop').popover();
		//Bottom 
		$('.pop-bottom').popover({
			placement : 'bottom'
		});
		//Left 
		$('.pop-left').popover({
			placement : 'left'
		});
		//Top 
		$('.pop-top').popover({
			placement : 'top'
		});
		//Trigger hover 
		$('.pop-hover').popover({
			trigger: 'hover'
		});
	};
	
	/*-----------------------------------------------------------------------------------*/
	/*	Hubspot messenger
	/*-----------------------------------------------------------------------------------*/
	var handleMessenger = function () {
		
		//Normal
		$("#normal").click(function(){
			var mytheme = $('input[name=theme]:checked').val();
			var mypos = $('input[name=position]:checked').val();
			//Set theme
			Messenger.options = {
				extraClasses: 'messenger-fixed '+mypos,
				theme: mytheme
			};
			//Call
			Messenger().post({
				message:"This is a normal notification!",
				showCloseButton: true
			});
		});
		//Interactive
		$("#interactive").click(function(){
			var mytheme = $('input[name=theme]:checked').val();
			var mypos = $('input[name=position]:checked').val();
			//Set theme
			Messenger.options = {
				extraClasses: 'messenger-fixed '+mypos,
				theme: mytheme
			}
			var msg;
			msg = Messenger().post({
			  message: 'Launching thermonuclear war...',
			  type: 'info',
			  actions: {
				cancel: {
				  label: 'cancel launch',
				  action: function() {
					return msg.update({
					  message: 'Thermonuclear war averted',
					  type: 'success',
					  showCloseButton: true,
					  actions: false
					});
				  }
				}
			  }
			});
		});
		//Timer
		$("#timer").click(function(){
			var mytheme = $('input[name=theme]:checked').val();
			var mypos = $('input[name=position]:checked').val();
			//Set theme
			Messenger.options = {
				extraClasses: 'messenger-fixed '+mypos,
				theme: mytheme
			};
			var i;
			i = 0;
			Messenger().run({
			  errorMessage: 'Error destroying alien planet',
			  successMessage: 'Alien planet destroyed!',
			  showCloseButton: true,
			  action: function(opts) {
				if (++i < 3) {
				  return opts.error({
					status: 500,
					readyState: 0,
					responseText: 0
				  });
				} else {
				  return opts.success();
				}
			  }
			});
		});
		//Prompts
		$("#prompts").click(function(){
			var mytheme = $('input[name=theme]:checked').val();
			var mypos = $('input[name=position]:checked').val();
			//Set theme
			Messenger.options = {
				extraClasses: 'messenger-fixed '+mypos,
				theme: mytheme
			}
			Messenger().run({
			  successMessage: 'Data saved.',
			  errorMessage: 'Error saving data',
			  progressMessage: 'Saving data',
			  showCloseButton: true,
			}, {
			  url: 'http://www.example.com/data'
			});
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Alerts
	/*-----------------------------------------------------------------------------------*/
	var handleAlerts = function () {
		$(".alert").alert();
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Magic Suggest
	/*-----------------------------------------------------------------------------------*/
	var handleMagicSuggest = function () {
		var jsonData = [];
            var cities = 'New York,Los Angeles,Chicago,Houston,Paris,Marseille,Toulouse,Lyon,Bordeaux,Philadelphia,Phoenix,San Antonio,San Diego,Dallas,San Jose,Jacksonville'.split(',');
            for(var i=0;i<cities.length;i++) jsonData.push({id:i,name:cities[i],status:i%2?'Already Visited':'Planned for visit',coolness:Math.floor(Math.random() * 10) + 1});
            var ms1 = $('#ms1').magicSuggest({
                data: jsonData,
                sortOrder: 'name',
                value: [0],
                selectionPosition: 'right',
                groupBy: 'status',
                maxDropHeight: 200
            });
            var ms2 = $('#ms2').magicSuggest({
				width: '80%',
                data: jsonData
            });
            var ms3 = $('#ms3').magicSuggest({
                selectionPosition: 'bottom',
                renderer: function(city){
                    return '<div>' +
                            '<div style="font-family: Arial; font-weight: bold">' + city.name + '</div>' +
                            '<div><b>Cooooolness</b>: ' + city.coolness + '</div>' +
                           '</div>';
                },
                minChars: 1,
                selectionStacked: true,
                data: jsonData
            });
            var ms4 = $('#ms4').magicSuggest({
                data: [{id:1,label:'one'}, {id:2,label:'two'}, {id:3,label:'three'}],
                displayField: 'label',
                value: [1,3]
            });
            var ms5 = $('#ms5').magicSuggest({
                width: '80%',
                data: 'marilyn@monroe.com,mother@teresa.com,john@kennedy.com,martin@luther.com,nelson@mandela.com,winston@churchill.com,bill@gates.com,muhammad@ali.com,mahatma@gandhi.com,margaret@thatcher.com,charles@gaulle.com,christopher@colombus.com,george@orwell.com,charles@darwin.com,elvis@presley.com,albert@einstein.com,paul@mccartney.com,queen@elizabeth.com,queen@victoria.com,john@keynes.com,mikhail@gorbachev.com,jawaharlal@nehru.com,leonardo@vinci.com,louis@pasteur.com,leo@tolstoy.com,pablo@picasso.com,vincent@gogh.com,franklin@roosevelt.com,john@paul.com,neil@armstrong.com,thomas@edison.com,rosa@parks.com,aung@kyi.com,lyndon@johnson.com,ludwig@beethoven.com,oprah@winfrey.com,indira@gandhi.com,eva@peron.com,benazir@bhutto.com,desmond@tutu.com,dalai@lama.com,walt@disney.com,peter@sellers.com,barack@obama.com,malcolm@x.com,richard@branson.com,jesse@owens.com,ernest@hemingway.com,john@lennon.com,henry@ford.com,haile@selassie.com,joseph@stalin.com,lord@baden.com,michael@jordon.com,george@bush.com,osama@laden.com,fidel@castro.com,oscar@wilde.com,coco@chanel.com,amelia@earhart.com,adolf@hitler.com,mary@magdalene.com,alfred@hitchcock.com,michael@jackson.com,mata@hari.com,emmeline@pankhurst.com,ronald@reagan.com,lionel@messi.com,babe@ruth.com,bob@geldof.com,leon@trotsky.com,roger@federer.com,sigmund@freud.com,woodrow@wilson.com,mao@zedong.com,katherine@hepburn.com,audrey@hepburn.com,david@beckham.com,tiger@woods.com,usain@bolt.com,bill@cosby.com,carl@lewis.com,prince@charles.com,jacqueline@onassis.com,billie@holiday.com,virginia@woolf.com,billie@king.com,kylie@minogue.com,anne@frank.com,emile@zatopek.com,lech@walesa.com,christiano@ronaldo.com,yoko@ono.com,julie@andrews.com,florence@nightingale.com,marie@curie.com,stephen@hawking.com,tim@lee.com,lady@gaga.com,lance@armstrong.com,jon@stewart.com,scarlett@johansson.com,larry@page.com,sergey@brin.com,roman@abramovich.com,rupert@murdoch.com,al@gore.com,sacha@baron.com,george@clooney.com,paul@krugman.com,jimmy@wales.com'
            });
            var ms6 = $('#ms6').magicSuggest({
                // will fetch data from options
            });
            var ms7 = $('#ms7').magicSuggest({
                data: jsonData,
                resultAsString: true,
                maxSelection: 1,
                maxSelectionRenderer: function(){}
            });
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Timeago
	/*-----------------------------------------------------------------------------------*/
	var handleTimeAgo = function () {
		jQuery(document).ready(function() {
			var curr_time = moment().format('YYYY-MM-DD HH:mm');
			var yesterday = moment().subtract('days', 1).format('MMM D, YYYY');
			$("#curr-time").html(curr_time);
			$("#curr-time").attr('title', curr_time);
			$("#curr-time").attr('data-original-title', curr_time);
			$("#yesterday").html(yesterday);
			$("#yesterday").attr('title', yesterday);
			$("#yesterday").attr('data-original-title', yesterday);
		  jQuery("abbr.timeago").timeago();
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Init Timeago
	/*-----------------------------------------------------------------------------------*/
	var initTimeAgo = function () {
		jQuery("abbr.timeago").timeago();
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Stateful buttons
	/*-----------------------------------------------------------------------------------*/
	var handleStatefulButtons = function () {
		$(document).ready(function(){
		  $("#btn-load").on("click",function(){
			var a=$(this);
			a.button("loading");
			setTimeout(function(){
			  a.button("reset");}
					   ,1500);}
						   );
		  $("#btn-load-complete").on("click",function(){
			var a=$(this);
			a.button("loading");
				setTimeout(function() {
						a.button("complete");
					}, 1500);
				});
			});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Toggle buttons
	/*-----------------------------------------------------------------------------------*/
	var handleToggle = function () {
	$('.radio1').on('switch-change', function () {
		$('.radio1').bootstrapSwitch('toggleRadioState');
		});
		// or
		$('.radio1').on('switch-change', function () {
		$('.radio1').bootstrapSwitch('toggleRadioStateAllowUncheck');
		});
		// or
		$('.radio1').on('switch-change', function () {
		$('.radio1').bootstrapSwitch('toggleRadioStateAllowUncheck', false);
		});
	}
	/*-----------------------------------------------------------------------------------*/
	/*	jQuery UI Sliders
	/*-----------------------------------------------------------------------------------*/
	var handleSliders = function () {
	  function repositionTooltip( e, ui ){$
        var div = $(ui.handle).data("bs.tooltip").$tip[0];
        var pos = $.extend({}, $(ui.handle).offset(), { width: $(ui.handle).get(0).offsetWidth,
                                                        height: $(ui.handle).get(0).offsetHeight
                  });
        
        var actualWidth = div.offsetWidth;
        
        tp = {left: pos.left + pos.width / 2 - actualWidth / 2};            
        $(div).offset(tp);
        
        $(div).find(".tooltip-inner").text( ui.value );     
	}
    
	  $("#slider").slider({ value: 15, slide: repositionTooltip, stop: repositionTooltip });
	  $("#slider .ui-slider-handle:first").tooltip( {title: $("#slider").slider("value"), trigger: "manual"}).tooltip("show");
	  
	  $("#slider-default").slider();
	  
      $("#slider-range").slider({
        range:true,min:0,max:500,values:[75,300]
      });
	  
      $("#slider-range-min").slider({
        range:"min",value:37,min:1,max:700,slide:function(a,b){
          $("#slider-range-min-amount").text("$"+b.value);}
      });
	  
      $("#slider-range-max").slider({
        range:"max",min:1,max:700,value:300,slide:function(a,b){
          $("#slider-range-max-amount").text("$"+b.value);}
      });
	  
      $("#slider-vertical-multiple > span").each(function(){
        var a=parseInt($(this).text(),10);
        $(this).empty().slider({
          value:a,range:"min",animate:true,orientation:"vertical"}
                              );}
                                                );
      $("#slider-vertical-range-min").slider({
        range:"min",value:400,min:1,max:600,orientation:"vertical"
      });
	  $("#slider-horizontal-range-min").slider({
        range:"min",value:600,min:1,max:1000
      });
	};
	/*-----------------------------------------------------------------------------------*/
	/*	jQuery UI Progress
	/*-----------------------------------------------------------------------------------*/
	var handleProgress = function () {
		$(document).ready(function(){
			jQuery.fn.anim_progressbar = function (aOptions) {
				// def values
				var iCms = 1000;
				var iMms = 60 * iCms;
				var iHms = 3600 * iCms;
				var iDms = 24 * 3600 * iCms;

				// def options
				var aDefOpts = {
					start: new Date(), // now
					finish: new Date().setTime(new Date().getTime() + 60 * iCms), // now + 60 sec
					interval: 100
				};
				var aOpts = jQuery.extend(aDefOpts, aOptions);
				var vPb = this;

				// each progress bar
				return this.each(
					function() {
						var iDuration = aOpts.finish - aOpts.start;

						// calling original progressbar
						$(vPb).children('.pbar').progressbar();

						// looping process
						var vInterval = setInterval(
							function(){
								var iLeftMs = aOpts.finish - new Date(); // left time in MS
								var iElapsedMs = new Date() - aOpts.start, // elapsed time in MS
									iDays = parseInt(iLeftMs / iDms), // elapsed days
									iHours = parseInt((iLeftMs - (iDays * iDms)) / iHms), // elapsed hours
									iMin = parseInt((iLeftMs - (iDays * iDms) - (iHours * iHms)) / iMms), // elapsed minutes
									iSec = parseInt((iLeftMs - (iDays * iDms) - (iMin * iMms) - (iHours * iHms)) / iCms), // elapsed seconds
									iPerc = (iElapsedMs > 0) ? iElapsedMs / iDuration * 100 : 0; // percentages

								// display current positions and progress
								$(vPb).children('.percent').html('<b>'+iPerc.toFixed(1)+'%</b>');
								$(vPb).children('.elapsed').html(iDays+' day '+iHours+' hr : '+iMin+' min : '+iSec+' sec remaining</b>');
								$(vPb).children('.pbar').children('.ui-progressbar-value').css('width', iPerc+'%');

								// in case of Finish
								if (iPerc >= 100) {
									clearInterval(vInterval);
									$(vPb).children('.percent').html('<b>100%</b>');
									$(vPb).children('.elapsed').html('Completed');
								}
							} ,aOpts.interval
						);
					}
				);
			};

			// default mode
			$('#progress1').anim_progressbar();

			// from second #5 till 15
			var iNow = new Date().setTime(new Date().getTime() + 5 * 1000); // now plus 5 secs
			var iEnd = new Date().setTime(new Date().getTime() + 15 * 1000); // now plus 15 secs
			$('#progress2').anim_progressbar({start: iNow, finish: iEnd, interval: 100});

			// we will just set interval of updating to 1 sec
			$('#progress3').anim_progressbar({interval: 1000});
		});

	};
	/*-----------------------------------------------------------------------------------*/
	/*	jQuery Knob
	/*-----------------------------------------------------------------------------------*/
	var handleKnobs = function () {
		$(".knob").knob({
                    change : function (value) {
                        //console.log("change : " + value);
                    },
                    release : function (value) {
                        //console.log(this.$.attr('value'));
                        console.log("release : " + value);
                    },
                    cancel : function () {
                        console.log("cancel : ", this);
                    },
                    draw : function () {

                        // "tron" case
                        if(this.$.data('skin') == 'tron') {

                            var a = this.angle(this.cv)  // Angle
                                , sa = this.startAngle          // Previous start angle
                                , sat = this.startAngle         // Start angle
                                , ea                            // Previous end angle
                                , eat = sat + a                 // End angle
                                , r = 1;

                            this.g.lineWidth = this.lineWidth;

                            this.o.cursor
                                && (sat = eat - 0.3)
                                && (eat = eat + 0.3);

                            if (this.o.displayPrevious) {
                                ea = this.startAngle + this.angle(this.v);
                                this.o.cursor
                                    && (sa = ea - 0.3)
                                    && (ea = ea + 0.3);
                                this.g.beginPath();
                                this.g.strokeStyle = this.pColor;
                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sa, ea, false);
                                this.g.stroke();
                            }

                            this.g.beginPath();
                            this.g.strokeStyle = r ? this.o.fgColor : this.fgColor ;
                            this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sat, eat, false);
                            this.g.stroke();

                            this.g.lineWidth = 2;
                            this.g.beginPath();
                            this.g.strokeStyle = this.o.fgColor;
                            this.g.arc( this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
                            this.g.stroke();

                            return false;
                        }
                    }
                });
	};
	
	/*-----------------------------------------------------------------------------------*/
	/*	Custom tabs
	/*-----------------------------------------------------------------------------------*/
	var handleCustomTabs = function () {
			var adjustMinHeight = function (y) {
				$(y).each(function () {
					var A = $($($(this).attr("href")));
					var z = $(this).parent().parent();
					if (z.height() > A.height()) {
						A.css("min-height", z.height());
					}
				});
			};
			$("body").on("click", '.nav.nav-tabs.tabs-left a[data-toggle="tab"], .nav.nav-tabs.tabs-right a[data-toggle="tab"]', function () {
				adjustMinHeight($(this));
			});
			adjustMinHeight('.nav.nav-tabs.tabs-left > li.active > a[data-toggle="tab"], .nav.nav-tabs.tabs-right > li.active > a[data-toggle="tab"]');
			if (location.hash) {
				var w = location.hash.substr(1);
				$('a[href="#' + w + '"]').click()
			}
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Fuel UX Tree
	/*-----------------------------------------------------------------------------------*/
	var handleTree = function () {
		$('#tree1').admin_tree({
			dataSource: treeDataSource ,
			multiSelect:true,
			loadingHTML:'<div class="tree-loading"><i class="fa fa-spinner fa-2x fa-spin"></i></div>',
			'open-icon' : 'fa-minus',
			'close-icon' : 'fa-plus',
			'selectable' : true,
			'selected-icon' : 'fa-check',
			'unselected-icon' : 'fa-times'
		});
		$('#tree3').admin_tree({
			dataSource: treeDataSource3 ,
			multiSelect:true,
			loadingHTML:'<div class="tree-loading"><i class="fa fa-spinner fa-2x fa-spin"></i></div>',
			'open-icon' : 'fa-minus-square',
			'close-icon' : 'fa-plus-square',
			'selectable' : true,
			'selected-icon' : 'fa-check',
			'unselected-icon' : 'fa-times'
		});
		$('#tree2').admin_tree({
			dataSource: treeDataSource2 ,
			loadingHTML:'<div class="tree-loading"><i class="fa fa-spinner fa-2x fa-spin"></i></div>',
			'open-icon' : 'fa-folder-open',
			'close-icon' : 'fa-folder',
			'selectable' : false,
			'selected-icon' : null,
			'unselected-icon' : null
		});
		
		
		//To add font awesome support
		$('.tree').find('[class*="fa-"]').addClass("fa");
	};
	
	/*-----------------------------------------------------------------------------------*/
	/*	Data Tables
	/*-----------------------------------------------------------------------------------*/
	var handleDataTables = function () {
		$('#datatable1').dataTable({
				sPaginationType: "bs_full",
			});
		$('#datatable2').dataTable({
				"sPaginationType": "bs_full",
				sDom: "<'row'<'dataTables_header clearfix'<'col-md-4'l><'col-md-8'Tf>r>>t<'row'<'dataTables_footer clearfix'<'col-md-6'i><'col-md-6'p>>>",
                oTableTools: {
                    aButtons: ["copy", "print", "csv", "xls", "pdf"],
                    sSwfPath: "js/datatables/extras/TableTools/media/swf/copy_csv_xls_pdf.swf"
                }
			});
		$('.datatable').each(function(){
			var datatable = $(this);
			// SEARCH - Add the placeholder for Search and Turn this into in-line form control
			var search_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] input');
			search_input.attr('placeholder', 'Search');
			search_input.addClass('form-control input-sm');
			// LENGTH - Inline-Form control
			var length_sel = datatable.closest('.dataTables_wrapper').find('div[id$=_length] select');
			length_sel.addClass('form-control input-sm');
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	jqGrid
	/*-----------------------------------------------------------------------------------*/
	var ajaxFileUpload = function(id, fileId, type, tabId) {
		$.ajaxFileUpload({
            url: 'uploadFile.do?type=' + type + '&id=' + id,
            secureuri: false,
            fileElementId: fileId,
            dataType: "text",
            success: function(data) {
            	var result = JSON.parse(data);
            	if(result.code == "0005" || !result.success) {
            		layer.closeAll();
            		layer.alert(result.msg,{icon:5});
            	} else $("#" + tabId).trigger("reloadGrid");
            }
		 });
	};
	var showImage = function(cellvalue, options){
		if(!cellvalue) cellvalue = "uploadfile/no_img.jpg";
		return "<img src='" + cellvalue + "' height='80' width='80' />";
	};
	var dateDataInit = function(e) {
		$(e).focus(function() {
			laydate({elem:'#'+$(e).attr('id'),format: 'YYYY-MM-DD hh:mm:ss'});
			$('#laydate_hms').show();
		});
	};
	
	var handleJqgridAbout = function () {
		jQuery("#aboutTab").jqGrid({
			jsonReader: {
				root: "list", page: "pageNum",total: "pages", records: "total",
				repeatitems: false
			},
			url: "back/about/get.do",
			datatype: "json",
			height: 300,
			loadui: "block",
			colNames: ['编号', '标题', '内容详情', '创建时间', '创建者', '图片'],
			colModel: [
					//['eq'等于,'ne不等','lt小于','le小于等于','gt大于','ge大于等于','bw'开始于,'bn'不开始于,'in'属于,'ni'不属于,'ew'结束于,'en'不结束于,'cn'包含,'nc'不包含]
		           {name:'id',index: 'id',width: 30, searchoptions:{sopt:['eq']}}, 
		           {name:'title',index: 'title',width: 80,editable: true, editrules:{required: true},searchoptions:{sopt:['cn']}}, 
		           {name:'cont',index:'cont', width: 300,sortable: false,editable: true,edittype:'textarea',search: false},
		           {name:'createTime',index: 'createTime',width: 80,searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}},//
		           {name:'managerName',index: 'managerName',width: 50,sortable: false, search: false},
		           {name:'image',index:'image',align:'center', sortable: false, search: false, editable: true, formatter:showImage, edittype:'file',editoptions:{enctype:"multipart/form-data"},formoptions:{elmsuffix:'（请上传图片文件）'}}
			],
			rowNum: 10,
			rowList: [10, 20, 30, 50],
			pager: '#aboutTabNav',
			sortname: 'id',
			viewrecords: true,
			sortorder: "asc",
			editurl: "back/about/insertUpdateDelete.do",
			caption: "学院特色列表",
			autowidth: true,
			loadError: function(xhr) {
				if(xhr.responseText == "loseSession") loginTips();
			}
		});
		jQuery("#aboutTab").jqGrid('navGrid', "#aboutTabNav", {view:true, edit: true, add:true, del: true},
				{
				recreateForm: true,
			 	reloadAfterSubmit: false,  
				afterSubmit: function(xhr, data) {
					if(xhr.responseText == "loseSession") loginTips();
					else {
						var status = xhr.responseJSON.success;
						if($("#image").val().length == 0) $("#aboutTab").trigger("reloadGrid");
						else ajaxFileUpload(data.id, 'image', 1, "aboutTab");
						return [status, status ? layer.msg("修改成功",{icon:1,time:1000}) : "修改失败"];
					}
				},closeAfterEdit: true
			},{
				reloadAfterSubmit: false,
				afterSubmit: function(xhr) {
					if(xhr.responseText == "loseSession") loginTips();
					else {
						var status = xhr.responseJSON.success;
						if($("#image").val().length == 0) $("#aboutTab").trigger("reloadGrid");
						else ajaxFileUpload(xhr.responseJSON.data, 'image', 1, "aboutTab");
						return [status, status ? layer.msg("添加成功",{icon:1,time:1000}) : "添加失败"];
					}
				},closeAfterAdd: true
			},{
				afterSubmit: function(xhr) {
					if(xhr.responseText == "loseSession") loginTips();
					else {
						var status = xhr.responseJSON.success;
						return [status, status ? layer.msg("删除成功",{icon:1,time:1000}) : "删除失败"];
					}
				}
			},{closeAfterSearch:true}
		);
		$('.navtable .ui-pg-button').tooltip({container:'body'});
	};
	var handleJqgridNotice = function () {
		jQuery("#noticeTab").jqGrid({
			jsonReader: {
				root: "list", page: "pageNum",total: "pages", records: "total",
				repeatitems: false
			},
			url: "back/notice/get.do",
			datatype: "json",
			height: 300,
			loadui: "block",
			colNames: ['编号', '标题', '内容详情', '创建时间', '创建者'],
			colModel: [
				//['eq'等于,'ne不等','lt小于','le小于等于','gt大于','ge大于等于','bw'开始于,'bn'不开始于,'in'属于,'ni'不属于,'ew'结束于,'en'不结束于,'cn'包含,'nc'不包含]
				{name:'id',index: 'id',width: 20, hidden:true, searchoptions:{sopt:['eq']}}, 
				{name:'title',index: 'title',width: 100,editable: true, editrules:{required: true},searchoptions:{sopt:['cn']}}, 
				{name:'cont',index:'cont', width: 150,sortable: false,editable: true,edittype:'textarea', search: false},
				{name:'createTime',index: 'createTime',width: 50,searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}},//
				{name:'managerName',index: 'managerName',width: 50,sortable: false, search: false}
				],
				rowNum: 10,
				rowList: [10, 20, 30, 50],
				pager: '#noticeTabNav',
				sortname: 'id',
				viewrecords: true,
				sortorder: "asc",
				editurl: "back/notice/insertUpdateDelete.do",
				caption: "公告通知列表",
				autowidth: true,
				loadError: function(xhr) {
					if(xhr.responseText == "loseSession") loginTips();
				}
		});
		jQuery("#noticeTab").jqGrid('navGrid', "#noticeTabNav", {view:true, edit: true, add:true, del: true},
				{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							return [status, status ? layer.msg("修改成功",{icon:1,time:1000}) : "修改失败"];
						}
					},closeAfterEdit: true
				},{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							return [status, status ? layer.msg("添加成功",{icon:1,time:1000}) : "添加失败"];
						}
					},closeAfterAdd: true
				},{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							return [status, status ? layer.msg("删除成功",{icon:1,time:1000}) : "删除失败"];
						}
					}
				},{closeAfterSearch:true}
		);
		$('.navtable .ui-pg-button').tooltip({container:'body'});
	};
	var handleJqgridMajor = function () {
		jQuery("#majorTab").jqGrid({
			jsonReader: {
				root: "list", page: "pageNum",total: "pages", records: "total",
				repeatitems: false
			},
			url: "back/major/get.do",
			datatype: "json",
			height: 300,
			loadui: "block",
			colNames: ['编号', '名称', '类型', '简介', '图片', '创建时间', '创建者'],
			colModel: [
					//['eq'等于,'ne不等','lt小于','le小于等于','gt大于','ge大于等于','bw'开始于,'bn'不开始于,'in'属于,'ni'不属于,'ew'结束于,'en'不结束于,'cn'包含,'nc'不包含]
		           {name: 'id',index: 'id',width: 30, hidden:false, searchoptions:{sopt:['eq']}}, 
		           {name: 'name',index: 'name',width: 80,editable: true, editrules:{required: true},searchoptions:{sopt:['cn']}}, 
		           {name: 'type',index: 'type',width: 30,editable: true, edittype:'select',editoptions:{value:'0:默　认;1:热　门;2:最　新;3:传　统'},stype:'select',searchoptions:{sopt:['eq'],value:'0:默　认;1:热　门;2:最　新;3:传　统'},formatter:function(cellvalue) {var showName="默　认";if(cellvalue == 1) showName="热　门";if(cellvalue == 2) showName="最　新";if(cellvalue == 3) showName="传　统";return showName;}}, 
		           {name: 'remark',index: 'remark',width: 150,sortable: false,editable: true,edittype:'textarea', search: false},
		           {name:'image',index:'image',align:'center', sortable: false, search: false, editable: true, formatter:showImage, edittype:'file',editoptions:{enctype:"multipart/form-data"},formoptions:{elmsuffix:'（请上传图片文件）'}},
		           {name: 'createTime',index: 'createTime',width: 50,searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}},//
		           {name: 'managerName',index: 'managerName',width: 50,sortable: false, search: false}, 
		    ],
			rowNum: 10,
			rowList: [10, 20, 30, 50],
			pager: '#majorTabNav',
			sortname: 'id',
			viewrecords: true,
			sortorder: "asc",
			editurl: "back/major/insertUpdateDelete.do",
			caption: "专业信息列表",
			autowidth: true,
			loadError: function(xhr) {
				if(xhr.responseText == "loseSession") loginTips();
			}
		});
		jQuery("#majorTab").jqGrid('navGrid', "#majorTabNav", {view:true, edit: true, add:true, del: true}, 
				{
					recreateForm: true,
					reloadAfterSubmit: false,  
					afterSubmit: function(xhr, data) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							if($("#image").val().length == 0) $("#majorTab").trigger("reloadGrid");
							else ajaxFileUpload(data.id, 'image', 2, "majorTab");
							return [status, status ? layer.msg("修改成功",{icon:1,time:1000}) : "修改失败"];
						}
					},closeAfterEdit: true
				},{
					reloadAfterSubmit: false,  
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							if($("#image").val().length == 0) $("#majorTab").trigger("reloadGrid");
							else ajaxFileUpload(xhr.responseJSON.data, 'image', 2, "majorTab");
							return [status, status ? layer.msg("添加成功",{icon:1,time:1000}) : "添加失败"];
						}
					},closeAfterAdd: true
				},{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							return [status, status ? layer.msg("删除成功",{icon:1,time:1000}) : "删除失败"];
						}
					}
				},{closeAfterSearch:true}
		);
		//jQuery("#majorTab").jqGrid('inlineNav', "#majorTabNav",{});
		/* Add tooltips */
		$('.navtable .ui-pg-button').tooltip({container:'body'});
	};
	var handleJqgridExaminee = function () {
		jQuery("#examineeTab").jqGrid({
			jsonReader: {
				root: "list", page: "pageNum",total: "pages", records: "total",
				repeatitems: false
			},
			url: "back/examinee/get.do",
			datatype: "json",
			height: 300,
			loadui: "block",
			colNames: ['编号','考试编号', '用户名', '姓名', '考试内容', '状态', '报名时间', '备注说明'],
			colModel: [
					//['eq'等于,'ne不等','lt小于','le小于等于','gt大于','ge大于等于','bw'开始于,'bn'不开始于,'in'属于,'ni'不属于,'ew'结束于,'en'不结束于,'cn'包含,'nc'不包含]
		           {name: 'id',index: 'id', hidden:true}, 
		           {name: 'examNum',index: 'examNum', width: 50, searchoptions:{sopt:['eq']}}, 
		           {name: 'username',index: 'username',width: 30, editable:false, searchoptions:{sopt:['eq']}}, 
		           {name: 'name',index: 'name',width: 30,editable: false, editrules:{required: true},searchoptions:{sopt:['cn']}}, 
		           {name: 'cont',index: 'cont',width: 80,searchoptions:{sopt:['cn']}}, 
		           {name: 'status',index: 'status',width: 50,editable: true,edittype:'select',editoptions:{value:'0:已报名;1:审核通过;2:审核不通过'},stype:'select',searchoptions:{sopt:['eq'],value:'0:已报名;1:审核通过;2:审核不通过'},formatter:function(cellvalue) {return cellvalue==0 ? "已报名" : (cellvalue==1 ? "审核通过" : "审核不通过");}}, 
		           {name: 'applyTime',index: 'applyTime',width: 50,searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}},//
		           {name: 'remark',index: 'remark',width: 150,sortable: false,editable: true, search: false}
			],
			rowNum: 10,
			rowList: [10, 20, 30, 50],
			pager: '#examineeTabNav',
			sortname: 'id',
			viewrecords: true,
			sortorder: "asc",
			editurl: "back/examinee/insertUpdateDelete.do",
			caption: "考生信息列表",
			autowidth: true,
			loadError: function(xhr) {
				if(xhr.responseText == "loseSession") loginTips();
			}
		});
		jQuery("#examineeTab").jqGrid('navGrid', "#examineeTabNav", {view:true, edit: true, add:false, del: false,
				editfunc:function(rowid) {
					var rec = $('#examineeTab').jqGrid('getRowData', rowid);
					if(rec.status != "已报名") layer.alert("该考生已审核，不能重复操作",{icon:0});
					else {
						$('#examineeTab').jqGrid('editGridRow', rowid, {
							afterSubmit: function(xhr) {
								if(xhr.responseText == "loseSession") loginTips();
								else {
									var res = xhr.responseJSON;
									return [res.success, res.success ? layer.msg(res.msg,{icon:1,time:1000}) : res.msg];
								}
							},closeAfterEdit: true
						});
					}
				}
			},{},{},{closeAfterSearch:true}
		);
		$('.navtable .ui-pg-button').tooltip({container:'body'});
	};
	var handleJqgridExam = function () {
		var majorData = $.ajax({url:"getMajors.do",async:false}).responseJSON;
		jQuery("#examTab").jqGrid({
			jsonReader: {
				root: "list", page: "pageNum",total: "pages", records: "total",
				repeatitems: false
			},
			url: "back/exam/get.do",
			datatype: "json",
			height: 300,
			loadui: "block",
			colNames: ['编号', '考试内容', '考试地点', '考试时间', '考试专业', '创建时间', '创建者'],
			colModel: [
					//['eq'等于,'ne不等','lt小于','le小于等于','gt大于','ge大于等于','bw'开始于,'bn'不开始于,'in'属于,'ni'不属于,'ew'结束于,'en'不结束于,'cn'包含,'nc'不包含]
		           {name:'id',index: 'id',width: 25, hidden:false, searchoptions:{sopt:['eq']}}, 
		           {name:'cont',index:'cont', width: 80,sortable: false,editable: true,editrules:{required: true},search: false},
		           {name:'address',index:'address', width: 80,sortable: false,editable: true,editrules:{required: true},search: false},
		           {name:'examTime',index: 'examTime',width: 60,editable: true, editrules:{required: true},editoptions:{dataInit: dateDataInit}, searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}},
		           {name:'majorId',index:'majorId', width: 50,sortable: false,editable: true, editrules:{required: true}, edittype:'select',editoptions:{value:majorData},stype:'select', searchoptions:{sopt:['eq'],value:majorData},formatter:function(cellvalue){return majorData[cellvalue];}},//},
		           {name:'createTime',index: 'createTime',width: 60,searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}},//
		           {name:'managerName',index: 'managerName',width: 30,sortable: false, search: false}
			],
			rowNum: 10,
			rowList: [10, 20, 30, 50],
			pager: '#examTabNav',
			sortname: 'id',
			viewrecords: true,
			sortorder: "asc",
			editurl: "back/exam/insertUpdateDelete.do",
			caption: "考试信息列表&nbsp;<small>（<em>除考试地点，其它信息添加后，不允许修改</em>）</small>",
			autowidth: true,
			loadError: function(xhr) {
				if(xhr.responseText == "loseSession") loginTips();
			}
		});
		jQuery("#examTab").jqGrid('navGrid', "#examTabNav", {view:true, edit: true, add:true, del: true,
					editfunc:function(rowid) {
						$('#examTab').jqGrid('editGridRow', rowid, {
							afterShowForm: function () {
								$('#examTime').attr('disabled', true);
								$('#majorId').attr('disabled', true);
							},
							afterSubmit: function(xhr) {
								if(xhr.responseText == "loseSession") loginTips();
								else {
									var status = xhr.responseJSON.success;
									return [status, status ? layer.msg("修改成功",{icon:1,time:1000}) : "修改失败"];
								}
							},closeAfterEdit: true
						});
					},
					addfunc:function(rowid) {
						$('#examTab').jqGrid('editGridRow', 'new', {
							afterShowForm: function () {
								$('#examTime').attr('disabled', false);
								$('#majorId').attr('disabled', false);
							},
							afterSubmit: function(xhr) {
								if(xhr.responseText == "loseSession") loginTips();
								else {
									var status = xhr.responseJSON.success;
									return [status, status ? layer.msg("添加成功",{icon:1,time:1000}) : "添加失败"];
								}
							},closeAfterAdd: true
						});
					}
				},{},{},{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							return [status, status ? layer.msg("删除成功",{icon:1,time:1000}) : "删除失败"];
						}
					}
				},{closeAfterSearch:true}
		);
		$('.navtable .ui-pg-button').tooltip({container:'body'});
	};
	var handleJqgridUsers0 = function () {
		jQuery("#users0Tab").jqGrid({
			jsonReader: {
				root: "list", page: "pageNum",total: "pages", records: "total",
				repeatitems: false
			},
			url: "back/users0/get.do",
			datatype: "json",
			height: 300,
			loadui: "block",
			colNames: ['编号', '用户名', '邮箱', '姓名', '性别', '出生年月', '状态', '加入时间'],
			colModel: [
					//['eq'等于,'ne不等','lt小于','le小于等于','gt大于','ge大于等于','bw'开始于,'bn'不开始于,'in'属于,'ni'不属于,'ew'结束于,'en'不结束于,'cn'包含,'nc'不包含]
			        {name: 'id',index: 'id', hidden:true}, 
					{name: 'username',index: 'username',width: 50, searchoptions:{sopt:['cn']}}, 
					{name: 'email',index: 'email',width: 50,searchoptions:{sopt:['cn']}}, 
					{name: 'name',index: 'name',width: 50, editable: true,searchoptions:{sopt:['cn']}}, 
					{name: 'gender',index: 'gender',width: 20,editable: true, edittype:'select',editoptions:{value:'1:男;0:女'},stype:'select',searchoptions:{sopt:['eq'],value:'1:男;0:女'},formatter:function(cellvalue){return cellvalue==0?"女":(cellvalue==1?"男":"未知");}}, 
					{name: 'birthdate',index: 'birthdate', width: 50, editable: true, editoptions:{dataInit: function(e) {setTimeout(function(){laydate({elem:'#'+$(e).attr('id')});},2);}}, searchoptions:{sopt:['lt','gt'],dataInit: function(e) {setTimeout(function(){laydate({elem:'#'+$(e).attr('id')});},2);}},formatter:function(cellvalue){return cellvalue ? (cellvalue.split(" "))[0] : "";}},//
					{name: 'status',index: 'status',width: 20,editable: true, editrules:{required: true},edittype:'select',editoptions:{value:'1:启用;0:禁用'},searchoptions:{sopt:['eq']},formatter:function(cellvalue){return cellvalue==1?"启用":"禁用";}}, 
					{name: 'createTime',index: 'createTime',width: 50,searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}}
		    ],
			rowNum: 10,
			rowList: [10, 20, 30, 50],
			pager: '#users0TabNav',
			sortname: 'id',
			viewrecords: true,
			sortorder: "asc",
			editurl: "back/users0/insertUpdateDelete.do",
			caption: "平台用户信息列表",
			autowidth: true,
			loadError: function(xhr) {
				if(xhr.responseText == "loseSession") loginTips();
				}
		});
		jQuery("#users0Tab").jqGrid('navGrid', "#users0TabNav", {view:true, add: false, edit: true, del:false}, 
				{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							return [status, status ? layer.msg("修改成功",{icon:1,time:1000}) : "修改失败"];
						}
					},closeAfterEdit: true
				},{closeAfterSearch:true}
		);
		$('.navtable .ui-pg-button').tooltip({container:'body'});
	};
	var handleJqgridUsers1 = function () {
		jQuery("#users1Tab").jqGrid({
			jsonReader: {
				root: "list", page: "pageNum",total: "pages", records: "total",
				repeatitems: false
			},
			url: "back/users1/get.do",
			datatype: "json",
			height: 300,
			loadui: "block",
			colNames: ['编号', '用户名', '姓名', '性别', '出生年月', '状态', '加入时间'],
			colModel: [
					//['eq'等于,'ne不等','lt小于','le小于等于','gt大于','ge大于等于','bw'开始于,'bn'不开始于,'in'属于,'ni'不属于,'ew'结束于,'en'不结束于,'cn'包含,'nc'不包含]
					{name: 'id',index: 'id',width: 20, hidden:true}, 
					{name: 'username',index: 'username',width: 50, editable: true, searchoptions:{sopt:['cn']}}, 
					{name: 'name',index: 'name',width: 50, editable: true,searchoptions:{sopt:['cn']}}, 
					{name: 'gender',index: 'gender',width: 20,editable: true, edittype:'select',editoptions:{value:'1:男;0:女'},stype:'select',searchoptions:{sopt:['eq'],value:'1:男;0:女'},formatter:function(cellvalue){return cellvalue==0?"女":(cellvalue==1?"男":"未知");}}, 
					{name: 'birthdate',index: 'birthdate', width: 50, editable: true, editoptions:{dataInit: function(e) {$(e).focus(function(){laydate({elem:'#'+$(e).attr('id'),format: 'YYYY-MM-DD'});});}}, searchoptions:{sopt:['lt','gt'],dataInit: function(e) {$(e).focus(function(){laydate({elem:'#'+$(e).attr('id'),format: 'YYYY-MM-DD'});});}},formatter:function(cellvalue){return cellvalue ? (cellvalue.split(" "))[0] : "";}},//
					{name: 'status',index: 'status',width: 20,editable: true, editrules:{required: true},edittype:'select',editoptions:{value:'1:启用;0:禁用'},searchoptions:{sopt:['eq']},formatter:function(cellvalue){return cellvalue==1?"启用":"禁用";}}, 
					{name: 'createTime',index: 'createTime',width: 50,searchoptions:{sopt:['lt','gt'],dataInit: dateDataInit}}
				],
			rowNum: 10,
			rowList: [10, 20, 30, 50],
			pager: '#users1TabNav',
			sortname: 'id',
			viewrecords: true,
			sortorder: "asc",
			editurl: "back/users1/insertUpdateDelete.do",
			caption: "后台管理员信息列表",
			autowidth: true,
			loadError: function(xhr) {
				if(xhr.responseText == "loseSession") loginTips();
			}
		});
		jQuery("#users1Tab").jqGrid('navGrid', "#users1TabNav", {view:true, edit: true, add:true, del: true}, 
				{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var result = xhr.responseJSON;
							if(result.success) {
								if(result.code == "0000") return [true, layer.msg("修改成功",{icon:1,time:1000})];
								else return [false, result.msg];
							} else return [false, "修改失败"];
						}
					},closeAfterEdit: true
				},{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var result = xhr.responseJSON;
							if(result.success) {
								if(result.code == "0000") return [true, layer.msg("添加成功",{icon:1,time:1000})];
								else return [false, result.msg];
							} else return [false, "添加失败"];
						}
					},closeAfterAdd: true
				},{
					afterSubmit: function(xhr) {
						if(xhr.responseText == "loseSession") loginTips();
						else {
							var status = xhr.responseJSON.success;
							return [status, status ? layer.msg("删除成功",{icon:1,time:1000}) : "删除失败"];
						}
					}
				},{closeAfterSearch:true}//{multipleSearch : true}
		);
		$('.navtable .ui-pg-button').tooltip({container:'body'});
	};
	
	/*-----------------------------------------------------------------------------------*/
	/*	Autosize
	/*-----------------------------------------------------------------------------------*/
	var handleAutosize = function () {
		$('textarea.autosize').autosize();
		$('textarea.autosize').addClass('textarea-transition');
	}
	/*-----------------------------------------------------------------------------------*/
	/*	Uniform
	/*-----------------------------------------------------------------------------------*/
	var handleUniform = function () {
		$(".uniform").uniform();
	}
	/*-----------------------------------------------------------------------------------*/
	/*	All Checkboxes
	/*-----------------------------------------------------------------------------------*/
	var handleAllUniform = function () {
		$("select, input[type='checkbox']").uniform();
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Easy Pie chart
	/*-----------------------------------------------------------------------------------*/
	var handleEasyPie = function () {
		//Pie 1
		$('#pie_1').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent));
			},
			lineWidth: 3,
			barColor: '#A8BC7B'
		});
		var chart1 = window.chart = $('#pie_1').data('easyPieChart');
		$('#js_update_1').on('click', function() {
			chart1.update(Math.random()*100);
		});
		
		//Pie 2
		$('#pie_2').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent));
			},
			lineWidth: 6,
			barColor: '#F0AD4E'
		});
		var chart2 = window.chart = $('#pie_2').data('easyPieChart');
		$('#js_update_2').on('click', function() {
			chart2.update(Math.random()*100);
		});
		
		//Pie 3
		$('#pie_3').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent));
			},
			lineWidth: 9,
			barColor: '#D9534F'
		});
		var chart3 = window.chart = $('#pie_3').data('easyPieChart');
		$('#js_update_3').on('click', function() {
			chart3.update(Math.random()*100);
		});
		
		//Pie 4
		$('#pie_4').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent));
			},
			lineWidth: 12,
			barColor: '#70AFC4',
			lineCap: 'butt'
		});
		var chart4 = window.chart = $('#pie_4').data('easyPieChart');
		$('#js_update_4').on('click', function() {
			chart4.update(Math.random()*100);
		});
	}
	/*-----------------------------------------------------------------------------------*/
	/*	Easy Pie chart for profile
	/*-----------------------------------------------------------------------------------*/
	var handleProfileSkillPie = function () {
		
		//Pie 1
		$('#pie_1').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent)+"%");
			},
			lineWidth: 6,
			barColor: '#F0AD4E'
		});
		var chart1 = window.chart = $('#pie_1').data('easyPieChart');
		
		//Pie 2
		$('#pie_2').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent)+"%");
			},
			lineWidth: 6,
			barColor: '#D9534F'
		});
		var chart2 = window.chart = $('#pie_2').data('easyPieChart');
		
		//Pie 3
		$('#pie_3').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent)+"%");
			},
			lineWidth: 6,
			barColor: '#70AFC4'
		});
		var chart3 = window.chart = $('#pie_3').data('easyPieChart');
	}
	/*-----------------------------------------------------------------------------------*/
	/*	Sparklines
	/*-----------------------------------------------------------------------------------*/
	var handleSparkline = function () {
		//Sparkline bar
		$(".sparkline").each(function() {
		  var barSpacing, barWidth, color, height;
		  color = $(this).attr("data-color") || "red";
		  height = "18px";
		  if ($(this).hasClass("big")) {
			barWidth = "5px";
			barSpacing = "2px";
			height = "40px";
		  }
		  return $(this).sparkline("html", {
			type: "bar",
			barColor: Theme.colors[color],
			height: height,
			barWidth: barWidth,
			barSpacing: barSpacing,
			zeroAxis: false
		  });
		});
		//Sparkline Pie
		$(".sparklinepie").each(function() {
		  var height;
		  height = "50px";
		  if ($(this).hasClass("big")) {
			height = "70px";
		  }
		  return $(this).sparkline("html", {
			type: "pie",
			height: height,
			sliceColors: [Theme.colors.blue, Theme.colors.red, Theme.colors.green, Theme.colors.orange]
		  });
		});
		//Sparkline Line
		$(".linechart").each(function() {
		  var height;
		  height = "18px";
		  if ($(this).hasClass("linechart-lg")) {
			height = "30px";
		  }
		  return $(this).sparkline("html", {
			type: "line",
			height: height,
			width: "150px",
			minSpotColor: Theme.colors.red,
			maxSpotColor: Theme.colors.green,
			spotRadius: 3,
			lineColor: Theme.colors.primary,
			fillColor: "rgba(94,135,176,0.1)",
			lineWidth: 1.2,
			highlightLineColor: Theme.colors.red,
			highlightSpotColor: Theme.colors.yellow
		  });
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handle hover in gallery
	/*-----------------------------------------------------------------------------------*/
	var handleHover = function () {
		$('.filter-content').hover(function() {
			var hoverContent = $(this).children('.hover-content');
			hoverContent.removeClass('fadeOut').addClass('animated fadeIn').show();
		}, function() {
			var hoverContent = $(this).children('.hover-content');
			hoverContent.removeClass('fadeIn').addClass('fadeOut');
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handle Colorbox
	/*-----------------------------------------------------------------------------------*/
	var handleColorbox = function () {
		$('.colorbox-button').colorbox({rel:'colorbox-button',maxWidth:'95%', maxHeight:'95%'});
		/* Colorbox resize function */
		var resizeTimer;
		function resizeColorBox()
		{
			if (resizeTimer) clearTimeout(resizeTimer);
			resizeTimer = setTimeout(function() {
					var myWidth = 442, percentageWidth = .95;
					if (jQuery('#cboxOverlay').is(':visible')) {
						$.colorbox.resize({ width: ( $(window).width() > ( myWidth+20) )? myWidth : Math.round( $(window).width()*percentageWidth ) });
						$('.cboxPhoto').css( {
							width: $('#cboxLoadedContent').innerWidth(),
							height: 'auto'
						});
						$('#cboxLoadedContent').height( $('.cboxPhoto').height() );
						$.colorbox.resize();
					}
			}, 300);
		}

		// Resize Colorbox when resizing window or changing mobile device orientation
		jQuery(window).resize(resizeColorBox);
		window.addEventListener("orientationchange", resizeColorBox, false);
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handle Backstretch
	/*-----------------------------------------------------------------------------------*/
	var handleBackstretch = function () {
		 $.backstretch([
		"img/login/1.jpg"
		, "img/login/2.jpg"
		, "img/login/3.jpg"
		, "img/login/4.jpg"
		], {duration: 3000, fade: 750});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handle Chat
	/*-----------------------------------------------------------------------------------*/
	var handleChat = function (elem) {
		var append = function() {
			//Check if chat is empty
            var input = $('.'+elem+' .chat-form input');
            var text = input.val();
            if (text.length == 0) {
                return;
            }
			
			//Get time
			var curr_time = moment().format('YYYY-MM-DD HH:mm:ss');
			
			var msg = '';
                msg +='<li class="animated fadeInLeft media">';
				msg +=  '<a class="pull-right" href="#">';
				msg +=	'<img class="media-object" alt="Generic placeholder image" src="img/chat/headshot2.jpg">';
				msg +=  '</a>';
				msg +=  '<div class="pull-right media-body chat-pop mod">';
				msg +=	'<h4 class="media-heading">You <span class="pull-left"><abbr id="curr-time" class="timeago" title="'+curr_time+'" >'+curr_time+'</abbr> <i class="fa fa-clock-o"></i></span></h4>';
				msg +=	text;
				msg +=  '</div>';
				msg +='</li>';
				
			var list = $('.'+elem+' .chat-list');
			list.append(msg);
			jQuery("abbr.timeago").timeago();
			input.val("");
            $('.'+elem+' .scroller').slimScroll({
                scrollTo: list.height()
            });
		};
		//If button is pressed
		$('.'+elem+' .chat-form .btn').click(function(e){
			e.preventDefault();
			append();
		});
		
		var input = $('.'+elem+' .chat-form input');
		//If Enter is pressed
		input.keypress(function (e) {
			if (e.which == 13) {
				append();
				return false;
			}
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handle Active Toggle
	/*-----------------------------------------------------------------------------------*/
	var handleActiveToggle = function () {
		$('#list-toggle .list-group a').click(function(){
			$('#list-toggle .list-group > a.active').removeClass('active');
			$(this).addClass('active');
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handle Box Sortable
	/*-----------------------------------------------------------------------------------*/
	var handleBoxSortable = function () {
		$('.box-container').sortable({
		    connectWith: '.box-container',
			items:'> .box',
			opacity:0.8,
			revert:true,
			forceHelperSize:true,
			placeholder: 'box-placeholder',
			forcePlaceholderSize:true,
			tolerance:'pointer'
		});
	};
	/*-----------------------------------------------------------------------------------*/
	/*	Handles the go to top button at the footer
	/*-----------------------------------------------------------------------------------*/
	var handleGoToTop = function () {
		$('.footer-tools').on('click', '.go-top', function (e) {
			App.scrollTo();
			e.preventDefault();
		});
	}; 
	/*-----------------------------------------------------------------------------------*/
	/*	Handles navbar fixed top
	/*-----------------------------------------------------------------------------------*/
	var handleNavbarFixedTop = function () {
		if(is_mobile && is_fixed_header) {
			//Manage margin top
			$('#main-content').addClass('margin-top-100');
		}
		if(!(is_mobile) && is_fixed_header){
			//Manage margin top
			$('#main-content').removeClass('margin-top-100').addClass('margin-top-50');
		}
	} 
	/*-----------------------------------------------------------------------------------*/
	/*	Handles flot charts in dashboard
	/*-----------------------------------------------------------------------------------*/
	var handleDashFlotCharts = function () {
		function chartMonth() { 
			//TODO
			//var data1 = [[0, 1.5],[1, 2], [2, 1], [3, 1.5], [4, 2.5],[5, 2], [6, 2], [7, 0.5], [8, 1], [9, 1.5], [10, 2],[11, 2.5], [12, 2], [13, 1.5], [14, 2.8], [15, 2]];
			var data1 = [];
			var data2 = [[0, 2.5],[1, 3.5], [2, 2], [3, 3], [4, 4],[5, 3.5], [6, 3.5], [7, 1], [8, 2], [9, 3], [10, 4],
					[11, 5], [12, 4], [13, 3], [14, 5]];
			var majors = ['电子信息','网络工程','市场营销','会计','学前教育','土木工程','广告设计','影音传媒','英语','数学应用','计算机教育','化学与工艺','微分子应用','专业1','专业2'];
			var plot = $.plot($("#chart-dash"), [{
				data: data2,
				label: "",
				bars: {
					show: true,
					fill: true,
					barWidth: 0.4,
					align: "center",
					lineWidth: 13
				}
			}, {
				data: data1,
				label: "Visits",
				lines: {
					show: true,
					lineWidth: 2
				},
				points: {
					show: true,
					lineWidth: 2,
					fill: true
				},
				shadowSize: 0
			}, {
				data: data1,
				label: "Visits",
				lines: {
					show: true,
					lineWidth: 1,
					fill: true,
                    fillColor: {
                        colors: [{
                                opacity: 0.05
                            }, {
                                opacity: 0.01
                            }
                        ]
                    }
				},
				points: {
					show: true,
					lineWidth: 0.5,
					fill: true
				},
				shadowSize: 0
			}], {
				grid: {
					hoverable: true,
					clickable: true,
					tickColor: "#f7f7f7",
					borderWidth: 0,
					labelMargin: 10,
					margin: {
						top: 0,
						left: 5,
						bottom: 0,
						right: 0
					}
				},
				legend: {
					show: false
				},
				colors: ["rgba(109,173,189,0.5)", "#70AFC4", "#DB5E8C"],
				
				xaxis: {
					ticks: 5,
					tickDecimals: 0,
					tickColor: "#fff"
				},
				yaxis: {
					ticks: 3,
					tickDecimals: 0
				},
			});
			function showTooltip(x, y, contents) {
                    $('<div id="tooltip">' + contents + '</div>').css({
                            position: 'absolute',
                            display: 'none',
                            top: y + 5,
                            left: x + 15,
                            border: '1px solid #333',
                            padding: '4px',
                            color: '#fff',
                            'border-radius': '3px',
                            'background-color': '#333',
                            opacity: 0.80
                        }).appendTo("body").fadeIn(200);
                }
			var previousPoint = null;
			$("#chart-dash").bind("plothover", function (event, pos, item) {
				$("#x").text(pos.x);
				$("#y").text(pos.y);
				if (item) {
					if (previousPoint != item.dataIndex) {
						previousPoint = item.dataIndex;
						$("#tooltip").remove();
						var x = item.datapoint[0],
							y = item.datapoint[1];
						showTooltip(item.pageX, item.pageY,
							item.series.label + " [" + majors[x] + "] = " + y + "人");
					}
				} else {
					$("#tooltip").remove();
					previousPoint = null;
				}
			});
		}
		
		//Select chart
        function chart_select() {
				// setup plot
				function getData(x1, x2) {

					var d = [];
					for (var i = 0; i <= 100; ++i) {
						var x = x1 + i * (x2 - x1) / 100;
						d.push([x, Math.cos(x * Math.sin(x))]);
					}

					return [
						{ label: "cos(x sin(x))", data: d }
					];
				}

				var options = {
					grid: {
						hoverable: true,
						clickable: true,
						tickColor: "#f7f7f7",
						borderWidth: 0,
						labelMargin: 10,
						margin: {
							top: 0,
							left: 5,
							bottom: 0,
							right: 0
						}
					},
					legend: {
						show: false
					},
					series: {
						lines: {
							show: true
						},
						shadowSize: 0,
						points: {
							show: true
						}
					},
					colors: ["#D9534F"],
					yaxis: {
						ticks: 10
					},
					selection: {
						mode: "xy",
						color: "#F1ADAC"
					}
				};

				var startData = getData(0, 3 * Math.PI);

				var plot = $.plot("#placeholder", startData, options);

				// Create the overview plot

				var overview = $.plot($("#overview"), startData, {
					legend: {
						show: false
					},
					series: {
						lines: {
							show: true,
							lineWidth: 1
						},
						shadowSize: 0
					},
					xaxis: {
						ticks: 4
					},
					yaxis: {
						ticks: 3,
						min: -2,
						max: 2
					},
					colors: ["#D9534F"],
					grid: {
						color: "#999",
						borderWidth: 0,
					},
					selection: {
						mode: "xy",
						color: "#F1ADAC"
					}
				});

				// now connect the two

				$("#placeholder").bind("plotselected", function (event, ranges) {

					// clamp the zooming to prevent eternal zoom

					if (ranges.xaxis.to - ranges.xaxis.from < 0.00001) {
						ranges.xaxis.to = ranges.xaxis.from + 0.00001;
					}

					if (ranges.yaxis.to - ranges.yaxis.from < 0.00001) {
						ranges.yaxis.to = ranges.yaxis.from + 0.00001;
					}

					// do the zooming

					plot = $.plot("#placeholder", getData(ranges.xaxis.from, ranges.xaxis.to),
						$.extend(true, {}, options, {
							xaxis: { min: ranges.xaxis.from, max: ranges.xaxis.to },
							yaxis: { min: ranges.yaxis.from, max: ranges.yaxis.to }
						})
					);

					// don't fire event on the overview to prevent eternal loop

					overview.setSelection(ranges, true);
				});

				$("#overview").bind("plotselected", function (event, ranges) {
					plot.setSelection(ranges);
				});

				// Add the Flot version string to the footer

				$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");

        }
		
		//Revenue chart
		function chart_revenue() {
			//TODO
			var likes = [[0, 2],[1, 2], [2, 4], [3, 3], [4, 66], [5,3], [6, 54], [7, 1], [8, 21], [9, 0], [10, 11], [11, 76], [12, 33], [13, 33], [14, 33], [15, 33]];
		
			var chartColor = $(this).parent().parent().css("color");
			
			var plot = $.plot($("#chart-revenue"),
				   [ { data: likes} ], {
					   series: {
						   label: "",
						   lines: { 
								show: true,
								lineWidth: 3, 
								fill: false
						   },
						   points: { 
								show: true, 
								lineWidth: 3,
								fill: true,
								fillColor: chartColor 
						   },	
						   shadowSize: 0
					   },
					   grid: { hoverable: true, 
							   clickable: true, 
							   tickColor: "rgba(255,255,255,.15)",
							   borderColor: "rgba(255,255,255,0)"
							 },
					   colors: ["#fff"],
					   xaxis: {
							font: {
								color: "#fff"
							},
							ticks:6, 
							tickDecimals: 0, 
							tickColor: chartColor,
					   },
					   yaxis: {
							font: {
								color: "#fff"
							},
							ticks:4, 
							tickDecimals: 0,
							autoscaleMargin: 0.000001
					   },
					   legend: {
							show: false
					   }
					 });

			function showTooltip(x, y, contents) {
				$('<div id="tooltip">' + contents + '</div>').css( {
					position: 'absolute',
					display: 'none',
					top: y + 5,
					left: x + 5,
					border: '1px solid #fdd',
					padding: '2px',
					'background-color': '#dfeffc',
					opacity: 0.80
				}).appendTo("body").fadeIn(200);
			}

			var previousPoint = null;
			$("#chart-revenue").bind("plothover", function (event, pos, item) {
				$("#x").text(pos.x);
				$("#y").text(pos.y);

					if (item) {
						if (previousPoint != item.dataIndex) {
							previousPoint = item.dataIndex;

							$("#tooltip").remove();
							var x = item.datapoint[0],
								y = item.datapoint[1];

							showTooltip(item.pageX, item.pageY,
										item.series.label + " [" + x + "天前] = " + y + "人");
						}
					}
					else {
						$("#tooltip").remove();
						previousPoint = null;
					}
			});
		}
		
		//Run the charts
		chartMonth();
		chart_select();
		chart_revenue();
		
		//Pie 1
		$('#dash_pie_1').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent)+"%");
			},
			lineWidth: 6,
			barColor: Theme.colors.purple
		});
		var chart1 = window.chart = $('#dash_pie_1').data('easyPieChart');
		//Pie 2
		$('#dash_pie_2').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent)+"%");
			},
			lineWidth: 6,
			barColor: Theme.colors.yellow
		});
		var chart2 = window.chart = $('#dash_pie_2').data('easyPieChart');
		//Pie 3
		$('#dash_pie_3').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent)+"%");
			},
			lineWidth: 6,
			barColor: Theme.colors.pink
		});
		var chart3 = window.chart = $('#dash_pie_3').data('easyPieChart');
		
		//Update the charts
		$('.js_update').on('click', function() {
			chart1.update(Math.random()*100);
			chart2.update(Math.random()*100);
			chart3.update(Math.random()*100);
			chart_revenue();
		});
	}
	/*-----------------------------------------------------------------------------------*/
	/*	Handles vertically growing bars
	/*-----------------------------------------------------------------------------------*/
	var handleVerticalChart = function () {
		if($('.verticalChart')) {		
			$('.singleBar').each(function(){				
				var percent = $(this).find('.value span').html();				
				$(this).find('.value').animate({height:percent}, 2000, function() {					
					$(this).find('span').fadeIn();				 
				});				
			});
		}
	}
	/*-----------------------------------------------------------------------------------*/
	/*	Handles theme skin switches
	/*-----------------------------------------------------------------------------------*/
	var handleThemeSkins = function () {
		// Handle theme colors
        var setSkin = function (color) {
            $('#skin-switcher').attr("href", "css/themes/" + color + ".css");
            $.cookie('skin_color', color);
        };
		$('ul.skins > li a').click(function () {
            var color = $(this).data("skin");
            setSkin(color);
        });
		
		//Check which theme skin is set
		 if ($.cookie('skin_color')) {
            setSkin($.cookie('skin_color'));
        }
	};
	
	return {

        //Initialise theme pages
        init: function () {
		
            if (App.isPage("dashboard")) {
				handleDateTimePickers(); //Function to display Date Timepicker
				handleSparkline();		//Function to display Sparkline charts
				handleDashFlotCharts(); //Function to display flot charts in dashboard
				handleChat('chat-window'); //Function to handle chat
            }
			if (App.isPage("widgets_box")) {
				handleBoxSortable(); //Function to handle Box sortables
            }
			if (App.isPage("button_icons")) {
				handleStatefulButtons(); //Function to display stateful buttons
				handleToggle(); 		//Function to handle toggle buttons
            }
			if (App.isPage("sliders_progress")) {
				handleSliders(); //Function to display sliders
				handleProgress(); //Function to display progress bars
				handleKnobs();	//Function to display knobs
            }
			if (App.isPage("treeview")) {
				handleTree();	//Function to handle tree display
			}
			if (App.isPage("dynamic_table")) {
				handleDataTables();	//Function to display data tables
			}
			if (App.isPage("jqgrid_about")) {
				handleJqgridAbout();	//Function to display jqGrid
			}
			if (App.isPage("jqgrid_notice")) {
				handleJqgridNotice();	//Function to display jqGrid
			}
			if (App.isPage("jqgrid_major")) {
				handleJqgridMajor();	//Function to display jqGrid
			}
			if (App.isPage("jqgrid_examinee")) {
				handleJqgridExaminee();	//Function to display jqGrid
			}
			if (App.isPage("jqgrid_exam")) {
				handleJqgridExam();	//Function to display jqGrid
			}
			if (App.isPage("results")) {
				
			}
			if (App.isPage("jqgrid_users0")) {
				handleJqgridUsers0();	//Function to display jqGrid
			}
			if (App.isPage("jqgrid_users1")) {
				handleJqgridUsers1();	//Function to display jqGrid
			}
			if (App.isPage("login")) {
				handleUniform();	//Function to handle uniform inputs
			}
			if (App.isPage("wizards_validations")) {
				handleUniform();	//Function to handle uniform inputs
			}
			if (App.isPage("login_bg")) {
				handleUniform();	//Function to handle uniform inputs
				handleBackstretch();	//Function to handle background images
			}
			if (App.isPage("chats")) {
				handleChat('chat-window');	//Function to handle chat
				handleChat('chat-widget');	//Function to handle chat
				initTimeAgo(); //Function to init timestamps
			}
			if (App.isPage("orders")) {
				initTimeAgo(); //Function to init timestamps
			}
			if (App.isPage("faq")) {
				handleActiveToggle(); //Function to handle active toggle
			}
			if (App.isPage("mini_sidebar")) {
				collapseSidebar();	//Function to display mini menu				
			}
			if (App.isPage("fixed_header_sidebar")) {
				handleFixedSidebar();	//Function to display fixed sidebar
			}
			if (App.isPage("dashboard")) {
				checkLayout();	//Function to check if mini menu/fixed header is activated
				handleSidebar(); //Function to display the sidebar
				handleSidebarCollapse(); //Function to hide or show sidebar
				handleSidebarAndContentHeight();  //Function to hide sidebar and main content height
				responsiveSidebar();		//Function to handle sidebar responsively
				handleTeamView(); //Function to toggle team view
				handleHomePageTooltips(); //Function to handle tooltips
				
				handleSlimScrolls(); //Function to handle slim scrolls
				handlePopovers(); //Function to handle popovers
				handleMessenger(); //Function to handle messenger
				handleAlerts(); //Function to handle alerts
				handleCustomTabs(); //Function to handle min-height of custom tabs
				handleGoToTop(); 	//Funtion to handle goto top buttons
				handleNavbarFixedTop();		//Function to check & handle if navbar is fixed top
				handleThemeSkins();		//Function to handle theme skins
			}
			handleBoxTools(); //Function to handle box tools
        },

        //Set page
        setPage: function (name) {
            currentPage = name;
        },

        isPage: function (name) {
            return currentPage == name ? true : false;
        },
		//public function to add callback a function which will be called on window resize
        addResponsiveFunction: function (func) {
            responsiveFunctions.push(func);
        },
		// wrapper function to scroll(focus) to an element
        scrollTo: function (el, offeset) {
            pos = (el && el.size() > 0) ? el.offset().top : 0;
            jQuery('html,body').animate({
                scrollTop: pos + (offeset ? offeset : 0)
            }, 'slow');
        },

        // function to scroll to the top
        scrollTop: function () {
            App.scrollTo();
        },
		// initializes uniform elements
        initUniform: function (els) {
            if (els) {
                jQuery(els).each(function () {
                    if ($(this).parents(".checker").size() == 0) {
                        $(this).show();
                        $(this).uniform();
                    }
                });
            } else {
                handleAllUniform();
            }
        },
		// wrapper function to  block element(indicate loading)
        blockUI: function (el, loaderOnTop) {
            lastBlockedUI = el;
            jQuery(el).block({
                message: '<img src="./img/loaders/12.gif" align="absmiddle">',
                css: {
                    border: 'none',
                    padding: '2px',
                    backgroundColor: 'none'
                },
                overlayCSS: {
                    backgroundColor: '#000',
                    opacity: 0.05,
                    cursor: 'wait'
                }
            });
        },

        // wrapper function to  un-block element(finish loading)
        unblockUI: function (el) {
            jQuery(el).unblock({
                onUnblock: function () {
                    jQuery(el).removeAttr("style");
                }
            });
        },
        
    };
    
}();
(function (a, b) {
    a.fn.admin_tree = function (d) {
        var c = {
            "open-icon": "fa fa-folder-open",
            "close-icon": "fa fa-folder",
            selectable: true,
            "selected-icon": "fa fa-check",
            "unselected-icon": "tree-dot"
        };
        c = a.extend({}, c, d);
        this.each(function () {
            var e = a(this);
            e.html('<div class = "tree-folder" style="display:none;">				<div class="tree-folder-header">					<i class="' + c["close-icon"] + '"></i>					<div class="tree-folder-name"></div>				</div>				<div class="tree-folder-content"></div>				<div class="tree-loader" style="display:none"></div>			</div>			<div class="tree-item" style="display:none;">				' + (c["unselected-icon"] == null ? "" : '<i class="' + c["unselected-icon"] + '"></i>') + '				<div class="tree-item-name"></div>			</div>');
            e.addClass(c.selectable == true ? "tree-selectable" : "tree-unselectable");
            e.tree(c);
        });
        return this;
    };
})(window.jQuery);


(function () {
    this.Theme = (function () {
        function Theme() {}
        Theme.colors = {
			white: "#FFFFFF",
			primary: "#5E87B0",
            red: "#D9534F",
            green: "#A8BC7B",
            blue: "#70AFC4",
            orange: "#F0AD4E",
			yellow: "#FCD76A",
            gray: "#6B787F",
            lightBlue: "#D4E5DE",
			purple: "#A696CE",
			pink: "#DB5E8C",
			dark_orange: "#F38630"
        };
        return Theme;
    })();
})(window.jQuery);