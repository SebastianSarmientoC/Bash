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

¡Funciones secundarias! 

¿Cómo pido ayuda? 
1. ls --help
2. man ls
3. info ls

Para movernos entre directorios utilizamos _cd_ (change directory) para entrar a las carpetas o _cd_ .. si queremos devolvernos. 

El tabulado también es una gran herramienta para moverse entre directorios pues nos va a permitir ver las que opciones de carpetas que tenemos antes de ejecutar el comando o también de autocompletar el nombre del archivo. 

Miremos ahora como podemos subir un archivo al cluster. Para ello podemos utilizar el comando _scp_ o podemos descargar aplicaciones como cyberduck o filezilla. Sin embargo es importante recordar que para subir o bajar archivos del cluster con comandos debemos estar por fuera del mismo. 

Primero, tienes que estar en la carpeta de la cual quieres sacar el archivo o en su defecto especificar la ruta completa de donde se encuentra. 
scp -P 22 <ruta/archivo> lvega@10.10.100.139 
Subir
scp -P 37022 <ruta_del_archivo> lvega@10.10.100.139:<ruta_de_donde_quiero_guardarlo>
Bajar
scp -r -P 37022  lvega@10.10.100.139:<ruta_del_archivo> <ruta_de_donde_quiero_guardarlo>

Para esto descarguemos un archivo del siguiente link con el comando _wget_ en linux o el siguiente comanto en windows:

iwr -uri https://raw.githubusercontent.com/SebastianSarmientoC/Bash/main/Paeruginosa_complete_genomes_annotated_2024_1.tsv -OutFile paeruginosa.tsv -UseBasicParsing

Ejemplo filezilla/cyberduck. 

Ya subidos lo archivos... 
Vamos a necesitar leerlos, para ello disponemos de varios comandos para este fin como: less, cat, head y tail. ¡Probemos cada uno!


Para copiar archivos de un lugar a otro pordemos utilizar _cp_. En dado caso que queramos mover los archivos (cortarlos) de un directorio a otro podemos utilizar el comando _mv_. 

Dentro del cluster también podremos crear archivos de texto. 
Creemos un archivo con el fin de moverlo a un directorio que también crearemos. Con el comando _echo_ que nos permite imprimir texto vamos a crear el archivo de la siguiente manera: _echo_ "Palabras al azar" > archivo.txt.
También podremos concatenar archivos con el comando _cat_. 
Creemos otro archivo con _echo_ "Más palabras al azar" > archivo2.txt. Y ahora concatenemos los dos archivos.  

En el caso que queramos adicionar texto en el archivo podemos utilizar el editor de texto prodeterminado llamado _nano_. El cual nos va a abrir un editor de texto. 

Para crear directorios utilizamos el comando _mkdir_ y para eliminarlos utilizamos _rmdir_ o _rm -rf_. 

Otro comando importante a la hora de utilizar bash es pipe _|_. Teniendo en cuenta que con el comando _cut_ podemos extrer columnas específicas de un archivo, corramos el siguiente comando _cut -f 5 Paeruginosa_complete_genomes_annotated_2024_1.tsv | sort_. ¿Qué hizo el comando? ¿Cómo creen que podemos guardar el output de este comando?  

(Con _sort -t' ' -k2 input_ podemos ordenar sin quitar las demás columnasdel archivo).

Pueden encontrar una lista resumen de estos comandos en esta dirección: [Link](https://www.reneshbedre.com/blog/linux-for-bioinformatics.html#getting-started-with-linux-commands)

Antes de ver otros comandos es MUY importante que antes de empezar a trabajar en nuestros proyectos, pidamos recursos y trabajemos sobre estos recursos. 
Para hacer esto utilizamos el comando _salloc_, que nos va a asignar automáticamente una cantidad de nucleos de acuerdo a la disponibilidad del cluster en ese momento.  

Ahora aprendamos como podemos filtrar nuestros archivos sin tener que modificarlos o incluso ingresar a ellos. Uno de los comandos que podemos utilizar para tal fin es _grep_, el cual busca patrones específicos en todo el archivo y los separa del resto. Por ejemplo, busquemos aquellos genomas que fueron secuenciados por PacBio, en el archivo descargado. 

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

Cómo harías si necesitaras unir las útimas dos columnas entonces. 
De igual manera que con _grep_ _sed_ permite utilizar expresiones regulares para buscar patrones en el archivo. 

sed -E 's/\t([0-9]{4})\t([0-9]+)/\t\1\t\2/g' Paeruginosa_complete_genomes_annotated_2024_1.tsv


En el cluster también es importante saber como utilizar los programas que allí tenemos instalados. 
Para ver los programas que se encuentran ya instalados podemos utilizar el comando _module avail_. 
Si queremos utilizar un programa, necesitamos cargarlo primero. Para ello utilizamos _module load <nombre del programa/versión>_
De esta manera, todas las funciones de dicho programa estarán disponibles para nosotros.

La instalación de los programas generalmente es hecha por el administrador, sin embargo, existe una herramienta que nos da la posibilidad de instalar programas y dependencias de manera independiente. Los ambientes o entornos virtuales de conda nos permiten instalar todo lo que se encuentre en anaconda. 

Conda
Cómo crear ambientes virtuales: 
_conda create --name py35env python=3.5_
Cómo activar dicho ambiente: 
_conda activate <nombre>_
Como ver que ambientes hay creados: 
_cond env list_
Como instalar algo en dicho ambiente: 
_conda install <nombre del paquete>_
Para saber que hay instalado en cada ambiente: 
_conda list_
Para desactivar el ambiente: 
_conda deactivate_
Para eliminar un ambiente: 
_conda env remove_

Aquí podemos encontrar una lista de los principales comando de conda:
[Conda cheat sheat](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf)



Ahora miremos como el cluster distribuye los recursos para maximizar el trabajo que puede realizar. Veamos que es SLURM. 









