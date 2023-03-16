function trim(s)
   return s:match( '^%s*(.-)%s*$' )
end

function col(elem)
	if (elem._cols) then
		print('<div class="col-'..elem._cols..'">')
	else
		print('<div class="col">')
	end
	print(trim(elem.___value))
	print('</div>')
end

function row(elem)
	if (elem._cols) then
		print('<div class="row row-cols-'..elem._cols..'">')
	else
		print('<div class="row">')
	end
	if (elem.col) then
		for i,item in pairs(elem.col) do
			col(item)
		end
	end
	print('</div>')
end

function container(elem)
	if (elem._fluid) then
		print('<div class="container-fluid">')
	else
		print('<div class="container">')
  end
	if (elem.row) then
		for i,item in pairs(elem.row) do
			row(item)
		end
	end
	print('</div>')
end

function body(elem)
	print('<body>')
	if (elem.container) then
		container(elem.container)
	end
	print('</body>')
end

function head(elem)
	print('<head>')
	print('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />')
	print('<meta charset="utf-8" />')
	if (elem.title) then
		print('<title>'..elem.title.___value..'</title>')
	end
	print('<meta name="description" content="" />')
	print('<meta name="author" content="" />')
	print('<meta name="viewport" content="width=device-width, initial-scale=1" />')
  print('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">')
	print('</head>')
end

function html(elem)
	print('<html>')
	if (elem.head) then
		head(elem.head)
	end
	if (elem.body) then
		body(elem.body)
	end
	print('</html>')
end

function main()
	local xml = require('xmlSimple').newParser()
	local indexFile = assert(io.open('grid.xhtml', 'rb'))
	local content = indexFile:read('*all')
	local root = xml:ParseXmlText(content)
	
	if (root.html) then
		html(root.html)
	end
end

main()