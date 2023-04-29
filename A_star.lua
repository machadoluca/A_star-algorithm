Graph = {adjacency_list = {}}

function Graph.get_neighbors(self, node)
  return self.adjacency_list[node]
end

function Graph.node_weight(self, node)
  H = {}
  H['A'] = 1
  H['B'] = 1
  H['C'] = 1
  H['D'] = 1
  
  return H[node]
end

function Graph.a_star_algorithm(self, start_node, stop_node)
  open_list = {start_node}
  closed_list = {}

  g = {}
  g[start_node] = 0

  --verifica
  parents = {}
  parents[start_node] = start_node

  while #open_list > 0 do
    current_node = nil

    for _, v in ipairs (open_list) do
      if current_node == nil or g[v] + self.node_weight(self, v) <
          g[current_node] + self.node_weight(self, current_node) then
        current_node = v
      end
    end
    
    if current_node == nil then
      print('Caminho não existe!')
      return nil
    end
    -- quando acha o nó refaz o caminho.
    if current_node == stop_node then
      reconst_path = {}

      while parents[current_node] ~= current_node do
        table.insert(reconst_path, current_node)
        current_node = parents[current_node]
      end
      table.insert(reconst_path, start_node)
      array_reverse(reconst_path)
      
      reconst_path_str = ''
      for i, node in ipairs (reconst_path) do
        reconst_path_str = reconst_path_str .. node
        if i < #reconst_path then
          reconst_path_str = reconst_path_str .. ' -> '
        end
      end

      print('caminho encontrado: ' .. reconst_path_str)
      return true
    end
    
    -- adiciona o custo do caminho do nó vizinho em g e relaciona ao nó atual.
    for _, item in ipairs (self.get_neighbors(self, current_node)) do
      m = item[1]
      weight = item[2]
      
      if not_in(open_list, m) and not_in(closed_list, m) then
        table.insert(open_list, m)
        parents[m] = current_node
        g[m] = g[current_node] + weight
      -- verifica se é melhor voltar ou passar para o proximo nó atraves do peso.
      else
        if g[m] > g[current_node] + weight then
          g[m] = g[current_node] + weight
          parents[m] = current_node

          if has_value(closed_list, m) then
            remove_node(closed_list, m)
            table.insert(open_list, m)
          end
        end
      end
    end
    remove_node(open_list, current_node)
    table.insert(closed_list, current_node)
  end
  print('Caminho não existe')
  return nil
end

function array_reverse(x)
  local n, m = #x, #x/2
  for i=1, m do
    x[i], x[n-i+1] = x[n-i+1], x[i]
  end
  return x
end

function remove_node (set, theNode)
	for i, node in ipairs (set) do
		if node == theNode then 
			set [ i ] = set [ #set ]
			set [ #set ] = nil
			break
		end
	end
end

function has_value (tab, val)
  for index, value in ipairs(tab) do
    if value == val then
        return true
    end
  end

  return false
end
  
function not_in ( set, theNode )
	for _, node in ipairs ( set ) do
		if node == theNode then return false end
	end
	return true
end

adjacency_list = {}
adjacency_list['A'] = {}
adjacency_list['B'] = {}
adjacency_list['C'] = {}
table.insert(adjacency_list['A'], {'B', 1})
table.insert(adjacency_list['A'], {'C', 3})
table.insert(adjacency_list['A'], {'D', 7})
table.insert(adjacency_list['B'], {'D', 5})
table.insert(adjacency_list['C'], {'D', 12})

Graph.adjacency_list = adjacency_list
Graph.a_star_algorithm(Graph, 'A', 'D')
