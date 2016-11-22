var Entities = require('html-entities').XmlEntities;
 
entities = new Entities();

var snippet_length = $('input[name="snippet_length"]').val();

var count = 0;
var error_count = 0;

// Highlight the first character
$(".snippet-body span:first").addClass("lightblue");

function $char_elem(index) {
  return $(".snippet-body span:eq(" + index + ")");
}

function prev_char_count(count) {
  count--;
  var count_init = count;
  while ( $char_elem(count).html() === "&nbsp;" ||
    $char_elem(count).html() === "&nbsp;<br>" ) {
    count--;
    if ($char_elem(count).html() === "&nbsp;<br>" ) {
      return count;
    }
  }
  return count_init;
}

function next_char_count(count) {
  count++;
  while ($char_elem(count).html() === "&nbsp;") {
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
  if (event.keyCode === 8) {
    $char_elem(count).removeClass("lightblue pink red");
    if (count > 0) {
      count = prev_char_count(count, -1);
    }
    if (error_count > 0) {
      error_count = prev_char_count(error_count, -1);
    }
    if (error_count > 0) {
      $char_elem(count).addClass("pink");
    }
    else {
      $char_elem(count).addClass("lightblue");
      $char_elem(count).removeClass("red");
    }
    $char_elem(count).removeClass("black");
  }
});

$("body").keypress(function(event) {
  // disable spacebar
  if (event.keyCode === 32) {
    event.preventDefault();
  }

  var keyCode = event.keyCode;

    var input_char = String.fromCharCode(keyCode);
    if (event.keyCode === 13) {
      input_char = "<br>";
    }

    var char = $char_elem(count).html();

    if (char === "&nbsp;<br>") {
      char = "<br>";
    }
    else if (char === "&nbsp;") {
      char = " ";
    }
    else {
      char = entities.decode(char);
    }

    if (input_char === char && error_count === 0 && count < snippet_length) {
      $char_elem(count).removeClass("lightblue pink red");
      $char_elem(count).addClass("black");
      if (event.keyCode === 13 && $char_elem(count).html() === "&nbsp;<br>") {
        count = next_char_count(count, 1);
      }
      else {
        count++;
      }
      
      $char_elem(count).addClass("lightblue");
    }
    else if (count < snippet_length) {
      $char_elem(count).removeClass("lightblue pink").addClass("red");
      if (event.keyCode === 13 && $char_elem(count).html() === "&nbsp;<br>") {
        count = next_char_count(count);
        error_count = next_char_count(error_count);
      }
      else {
        count++;
        error_count++;
      }
      $char_elem(count).addClass("pink");
    }
});

$('.load-btn').click(function(event) {
  hi();
  console.log('hi');
});

function hi() {
  $(".snippet-row").empty();
  $(".snippet-body").empty();
  var test = $('textarea').val();
  console.log('hi');
  console.log(test);

  snippet = test;

  var row = 1;
  $span = $('<span>').html(row + "<br>");
  $(".snippet-row").append($span);
  for (var i = 0; i < snippet_length; i++) {
    if (snippet[i] != "\n") {

      $span = $('<span>').html(entities.encode(snippet[i]));
      if (snippet[i] === " ") {
        $span = $('<span>').html("&nbsp;");
      }
    }
    else {
      row++;
      $span = $('<span>').html(row + "<br>");
      $(".snippet-row").append($span);

      $span = $('<span>').html("&nbsp;<br>");
      $span.addClass('return');
    }
    $(".snippet-body").append($span);
  }
  $span = $('<span>').html(" <br>");
  $(".snippet-body").append($span);

  $(".snippet-body span:first").addClass("lightblue");

  $(".snippet").fadeIn();

  count = 0;
  error_count = 0;
}