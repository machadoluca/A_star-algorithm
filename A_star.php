<?php

class Graph {
    private array $adjacencyList;

    public function __construct(array $adjacencyList) {
        $this->adjacencyList = $adjacencyList;
    }

    public function getNeighbors(string $node) {
        return $this->adjacencyList[$node];
    }

    public function nodeWeight(string $node) {
        $H = [
            'A' => 1,
            'B' => 1,
            'C' => 1,
            'D' => 1
        ];
        
        return $H[$node];
    } 

    public function aStarAlgorithm(string $startNode, string $stopNode) {
        $openList = [$startNode];
        $closedList = [];

        $g = [];
        $g[$startNode] = 0;

        $parents = [];
        $parents[$startNode] = $startNode;
        
        while (count($openList) > 0) {
            $currentNode = null;

            // verifica qual é o menor nó vizinho do nó atual.
            foreach ($openList as $v) {
                if ($currentNode == null || $g[$v] + $this->nodeWeight($v) <
                        $g[$currentNode] + $this->nodeWeight($currentNode)) {
                    $currentNode = $v;
                }
            }
            
            if ($currentNode == null) {
                throw new Exception('Caminho não existe!!');
            }

            // quando acha o nó refaz o caminho.
            if ($currentNode == $stopNode) {
                $reconstPath = [];
    
                while ($parents[$currentNode] != $currentNode) {
                    $reconstPath[] = $currentNode;
                    $currentNode = $parents[$currentNode];

                }
                $reconstPath[] = $startNode;
                $reconstPath = array_reverse($reconstPath);
    
                echo sprintf('caminho encontrado: %s', implode(' -> ', $reconstPath));
                return true;

                
            }

            // adiciona o custo do caminho do nó vizinho em g e relaciona ao nó atual.
            foreach ($this->getNeighbors($currentNode) as $item) {
                $m = $item[0];
                $weight = $item[1];
                if (!in_array($m, $openList) && !in_array($m, $closedList)) {
                    $openList[] = $m;
                    $parents[$m] = $currentNode;
                    $g[$m] = $g[$currentNode] + $weight;
                }

                // verifica se é melhor voltar ou passar para o proximo nó atraves do peso.
                else {
                    if ($g[$m] > $g[$currentNode] + $weight) {
                        $g[$m] = $g[$currentNode] + $weight;
                        $parents[$m] = $currentNode;

                        if (in_array($m, $closedList)) {
                            $closedList = array_filter($closedList, fn($node) => $node != $m);
                            $openList[] = $m;
                        }
                    }
                }
            }
            $openList = array_filter($openList, fn($node) => $node != $currentNode);
            $closedList[] = $currentNode;

        }
        echo 'Caminho não existe';
        return null;
    }
}

$adjacencyList = [
    'A' => [['B', 1], ['C', 3], ['D', 7]],
    'B' => [['D', 5]],
    'C' => [['D', 12]]
];

$Graph1 = new Graph($adjacencyList);
$Graph1->aStarAlgorithm('A', 'D');
