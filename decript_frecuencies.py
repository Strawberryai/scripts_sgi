from collections import Counter
diccionario = {}
sustituciones = [('X', 'e'), ('A', 'd'), ('T', 'l'), ('J', 'n'), ('I', 'o'),
        ('C', 'i'), ('P', 'm'), ('Q', 'b'), ('K', 'r'), ('U', 'g'), ('R', 'c'),
        ('H', 't'), ('E', 'a'), ('D', 'p'), ('O', 'f'), ('N', 's'), ('Z' ,'u'),
        ('S', 'q') ,('G', 'j'), ('M', 'h'), ('V', 'y')]

def get_frecuencias():
    frecuencias = {
        "e" : 16.78,
        "r" : 4.94,
        "y" : 1.54, 
        "j" : 0.30,
        "a" : 11.96,
        "u" : 4.80, 
        "q" : 1.53, 
        "ñ" : 0.29,
        "o" : 8.69,
        "i" : 4.15,
        "b" : 0.92, 
        "z" : 0.15,
        "l" : 8.37,
        "t" : 3.31,
        "h" : 0.89, 
        "x" : 0.06,
        "s" : 7.88,
        "c" : 2.92,
        "g" : 0.73, 
        "k" : 0.00,
        "n" : 7.01,
        "p" : 2.776,
        "f" : 0.52,
        "w" : 0.00,
        "d" : 6.87,
        "m" : 2.12,
        "v" : 0.39, 
        }
    return frecuencias

def imprimir_abcdario(sustituciones):
    abc = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"

    string = ""
    for i in range(0, len(abc)):
        string = string + " | " + abc[i]

    string = string + " |"
    print(string);

def sustituir(mensaje, dlist, a, b):
    mensaje = str(mensaje)
    mensajeNuevo = ""

    for i in range(0, len(mensaje)):
        letra = mensaje[i]
        if (letra == a and not i in dlist):
            mensajeNuevo += b
            dlist.append(i)
        else:
            mensajeNuevo += letra

    return mensajeNuevo, dlist

def main():

    f = open("./files/mensaje.txt", "r")
    
    mensajeCifrado = f.read();
    print(mensajeCifrado)
    frecuencias_doc = Counter(mensajeCifrado)
    del frecuencias_doc[' ']
    del frecuencias_doc[',']
    del frecuencias_doc['.']
    
    frecuencias_doc = frecuencias_doc.most_common()
    frecuencias_doc.sort(key=lambda item: item[1])
    
    frecuencias = get_frecuencias()

    frecuencias = list(dict(sorted(frecuencias.items(), key=lambda item:
        item[1]))) 

    print("ITERACIONES")
    dlist = []

    sustituidos = []
    for i in range(0, len(sustituciones)):
        sus = sustituciones[i]

        print(f"Reemplazamos %s -> %s" % (sus[0], sus[1]))
        out = sustituir(mensajeCifrado, dlist, sus[0], sus[1])
        mensajeCifrado = out[0] 
        dlist = out[1]

        print(mensajeCifrado)

        sustituidos.append(sus)
        print(sustituidos)
        imprimir_abcdario(sustituidos)

    
if __name__ == "__main__":
    main()

