# Bash, Conda, Docker, SLURM

Breve introducción a bash shell

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
Creemos otro archivo con _echo_ "Más palabras al azar" > archivo2.txt. 
Y ahora concatenemos los dos archivos.  
¿Quedó guardado el archivo? 

En el caso que queramos adicionar texto en el archivo podemos utilizar el editor de texto prodeterminado llamado _nano_. 
¿Abramos el editor con el archivo concatenado que creamos? 

Para crear directorios utilizamos el comando _mkdir_ y para eliminarlos utilizamos _rmdir_ o _rm -rf_. 
Creemos un directorio e ingresemos a él.   

Otro comando importante a la hora de utilizar bash es pipe _|_. 
Teniendo en cuenta que con el comando _cut_ podemos extrer columnas específicas de un archivo, corramos el siguiente comando _cut -f 5 Paeruginosa_complete_genomes_annotated_2024_1.tsv_. 
Ahora corramos el sieguiente comando: _cut -f 5 Paeruginosa_complete_genomes_annotated_2024_1.tsv | sort_
¿Qué hizo el comando? ¿Cómo creen que podemos guardar el output de este comando?  

(Con _sort -t' ' -k2 input_ podemos ordenar sin quitar las demás columnas del archivo).

Pueden encontrar una lista resumen de estos comandos en esta dirección: [Link](https://www.reneshbedre.com/blog/linux-for-bioinformatics.html#getting-started-with-linux-commands)

Antes de ver otros comandos es MUY importante que antes de empezar a trabajar en nuestros proyectos, pidamos recursos y trabajemos sobre estos recursos. 
Para hacer esto utilizamos el comando _salloc_, que nos va a asignar automáticamente una cantidad de nucleos de acuerdo a la disponibilidad del cluster en ese momento.  

Ahora aprendamos como podemos filtrar nuestros archivos sin tener que modificarlos o incluso ingresar a ellos. Uno de los comandos que podemos utilizar para tal fin es _grep_, el cual busca patrones específicos en todo el archivo y los separa del resto. Por ejemplo, busquemos aquellos genomas que fueron secuenciados por PacBio, en el archivo descargado. 

_grep 'PacBio' Paeruginosa_complete_genomes_annotated_2024_1.tsv_
Los archivos GCA indican la copia del ensamblaje de GenBank, y los archivos GCF indican la copia usada para la anotación de genes en RefSeq.
¿Cómo harían para obtener sólo los números de accesión de los archivos RefSeq? 

Por ejemplo también podríamos querer buscar un número de accesión en particular como este: ASM3623206v1. 
O incluso dos, en cuyo caso tendríamos que correr el comando dos veces o utilizar expresiones regulares. ASM3623367v1. Para hacer esto necesitamos utilizar _-e_

_grep -e ASM3623206v1|ASM3623367v1 Paeruginosa_complete_genomes_annotated_2024_1.tsv_
OTRA PREGUNTA

_grep_ posee muchas otras funciones como por ejemplo contar la cantidad de coincidencias con el patrón (_-c_) o separar aquellas coincidencias del archivo original (_-o_), entre muchas otras que puedes explorar con las ayudas. 

_awk_ también nos ayuda a obtener las filas por separado. 
Utilizando awk '{ print $1 "\t" $2 }' Paeruginosa_complete_genomes_annotated_2024_1.tsv
Pero también nos permite hacer operaciones entre columnas de la siguiente forma. 
_awk '$7 + $8 > 6000' Pauriginosa_complete_genomes_annotated_2024_1.tsv_

Ahora ya sabes como buscar patrones, números o palabras específicas dentro de los archivos. 
Pero, ¿que utilizarías si además de filtrar los archivos también quieres modificar el texto o las columnas? 
Para tal propósito podemos utilizar el comando _sed_. 

Por ejemplo, si quisieramos quitar los espacios entre el género y el epíteto de la especies en la base de datos, podríamos utilizar: 

_sed 's/Pseudomonas aeruginosa/Pseudomonas_aeruginosa/' Paeruginosa_complete_genomes_annotated_2024_1.tsv_

De igual manera que con _grep_ _sed_ permite utilizar expresiones regulares para buscar patrones en el archivo. 

Al igual que en R o python aquí también podemos crear variables, funciones y loops.   
Crear variables: _var1=56_  
Para llamar a esa variable debemos utilizar el signo _$_, de la siguiente manera.   
_$var1_ Ahora sí podemos imprimirla: _echo $var1_  
  
Corramos esto:  
count=$(seq -s " " 2 2 10)  
echo $count  
for i in $count; do  
 echo $i > "file_$i.txt";  
done  

¿Qué hizo?


En el cluster también es importante saber como utilizar los programas que allí tenemos instalados. 
Para ver los programas que se encuentran ya instalados podemos utilizar el comando _module avail_. 
Si queremos utilizar un programa, necesitamos cargarlo primero. Para ello utilizamos _module load <nombre del programa/versión>_
De esta manera, todas las funciones de dicho programa estarán disponibles para nosotros.


La instalación de los programas generalmente es hecha por el administrador, sin embargo, existe una herramienta que nos da la posibilidad de instalar programas y dependencias de manera independiente. 
Los ambientes o entornos virtuales de conda nos permiten instalar todo lo que se encuentra en anaconda [Package index](https://bioconda.github.io/conda-package_index.html). 

Creemos el siguiente ambiente (si hay tiempo): 

Conda  
Para crear ambientes virtuales:   
_conda create --name py35env python=3.5 bwa_  
Para activar dicho ambiente:  
_conda activate <nombre>_  
Para ver que ambientes hay creados:   
_cond env list_  
Para instalar algo en dicho ambiente:   
_conda install <nombre_del_paquete>_  
Para saber que hay instalado en cada ambiente:   
_conda list_  
Para desactivar el ambiente:   
_conda deactivate_  
Para eliminar un ambiente:   
_conda env remove <nombre_entorno>_  

Aquí podemos encontrar una lista de los principales comando de conda:  
[Conda cheat sheat](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf)  
  
Por ejemplo, corramos un alineamiento sobre la secuencias del gen 16S de Pseudomonas aeruginosa que vamos a encontrar en la carpeta Principal de la   primera_capacitación. Activemos el entorno: py3env y utilicemos el alineador mafft para hacerlo con el siguiente comando:   
_mafft --thread -1 sequence.fasta > paeruginosa_alignment.fasta_  
Mirémoslo con less o cat para ver si funcionó.   

Otra ayuda que podemos tener a la hora de instalar programas es Docker. Presentación.   
Con este vamos a poder utilizar todos los programas que estén disponibles como imágenes en Docker Hub o en Quay.io.  
  
Para descargar imágenes:   
_docker pull sickle:<tag>(¿qué versión? Ir a Docker hub)_  
  
En el caso de que ya tengamos una imágen y queramos subirla, tenemos que cargarla antes de crear el contenedor:  
_docker load _imagen.tar_   
  
Como correrlo abriendo el modo interactivo:  
_docker run -i -t --name sickle -v  <ruta_de_los_archivos_dentro_del_cluster>:/working-dir sickle/<versión>_  
... luego escribes los comandos que quieres ejecutar.  
  
Como correrlo sin tener que abrir el modo interactivo:   
_docker run -v <dirección en el cluster>:/working-dir -w /working-dir biocontainers/sickle:<versión> sickle pe_       
_docker run -v $(pwd):/working-dir -w /working-dir biocontainers/sickle:<versión> sickle pe_       
  
Como guardar imágenes para compartirlas:   
_docker save biocontainers/sickle:<versión>_  


Finalmente, miremos como el cluster distribuye los recursos para maximizar el trabajo que puede realizar. Veamos que es SLURM. 
Corramos el archivo .sh que contiene las instrucciones para correr un script de python.   


Ejemplo final:     
conda config --show channels  
conda config --add channels conda-forge  
conda config --add channels bioconda  
conda create -n variants bwa bcftools samtools sickle python biopython  

conda activate variants  

sickle pe  
sickle pe -f P7741_R1.fastq.gz -r P7741_R2.fastq.gz -t sanger -q 20 -l 20 -g -o trimmed_R1.fasta.gz -p trimmed_R2.fasta.gz -s trimmed_S.fasta.gz  
mv Agy99.fasta ./ref/  
bwa index ref/Agy99.fasta  (crea la referencia)
bwa mem ref/Agy99.fasta trimmed_R1.fasta.gz trimmed_R2.fasta.gz > output.sam  (alinea a la referencia)  
samtools view -S -b output.sam > output.bam  (convertir a bam)  
samtools sort -o output.sorted.bam output.bam  
samtools flagstat output.sorted.bam > mappingstats.txt  
bcftools mpileup -O b -o raw.bcf -f ref/Agy99.fasta -q 20 -Q 30 output.sorted.bam (información sobre variantes)  
bcftools call --ploidy 1 -m -v -o variants.raw.vcf raw.bcf  (crear el vcf)  
grep -v -c '^#' variants.raw.vcf  (contar totalidad de variantes)  

bcftools view -v snps variants.raw.vcf | grep -v -c '^#'  

bcftools view -v indels variants.raw.vcf | grep -v -c '^#'  

bcftools query -f '%POS\n' variants.raw.vcf >pos.txt  

head pos.txt  






