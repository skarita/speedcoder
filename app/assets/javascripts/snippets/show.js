console.log("I'm alive");

var Entities = require('html-entities').XmlEntities;
 
entities = new Entities();

var snippet = '<SCRIPT LANGUAGE="JavaScript">\n     var now = new Date();\n\nvar days = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");\n\nvar date = ((now.getDate()<10) ? "0" : "")+ now.getDate();\n\nfunction fourdigits(number) {\n\n  return (number < 1000) ? number + 1900 : number;\n\n                }\n\ntoday =  days[now.getDay()] + ", " +\n         months[now.getMonth()] + " " +\n         date + ", " +\n         (fourdigits(now.getYear())) ;\n\ndocument.write(today);\n</script>';


// var row = 1;
// $span = $('<span>').html(row + "<br>");
// $(".snippet-row").append($span);
// for (var i = 0; i < snippet.length; i++) {
//   if (snippet[i] != "\n") {

//     $span = $('<span>').html(entities.encode(snippet[i]));
//     if (snippet[i] === " ") {
//       $span = $('<span>').html("&nbsp;");
//     }
//   }
//   else {
//     row++;
//     $span = $('<span>').html(row + "<br>");
//     $(".snippet-row").append($span);

//     $span = $('<span>').html("&nbsp;<br>");
//     $span.addClass('return');
//   }
//   $(".snippet-body").append($span);
// }
// $span = $('<span>').html(" <br>");
// $(".snippet-body").append($span);

$(".snippet-body span:first").addClass("lightblue");
// $(".snippet").fadeIn();


var count = 0;
var error_count = 0;

$("body").keydown(function(event) {
  if (event.keyCode === 9) {
    event.preventDefault();
  }

  // backspace key
  if (event.keyCode === 8) {
    $(".snippet-body span:eq(" + count + ")").removeClass("lightblue pink red");
    if (count > 0) {count--;}
    if (error_count > 0) {error_count--;}
    if (error_count > 0) {
      $(".snippet-body span:eq(" + count + ")").addClass("pink");
    }
    else {
      $(".snippet-body span:eq(" + count + ")").addClass("lightblue");
      $(".snippet-body span:eq(" + count + ")").removeClass("red");
    }
    $(".snippet-body span:eq(" + count + ")").removeClass("black");
  }
});



$("body").keypress(function(event) {
  // disable tab key and spacebar
  if (event.keyCode === 32) {
    event.preventDefault();
  }

  var keyCode = event.keyCode;

    var input_char = String.fromCharCode(keyCode);
    if (event.keyCode === 13) {
      input_char = "<br>";
    }

    var char = $(".snippet-body span:eq(" + count + ")").html();

    if (char === "&nbsp;<br>") {
      char = "<br>";
    }
    else if (char === "&nbsp;") {
      char = " ";
    }
    else {
      char = entities.decode(char);
    }

    if (input_char === char && error_count === 0 && count < snippet.length) {
      $(".snippet-body span:eq(" + count + ")").removeClass("lightblue pink red");
      $(".snippet-body span:eq(" + count + ")").addClass("black");
      count++;
      if (event.keyCode === 13) {
        while ( $(".snippet-body span:eq(" + count + ")").html() === "&nbsp;" ||
        $(".snippet-body span:eq(" + count + ")").html() === "&nbsp;<br>" ) {
          count ++;
        }
      }
      
      $(".snippet-body span:eq(" + count + ")").addClass("lightblue");
    }
    else if (count < snippet.length) {
      $(".snippet-body span:eq(" + count + ")").removeClass("lightblue pink").addClass("red");
      count++;
      error_count++;
      $(".snippet-body span:eq(" + count + ")").addClass("pink");
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
  for (var i = 0; i < snippet.length; i++) {
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