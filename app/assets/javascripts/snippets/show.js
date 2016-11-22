var Entities = require('html-entities').XmlEntities;
 
entities = new Entities();

var snippet_length = $('input[name="snippet_length"]').val();

var game_start = false;
var count = 0;
var error_count = 0;
var time_count = 0;
var interval = 0;

// Highlight the first character
$(".snippet-body span:first").addClass("lightblue");

function $char_elem(index) {
  return $(".snippet-body span:eq(" + index + ")");
}

// Skip white spaces and find next char
function prev_char_count(count) {
  if (count === 0) {
    return count;
  }
  count--;
  var count_init = count;
  while ( $char_elem(count).html() === "&nbsp;" ) {
    count--;
    if ($char_elem(count).html() === "&nbsp;<br>" ) {
      return count;
    }
  }
  return count_init;
}

// Skip white spaces and find next char
function next_char_count(count) {
  if ($char_elem(count).html() === "&nbsp;<br>") {
    count++;
    while ($char_elem(count).html() === "&nbsp;") {
      count++;
    }
  }
  else {
    count++;
  }

  return count;
}


$("body").keydown(function(event) {
  // disable tab key
  if (event.keyCode === 9) {
    event.preventDefault();
  }

  // backspace key
  if (event.keyCode === 8 && game_start) {
    $char_elem(count).removeClass("lightblue pink red");

    count = prev_char_count(count);
    error_count = prev_char_count(error_count);

    $char_elem(count).removeClass("black red");

    // If there is a typing error
    if (error_count > 0) {
      $char_elem(count).addClass("pink");
    }
    // If there is no typing error
    else {
      $char_elem(count).addClass("lightblue");
    }
  }
});

$("body").keypress(function(event) {
  if (count < snippet_length) {
    if (!game_start) {
      start_game();
    }

    var keyCode = event.keyCode;
    var input_char = String.fromCharCode(keyCode);
    var char = $char_elem(count).html();

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
      $char_elem(count).removeClass("lightblue pink red");
      $char_elem(count).addClass("black");
      count = next_char_count(count);
      
      $char_elem(count).addClass("lightblue");
    }
    // if there are previous errors
    else {
      $char_elem(count).removeClass("lightblue pink");
      $char_elem(count).addClass("red");
      count = next_char_count(count);
      error_count = next_char_count(error_count);
      $char_elem(count).addClass("pink");
    }
  }
  if (count >= snippet_length && error_count === 0) {
    game_start = false;

    openModal();
    clearInterval(interval);
    var wpm = Math.floor( snippet_length / time_count * 60 );
    $('.modal-content span').text(wpm);
  }
});

function start_game() {
  $('div.timer span').css('color','red');
  game_start = true;
  interval = setInterval(function() {
    time_count++;
    var time_string = Math.floor(time_count / 60) + ":" + ("0" + time_count % 60).slice(-2);
    $('div.timer span').text(time_string);
  },1000);
}

// When the user clicks on the button, open the modal 
function openModal() {
  var $modal = $('#winModal');
  $modal.css('display','block');
}