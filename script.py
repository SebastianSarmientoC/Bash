# Este script demuestra algunas características básicas de Python

# Función que imprime un saludo personalizado
def saludo(nombre):
    print("Hola, ",nombre,"! Bienvenidos a Python.")

# Variable con un nombre
mi_nombre = "Mundo"

# Llamada a la función saludo
saludo(mi_nombre)

# Lista de números
numeros = [1, 2, 3, 4, 5]

# Bucle que recorre la lista y muestra cada número
for numero in numeros:
    print("Numero:", numeros)

# Condicional simple
if len(numeros) > 3:
    print("La lista tiene mas de 3 numeros.")
else:
    print("La lista tiene 3 o menos numeros.")

# Mensaje de finalización
print("El script ha terminado.")
