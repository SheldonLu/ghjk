var handler = null;
// 默认第一页数据已经加载，从第二页开始
var page = 1;
var isLoading = false;
var getURL = 'http://localhost:3000/articles/hot'

// Prepare layout options.
var options = {
  autoResize: true, // This will auto-update the layout when the browser window is resized.
  container: $('#tiles'), // Optional, used for some extra CSS styling
  offset: 20 // Optional, the distance between grid items
  // itemWidth: 400 // Optional, the width of a grid item
};

/**
 * When scrolled all the way to the bottom, add more tiles.
 */
function onScroll(event) {
  // Only check when we're not still waiting for data.
  if(!isLoading) {
    // Check if we're within 100 pixels of the bottom edge of the broser window.
    var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
    if(closeToBottom) {
      loadData();
    }
  }
};

/**
 * Refreshes the layout.
 */
function applyLayout() {
  // Clear our previous layout handler.
  if(handler) handler.wookmarkClear();
  
  // Create a new layout handler.
  handler = $('#tiles li');
  handler.wookmark(options);
};

/**
 * Loads data from the API.
 */
function loadData() {
  isLoading = true;
  $('#loaderCircle').show();
  
  $.ajax({
    url: getURL,
    dataType: 'html',
    data: {page: page}, // Page parameter to make sure we load new data
    success: onLoadData
  });
};

var flag = true;

/**
 * Receives data from the API, creates HTML for images and updates the layout
 */
function onLoadData(data) {
  isLoading = false;
  $('#loaderCircle').hide();
  
  // Increment page index for future calls.
  page++;

  // Add image HTML to the page.
  $('#tiles').append(data);
  
  // Apply layout.
  applyLayout();
  if(flag) {
    $("abbr.timeago").timeago();
//    $(".itemAttr .item_replay").live('click',Article.reply($(this).data("id")));
    $('.itemInfo .like').live({
       mouseenter: function(){
         $(this).addClass("like_hover");
         $(this).find("span").html("+1");
       },
       mouseleave: function(){
         $(this).removeClass("like_hover");
         $(this).find("span").html("喜欢");
       }
     });
    flag = false;
  }
};

$(document).ready(new function() {
  // Capture scroll event.
  $(document).bind('scroll', onScroll);
  
  // Load first data from the API.
  loadData();
});