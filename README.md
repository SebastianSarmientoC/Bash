# Bash
Una introducción a bash shell

Primero vamos a abrir la terminal de nuestro computador. Y de aquí vamos a ingresar al directamente al cluster con su respectivo usuario. 
ssh 10.10.100.139 -l lvega

Miremos varios de los comandos básicos que vamos a necesitar. 

Para saber en que directorio o carpeta nos encontramos se utiliza _pwd_ (print working directory).

Para saber que hay en el directorio que estamos parados pordemos utilizar _ls_. 

En dado caso de querer ampliar la información de los archivos que están en el directorio te puede utilizar ls -l. 
¿Qué son los permisos de los archivos? 

![Permisos](https://www.redeszone.net/app/uploads-redeszone.net/2017/01/otorgar-permisos-fichero-o-carpeta-linux.png)

Incluso, si se quieren observar otras característicasde los archivos o que no nos acordemos cual era el comando específico siempre podemos pedirle ayuda a shell para conocer las diferentes funciones de los comandos de la siguiente manera: 
1. ls --help
2. man ls
3. info ls

Para movernos entre directorios utilizamos _cd_ (change directory) para entrar a las carpetas o _cd_ .. si queremos devolvernos. 

El tabulado también es una gran herramienta para moverse entre directorios pues nos va a permitir ver las que opciones tenemos antes de ejecutar el comando. ¡Probémoslo!

Cuando lleguemos a los archivos y necesitemos leerlos, vamos a disponer de varios comandos para este fin como: less, cat, head y tail. ¡Probemos cada uno!

Para esto descarguemos un archivo del siguiente link con el comando _wget_: [link](https://raw.githubusercontent.com/SebastianSarmientoC/Bash/main/Paeruginosa_complete_genomes_annotated_2024_1.tsv)

Para copiar archivos de un lugar a otro pordemos utilizar _cp_. En dado caso que queramos mover los archivos (cortarlos) de un directorio a otro podemos utilizar el comando _mv_. 

Creemos un archivo con el fin de moverlo a un directorio que también crearemos. Con el comando _echo_ que nos permite imprimir texto vamos a crear el archivo de la siguiente manera: _echo_ "Palabras al azar" > archivo.txt. Cómo creen que se puede guardar el archivo que acabamos de concatenar. 

En el caso que queramos adicionar texto en el archivo podemos utilizar el editor de texto prodeterminado llamado _nano_. 

Otra función muy usada es _cat_ que nos permite concatenar archivos. Creemos otro archivo con _echo_ "Más palabras al azar" > archivo2.txt. Y ahora concatenemos los dos archivos.  

Para crear directorios utilizamos el comando _mkdir_ y para eliminarlos utilizamos _rmdir_ o _rm -rf_. 

Otro comando importante a la hora de utilizar bash es pipe _|_. Corramos este comando _cut -f 5 Paeruginosa_complete_genomes_annotated_2024_1.tsv | sort_. ¿Qué hizo el comando?

Así es, con _cut_ podemos obtener columnas específicas de los archivos y con sor podemos ordenar dichas columnas. (Con _sort -t' ' -k2 input_ podemos ordenar sin quitar las demás columnasdel archivo).

Pueden encontrar una lista resumen de estos comandos en esta dirección: [Link](https://www.reneshbedre.com/blog/linux-for-bioinformatics.html#getting-started-with-linux-commands)

Ahora aprendamos como podemos filtrar nuestros archivos sin tener que modificarlos o incluso ingresar en ellos. Uno de los comandos que podemos utilizar para tal fin es _grep_, el cual busca patrones específicos en todo el archivo y los separa del resto. Por ejemplo, busquemos aquellos genomas que fueron secuenciados por PacBio, en el archivo descargado. 

_grep 'PacBio' Paeruginosa_complete_genomes_annotated_2024_1.tsv_

Esto también puede guardarse en un archivo. ¿Cómo lo harían? 

Por ejemplo también podríamos querer buscar un número de accesión en particular como este: ASM3623206v1. 
O incluso dos, en cuyo caso tendríamos que correr el comando dos veces o utilizar expresiones regulares. ASM3623367v1. Para hacer esto necesitamos utilizar _-e_

_grep -e ASM3623206v1|ASM3623367v1 Paeruginosa_complete_genomes_annotated_2024_1.tsv_

_grep_ posee muchas otras funciones como por ejemplo contar la cantidad de coincidencias con el patrón (_-c_) o separar aquellas coincidencias del archivo original (_-o_), entre muchas otras que puedes explorar con las ayudas. 

_awk_ también nos ayuda a obtener las filas por separado. 
Utilizando awk '{ print $1 "\t" $2 }' Paeruginosa_complete_genomes_annotated_2024_1.tsv
Pero también nos permite hacer operaciones entre columnas de la siguiente forma. 
awk '$7 + $8 > 6000' Pauriginosa_complete_genomes_annotated_2024_1.tsv

Ahora ya sabes como buscar patrones, números o palabras específicas dentro de los archivos. Pero qué se utiliza si quiero además de filtrar o seleccionar también quiero modificar el texto o las columnas. 
Para tal propósito podemos utilizar el comando _sed_. 

Por ejemplo, si quisieramos quitar los espacios entre el género y el epíteto de la especies en la base de datos, podríamos utilizar: 

_sed 's/Pseudomonas aeruginosa/Pseudomonas_aeruginosa/' Paeruginosa_complete_genomes_annotated_2024_1.tsv_

Cómo harías si necesitaras unir las útimas do columnas entonces. 
De igual manera que con _grep_ _sed_ permite utilizar expresiones regulares para buscar patrones en el archivo. 

sed -E 's/\t([0-9]{4})\t([0-9]+)/\t\1\t\2/g' Paeruginosa_complete_genomes_annotated_2024_1.tsv









