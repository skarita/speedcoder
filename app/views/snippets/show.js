var snippet = '<SCRIPT LANGUAGE="JavaScript">\nvar now = new Date();\n\nvar days = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");\n\nvar date = ((now.getDate()<10) ? "0" : "")+ now.getDate();\n\nfunction fourdigits(number) {\n\n  return (number < 1000) ? number + 1900 : number;\n\n                }\n\ntoday =  days[now.getDay()] + ", " +\n         months[now.getMonth()] + " " +\n         date + ", " +\n         (fourdigits(now.getYear())) ;\n\ndocument.write(today);\n</script>';

var row = 1;
$span = $('<span>').html(row + "<br>");
$(".snippet-row").append($span);
for (var i = 0; i < snippet.length; i++) {
  if (snippet[i] != "\n") {
    $span = $('<span>').text(snippet[i]);
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

var count = 0;
var error_count = 0;

$("body").keydown(function(event) {
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
  console.log(event.keyCode);
  var keyCode = event.keyCode;

  // var valid = 
  //   (keyCode > 47 && keyCode < 58)   || // number keys
  //   keyCode == 8 ||
  //   keyCode == 32 || keyCode == 13   || // spacebar & return key(s) (if you want to allow carriage returns)
  //   (keyCode > 64 && keyCode < 91)   || // letter keys
  //   (keyCode > 95 && keyCode < 112)  || // numpad keys
  //   (keyCode > 185 && keyCode < 193) || // ;=,-./` (in order)
  //   (keyCode > 218 && keyCode < 223);   // [\]' (in order)

    var input_char = String.fromCharCode(keyCode);
    
    if (event.keyCode === 13) {
      input_char = "\n";
    }

    var char = $(".snippet-body span:eq(" + count + ")").html();

    if (char === "&nbsp;<br>") {
      char = "\n";
    }
    else if (char[0] === "&") {
      char = decodeHTMLEntities(char);
    }

    console.log(input_char + " " + char);
    console.log(count + " " + error_count);
    if (input_char === char && error_count === 0 &&count < snippet.length) {
      $(".snippet-body span:eq(" + count + ")").removeClass("lightblue pink red");
      $(".snippet-body span:eq(" + count + ")").addClass("black");
      count++;
      $(".snippet-body span:eq(" + count + ")").addClass("lightblue");
    }
    else if (count < snippet.length) {
      $(".snippet-body span:eq(" + count + ")").removeClass("lightblue pink").addClass("red");
      count++;
      error_count++;
      $(".snippet-body span:eq(" + count + ")").addClass("pink");
    }
});

function decodeHTMLEntities(text) {
    var entities = [
        ['amp', '&'],
        ['apos', '\''],
        ['#x27', '\''],
        ['#x2F', '/'],
        ['#39', '\''],
        ['#47', '/'],
        ['lt', '<'],
        ['gt', '>'],
        ['nbsp', ' '],
        ['quot', '"']
    ];

    for (var i = 0, max = entities.length; i < max; ++i) 
        text = text.replace(new RegExp('&'+entities[i][0]+';', 'g'), entities[i][1]);

    return text;
}