function size(tbl)
  return #tbl
end

function trim(s)
  return s:match( '^%s*(.-)%s*$' )
end

function is_array(tbl)
	return type(tbl) == 'table' and (#tbl > 0 or next(tbl) == nil)
end

function to_array(tbl)
  return is_array(tbl) and tbl or {tbl}
end

function form_button(elem)
	io.write('<button class="btn btn-outline-success my-sm-0"')
  if (elem["@type"]) then
	  io.write(' type="'..elem["@type"]..'"')
	end
  io.write('">')
  if (elem:value()) then
    io.write(trim(elem:value()))
  end
	io.write('</button>')
end

function form_input(elem)
	io.write('<input class="form-control"')
  if (elem["@type"]) then
	  io.write(' type="'..elem["@type"]..'"')
  end
  if (elem["@placeholder"]) then
	  io.write(' placeholder="'..elem["@placeholder"]..'"')
  end
	io.write('">')
	io.write('</input>')
end

function dropdown_items(items)
	items = to_array(items)
	for i = 1, size(items) do
	  io.write('<a class="dropdown-item"')
    if (items[i]["@href"]) then
	    io.write(' href="'..items[i]["@href"]..'"')
		end
	  io.write('">')
	  if (items[i]:value()) then
	    io.write(trim(items[i]:value()))
    end
	  io.write('</a>')
  end
end

function nav_item_form(elem)
	io.write('<form class="form-inline">')
	if elem["form-input"] then
		form_input(elem["form-input"])
	end
	if elem["form-button"] then
		form_button(elem["form-button"])
	end
	io.write('</form>')
end

function nav_item_text(elem)
	io.write('<span class="navbar-text">')
  if (elem:value()) then
    io.write(trim(elem:value()))
  end
	io.write('</span')
end

function nav_item_dropdown(elem)
	io.write('<li class="nav-item dropdown">')
	io.write('<a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">')
	io.write(elem['@text'])
	io.write('</a>')
	io.write('<div class="dropdown-menu">')
	if elem["dropdown-item"] then
		dropdown_items(elem["dropdown-item"])
	end
	io.write('</div')
	io.write('</li>')
end

function nav_item_link(elem)
  io.write('<li class="nav-item"><a class="nav-link')
  if (elem["@active"]) then
	  io.write(' active')
  end
  if (elem["@disabled"]) then
	  io.write(' disabled')
  end
  if (elem["@href"]) then
	  io.write('" href="'..elem["@href"]..'">')
  else
	  io.write('">')
  end
  if (elem:value()) then
    io.write(trim(elem:value()))
  end
  io.write('</a></li>')
end

function nav_item(items)
	items = to_array(items)
	for i = 1, size(items) do
		if (items[i]["@type"]=="link") then
			nav_item_link(items[i])
		elseif (items[i]["@type"]=="dropdown") then
			nav_item_dropdown(items[i])
		elseif (items[i]["@type"]=="text") then
			nav_item_text(items[i])
		elseif (items[i]["@type"]=="form") then
			nav_item_form(items[i])
	  end
	end
end

function navbar_nav(elem)
	io.write('<ul class="navbar-nav')
  if (elem["@justify"]) then
    io.write(' justify-content-'..elem["@justify"])
	end
	io.write('">')
	if elem["nav-item"] then
		nav_item(elem["nav-item"])
	end
	io.write('</ul>')
end

function navbar_collapse(elem)
	io.write('<div class="collapse navbar-collapse"')
	if elem["@id"] then
		io.write(' id="'..elem["@id"]..'"')
	end
	io.write('>')
	if elem["navbar-nav"] then
		navbar_nav(elem["navbar-nav"])
	end
	io.write('</div>')
end

function navbar_toogle(elem)
  io.write('<button class="navbar-toggler" type="button" data-toggle="collapse"')
	if (elem["@target"]) then
		io.write(' data-target="#'..elem["@target"]..'">')
	else
		io.write('>')
	end
	if (elem["@icon"]=="true") then
		io.write('<span class="navbar-toggler-icon"></span>')
	end
	io.write('</button>')
end

function navbar_brand(elem)
  io.write('<a class="navbar-brand" href="#">')
  if (elem:value()) then
    io.write(trim(elem:value()))
  end
	io.write('</a>')
end

function navbar(elem)
  io.write('<nav class="navbar')
  if (elem["@expand"]) then
    io.write(' navbar-expand-lg')
  end
  if (elem["@type"]=="light") then
    io.write(' navbar-light')
	elseif (elem["@type"]=="dark") then
		io.write(' navbar-dark')
	end
  if (elem["@variant"]=="light") then
    io.write(' bg-light')
	elseif (elem["@variant"]=="dark") then
		io.write(' bg-dark')
	end
  io.write('">')
	if elem["navbar-brand"] then
		navbar_brand(elem["navbar-brand"])
	end
	if elem["navbar-toggle"] then
		navbar_toogle(elem["navbar-toggle"])
	end
	if elem["navbar-collapse"] then
		navbar_collapse(elem["navbar-collapse"])
	end
	if elem["navbar-nav"] then
		navbar_nav(elem["navbar-nav"])
	end
	io.write('</nav>')
end

function cols(cols)
  cols = to_array(cols)
  for i = 1, size(cols) do
    if (cols[i]["@break"]) then
      io.write('<div class="w-100">')
    else
      io.write('<div class="col')
      if (cols[i]["@cols"]) then
        io.write('-'..cols[i]["@cols"])
      end
      if (cols[i]["@auto"]) then
        io.write('-md-auto')
      end
	    if (cols[i]["@align"]) then
	      io.write(' align-self-'..cols[i]["@align"])
	    end
      io.write('">')
      if (cols[i]:value()) then
        io.write(trim(cols[i]:value()))
      end
    end
    io.write('</div>')
  end
end

function rows(rows)
  rows = to_array(rows)
  for i = 1, size(rows) do
    io.write('<div class="row')
    if (rows[i]["@cols"]) then
      io.write(' row-cols-'..rows[i]["@cols"])
    end
    if (rows[i]["@justify"]) then
      io.write(' justify-content-md-'..rows[i]["@justify"])
    end
    if (rows[i]["@align"]) then
      io.write(' align-items-'..rows[i]["@align"])
    end
    io.write('">')
    if (rows[i].col) then
      cols(rows[i].col)
    end
    io.write('</div>')
  end
end

function container(elem)
  if (elem["@fluid"]) then
    io.write('<div class="container-fluid">')
  else
    io.write('<div class="container">')
  end
  if (elem.row) then
    rows(elem.row)
  end
  io.write('</div>')
end

function body(elem)
  io.write('<body>')
  if (elem.navbar) then
    navbar(elem.navbar)
  end
  if (elem.container) then
    container(elem.container)
  end
	io.write('<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>')
  io.write('<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>')
  io.write('</body>')
end

function head(elem)
  io.write('<head>')
  io.write('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />')
  io.write('<meta charset="utf-8" />')
  if (elem.title) then
    io.write('<title>'..elem.title:value()..'</title>')
  end
  io.write('<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">')
  io.write('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">')
	io.write('<link rel="stylesheet" href="custom.css">')
	io.write('</head>')
end

function html(elem)
	io.write('<!doctype html>')
  io.write('<html lang="en">')
  if (elem.head) then
    head(elem.head)
  end
  if (elem.body) then
    body(elem.body)
  end
  io.write('</html>')
end

function main()
  local xml = require('xmlSimple').newParser()
  local indexFile = assert(io.open('nav2.xhtml', 'rb'))
  local content = indexFile:read('*all')
  local root = xml:ParseXmlText(content)
  if (root.html) then
    html(root.html)
  end
end

main()
