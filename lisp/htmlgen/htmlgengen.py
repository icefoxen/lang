# tags that take args
a = ["meta", "link", "body", "p", "span", "div", "a", "img", "table", "tr", "td", "ul", "ol", "li"]

# tags that don't take args
b = ["html", "head", "title", "br", "b", "i", "u", "em", "strong", "h1",
"h2", "h3", "h4"]


# Dos linefeeds...
for x in a:
   print "(defun " + x + " (opt &rest body)\r"
   print "   (tag '" + x + " opt body))\r\n\r"


for x in b:
   print "(defun " + x + " (&rest body)\r"
   print "   (tag '" + x + " () body))\r\n\r"
