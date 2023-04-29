class Graph:
    def __init__(self, adjacency_list):
        self.adjacency_list = adjacency_list

    def get_neighbors(self, node):
        return self.adjacency_list[node]

    def node_weight(self, node):
        H = {
            'A': 1,
            'B': 1,
            'C': 1,
            'D': 1
        }

        return H[node]

    def a_star_algorithm(self, start_node, stop_node):
        open_list = set([start_node])
        closed_list = set([])

        g = {}
        g[start_node] = 0

        # verifica
        parents = {}
        parents[start_node] = start_node

        while len(open_list) > 0:
            current_node = None

            # verifica qual é o menor nó vizinho do nó atual.
            for v in open_list:
                if (current_node == None or g[v] + self.node_weight(v) <
                        g[current_node] + self.node_weight(current_node)):
                    current_node = v

            if current_node == None:
                print('Caminho não existe!')
                return None

            # quando acha o nó refaz o caminho.
            if current_node == stop_node:
                reconst_path = []

                while parents[current_node] != current_node:
                    reconst_path.append(current_node)
                    current_node = parents[current_node]

                reconst_path.append(start_node)
                reconst_path.reverse()

                print(f'caminho encontrado: {reconst_path}')
                return True
            # adiciona o custo do caminho do nó vizinho em g e relaciona ao nó atual.
            for (m, weight) in self.get_neighbors(current_node):
                if m not in open_list and m not in closed_list:
                    open_list.add(m)
                    parents[m] = current_node
                    g[m] = g[current_node] + weight
                    print

                # verifica se é melhor voltar ou passar para o proximo nó atraves do peso.
                else:
                    if g[m] > g[current_node] + weight:
                        g[m] = g[current_node] + weight
                        parents[m] = current_node

                        if m in closed_list:
                            closed_list.remove(m)
                            open_list.add(m)

            open_list.remove(current_node)
            closed_list.add(current_node)

        print('Caminho não existe')
        return None

# teste
adjacency_list = {
    'A': [('B', 1), ('C', 3), ('D', 7)],
    'B': [('D', 5)],
    'C': [('D', 12)]
}

graph1 = Graph(adjacency_list)
graph1.a_star_algorithm('A', 'D')
