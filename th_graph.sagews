M = 14  # (point pluits)
##############################################PARCOURS LARGEUR####################################################
def parcours_largeur(graph,depart):
    taille = len(graph.edges())
    graph_sortant = []
    sommet_visite = []
    sommet_visite.append(depart)

    indice = 1
    #initialition du graph avec la racine
    #puis on trace le grap avec une boucle while
    for i in range (0,taille-1):
        for a in graph.outgoing_edge_iterator(depart):
            if a[1] not in sommet_visite:
                graph_sortant.append(a)
                sommet_visite.append(a[1])
        if indice >= len(sommet_visite):
            break
        depart = sommet_visite[indice]
        #print(depart)
        indice = indice + 1
    g = DiGraph(graph_sortant)
    g.show(edge_labels=True)



######################################## ADDITION POUR LE GRAPHE RESIDUEL#########################################
def addtionDansGraph (liste):
    new_liste = []
    for i in (liste):
        for k in (liste):
            if i[0] == k[0] and i[1] == k[1] and i[2] != k[2]:
                x = i[0]
                y = i[1]
                z = i[2] + k[2]
                a = (x,y,z)
                if z != 0:
                    new_liste.append(a)
                liste.remove(i)
                liste.remove(k)
    for i in (new_liste):
        liste.append(i)
    return liste
# ######################################### Matrice zero ##########################################################

def matrice_zero(graph):
    m = copy(graph.adjacency_matrix())
    for i in range(m.nrows()):
        for j in range(m.ncols()):
            m[i,j] = 0
    return m
##########################################GRAPHE RESIDUEL##########################################################

def graph_residuel(graph,m):
    taille = len(graph.vertices())
    depart = 0
    graph_sortant = []
    while(depart < taille):
        for a in graph.outgoing_edge_iterator(depart):
            x = a[0]
            y = a[1]
            z = a[2]
            b = (x,y,(z-(m[x,y])))
            c = (y,x,m[x,y])
            graph_sortant.append(b)
            graph_sortant.append(c)
        depart = depart + 1
    graph_sortant = DiGraph(graph_sortant)
    for i in graph_sortant.edges(sort = False):
        u,v,z = i
        if graph_sortant.edge_label(u,v) == 0:
            graph_sortant.delete_edge(u,v)

    li = []
    depart = 0
    taille = len(graph.vertices())
    for q in range (0,taille-1):
        for i in graph_sortant.outgoing_edge_iterator(depart):
            li.append(i)
        depart = depart + 1
    return li

##################################### RECUPERE LA LISTE ##############################################
def recupListMin(li):
    li_final = []
    taille_min = len(li[1])
    for i in li:
        if len(i)<= taille_min:
            taille_min = len(i)
    for i in li:
        if len(i) == taille_min:
            li_final.append(i)
    return li_final

################################ initialisation des flots #############################################

def init_flow(graph,matrice):
    li = []
    minimum=[]
    all_chemin = graph.all_paths(0, M , report_edges = True, labels = True)

    for i in range(len(all_chemin)) :
        for j in range(len(all_chemin[i])) :
            u,v,z = all_chemin[i][j]
            li.append(z)
        minimum.append(min(li))
        li.clear()

    for i in range(len(all_chemin)) :
        k = 0
        bo = False
        for j in range( len(all_chemin[i]) ) :
            u,v,z = all_chemin[i][j]
            if matrice[u][v] >= z or matrice[u][v] + minimum[i] > z :
                    bo = True
        while bo == False and k < len(all_chemin[i]) :
            u,v,z = all_chemin[i][k]
            matrice[u,v] += minimum[i]
            k = k + 1
    #print(matrice)
    return matrice

########################################## Edmonds-Karps #################################################
def edmonds_karp(graph):
    #initalisation de la matrice a zero :
    matrice_z = matrice_zero(graph)

    #initalisation des flow :
    flow_init = init_flow(graph,matrice_z)
    # Le graph residuel :
    graph_r = DiGraph(addtionDansGraph(graph_residuel(graph,flow_init)))
    # premier chemin du graph residuel
    a = graph_r.all_paths(0, M, report_edges = True, labels = True)
    #on recup les chemins les plus rapides
    a = recupListMin(a)
    stop = len(a)
    li_min = []

    while stop != 0:
        for i in range (len(a)):
            for j in a[i]:
                u,v,z = j
                li_min.append(z)
                minn = min(li_min)
            li_min.clear()
            for j in a[i]:
                u,v,z = j
                #print("capacite : ",graph.edge_label(u, v))
                #print("flow",flow_init)
                if graph.has_edge(u,v):
                    if flow_init[u,v] + minn <= graph.edge_label(u, v) :
                        flow_init[u,v] = flow_init[u,v] + minn
        stop = stop - 1
    # Affichage du flow max
    f_max = 0
    for i in range(flow_init.nrows()):
        for j in range(flow_init.ncols()):
            if j == M:
                f_max += flow_init[i][j]

    return print("le flow maximum du graphe vaut : ",f_max)

############################################ MAIN  ################################
tp = {
0 : { 1 : 1, 2 : 7, 3 : 2, 4 : 5, 5 : 10},
1 : { 6 : 1, 7 : 2},
2 : { 7 : 3, 8 : 5},
3 : { 8 : 42, 9 : 17},
4 : { 9 : 21, 10 : 2},
5 : { 10 : 27, 6 : 1},
6 : { 11 : 2},
7 : { 11 : 1},
8 : { 12 : 2},
9 : { 13 : 1},
10 : { 13 : 2},
11 : { 14 : 4},
12 : { 11 : 21, 14 : 2},
13 : { 12 : 21, 14 : 1}
}
exemple = {
0 : { 1 : 16, 3 : 13},
1 : { 2 : 12, 3 : 10},
2 : { 3 : 9, 5 : 20},
3 : { 1 : 4, 4 : 14},
4 : { 2 : 7, 5 : 4},
}

exo_2 = {
0 : { 1 : 7, 2 : 2, 3 : 6},
1 : { 0 : 1, 2 : 7, 3 : 3},
2 : { 1 : 1},
3 : { 0 : 4}
}

graph = DiGraph(exemple)
graph.show(edge_labels=true)
parcours_largeur(graph,0)

d = DiGraph(tp)
d.show(edge_labels=true)
edmonds_karp(d)

e = DiGraph(exo_2)
e.show(edge_labels=true)
print("flow maximum :" ,e.flow(0,3))









