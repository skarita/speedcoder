var Entities = require('html-entities').XmlEntities;
 
entities = new Entities();

var snippet_id = $('input[name="snippet_id"]').val();
var snippet_length = $('input[name="snippet_length"]').val();
var snippet_word_count = $('input[name="snippet_word_count"]').val();

var game_start = false;
var count = 0;
var error_count = 0;
var time_count = 0.0;
var interval = 0;

// Highlight the first character
$(".snippet-body span:first").addClass("lightblue-bg");

function $char_elem(index) {
  return $(".snippet-body span:eq(" + index + ")");
}

function char_at(index) {
  return $char_elem(index).html();
}

// Skip white spaces and find next char
function prev_char_count(count) {
  if (count === 0) {
    return count;
  }
  count--;
  var count_init = count;
  while ( char_at(count) === "&nbsp;" ) {
    count--;
    if (char_at(count) === "&nbsp;<br>" ) {
      return count;
    }
  }
  return count_init;
}

// Skip white spaces and find next char
function next_char_count(count) {
  count++;
  if (char_at(count-1) === "&nbsp;<br>") {
    while (char_at(count) === "&nbsp;") {
      count++;
    }
  }
  return count;
}


$("body").keydown(function(event) {
  console.log("keydown " + event.keyCode);
  // disable tab key
  if (event.keyCode === 9) {
    event.preventDefault();
  }

  // backspace key
  if (event.keyCode === 8 && game_start) {
    $char_elem(count).removeClass("lightblue-bg pink-bg red-bg red");

    count = prev_char_count(count);
    error_count = prev_char_count(error_count);

    $char_elem(count).removeClass("black red red-bg");

    // If there is a typing error
    if (error_count > 0) {
      $char_elem(count).addClass("pink-bg");
    }
    // If there is no typing error
    else {
      $char_elem(count).addClass("lightblue-bg");
    }
    checkScrollPosition($char_elem(count));
    checkDisplayErrorModal(error_count);
  }
});

$("body").keypress(function(event) {

  var keyCode = event.keyCode;
  var input_char = String.fromCharCode(keyCode);
  var char = char_at(count);

  console.log("keypress " + event.keyCode);
  console.log("keypress char " + input_char);
  console.log("char " + char);

  // disable spacebar from scrolling down
  if (!game_start && (input_char === char || input_char === entities.decode(char)) ) {
    event.preventDefault();
    start_game();
  }
  if (count < snippet_length && game_start) {

    // disable spacebar from scrolling down
    if (keyCode === 32) {
      event.preventDefault();
    }
    // if input is enter key
    else if (event.keyCode === 13) {
      input_char = "<br>";
    }

    // if displayed char is a line break
    if (char === "&nbsp;<br>") {
      char = "<br>";
    }
    // if displayed char is a white space
    else if (char === "&nbsp;") {
      char = " ";
    }
    // if displayed char is any other char
    else {
      char = entities.decode(char);
    }

    // if input is correct and no prev errors
    if (input_char === char && error_count === 0) {
      $char_elem(count).removeClass("lightblue-bg pink-bg red");
      $char_elem(count).addClass("black");
      count = next_char_count(count);
      
      $char_elem(count).addClass("lightblue-bg");
    }
    // if there are previous errors
    else {
      if ( char_at(count).includes("&nbsp;") ) {
        $char_elem(count).addClass("red-bg");
      }
      $char_elem(count).removeClass("lightblue-bg pink-bg");
      $char_elem(count).addClass("red");
      count = next_char_count(count);
      error_count = next_char_count(error_count);
      $char_elem(count).addClass("pink-bg");
    }
    checkScrollPosition($char_elem(count));
    checkDisplayErrorModal(error_count);
  }
  // Conditions for winning
  if (count >= snippet_length && error_count === 0 && game_start) {
    game_start = false;
    clearInterval(interval);
    var wpm = Math.floor( snippet_word_count / time_count * 60 );
    $('.modal-content span').text(wpm);
    openWinModal();

    $.ajax({
      method: 'post',
      url: '/attempts',
      data: { 
        snippet_id: snippet_id,
        score: wpm,
        accuracy: 100
      }
    }).done(function(response) {
      console.log(response);
    });
  }
});

function start_game() {
  closeStartModal();
  $('div.timer span').css('color','red');
  game_start = true;
  interval = setInterval(function() {
    time_count = time_count + 0.1;
    var minute_count = Math.floor(time_count / 60);
    var second_count = ("0" + Math.floor(time_count % 60) ).slice(-2);
    var time_string = minute_count + ":" + second_count;
    $('div.timer span').text(time_string);
  },100);
}

// When the user clicks on the button, open the modal 
function openWinModal() {
  var $modal = $('#winModal');
  $modal.css('display','block');
}

function openErrorModal() {
  var $modal = $('#errorModal');
  $modal.css('display','block');
}

function closeErrorModal() {
  var $modal = $('#errorModal');
  $modal.css('display','none');
}

function closeStartModal() {
  var $modal = $('#startModal');
  $modal.css('display','none');
}

function checkDisplayErrorModal(error_count) {
  if (error_count !== 0) {
    openErrorModal();
  }
  else {
    closeErrorModal();
  }
}

function checkScrollPosition($span) {
  if ( $span.offset().top > $(document).height() - 80) {
    $('.snippet').animate({
        scrollTop: $('.snippet').scrollTop() + $('.snippet').height()/1.3
    });
  }

  if ( $span.offset().top < 90) {
    $('.snippet').animate({
        scrollTop: $('.snippet').scrollTop() - $('.snippet').height()/3
    });
  }

  if ( $span.offset().left > $(document).width() - 50) {
    $('.snippet').animate({
        scrollLeft: $('.snippet').scrollLeft() + $('.snippet').width()/1.3
    });
  }

  if ( $span.offset().left < 200) {
    $('.snippet').animate({
        scrollLeft: $('.snippet').scrollLeft() - $('.snippet').width()/1.3
    });
  }
}

$('.snippet').scroll(function(event) {
  $('.modal').css('top', $('.snippet').scrollTop());
  $('.modal').css('left', $('.snippet').scrollLeft());
});