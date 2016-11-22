# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Snippet.create({
  body: "<form method=\"POST\" name=\"wordcount\">\r\n  <script language=\"JavaScript\">\r\n\r\nfunction countit(){\r\n\r\n\r\nvar formcontent=document.wordcount.wordcount2.value\r\nformcontent=formcontent.split(\" \")\r\ndocument.wordcount.wordcount3.value=formcontent.length\r\n}\r\n</script>\r\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n    <tr>\r\n      <td width=\"100%\"><textarea rows=\"12\" name=\"wordcount2\" cols=\"60\" wrap=\"virtual\"></textarea></td>\r\n    </tr>\r\n    <tr>\r\n      <td width=\"100%\"><div align=\"right\"><p><input type=\"button\" value=\"Calculate Words\"\r\n      onClick=\"countit()\"> <input type=\"text\" name=\"wordcount3\" size=\"20\"></p>\r\n      <div align=\"center\"><center><p><font face=\"arial\" size=\"-2\">This free script provided by</font>\r\n      <font face=\"arial, helvetica\" size=\"-2\"><a href=\"http://javascriptkit.com\">JavaScript\r\n      Kit</a></font></p>\r\n      </center></div></div></td>\r\n    </tr>\r\n  </table>\r\n</form>",
  name: "Word Count",
  description: "Word count script\r\nBy JavaScript Kit (http://javascriptkit.com)",
  user_id: 1,
  language: "javascript"

})
