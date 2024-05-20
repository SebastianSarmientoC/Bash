#!/bin/bash
#SBATCH -J Mi_trabajo
#SBATCH -N 1 # Numero de nodos
#SBATCH -n 1 # Numero de nucleos
#SBATCH -t 0-00:10 # limite de tiempo (D-HH:MM)
#SBATCH -o salida.out # Salida STDOUT
#SBATCH -e error.err # Salida STDERR
#SBATCH --mail-user=juans.sarmiento@urosario.edu.co #Direccion e-mail a donde notificar el estado del trabajo
#SBATCH --mail-type=END	#Especifica que eventos notificar al correo (ALL, BEGIN, END, REQUEUE, FAIL)

docker pull biocontainers/sickle:v1.33git20150314.f3d6ae3-1-deb_cv1

docker run -v $(pwd):/working-dir -w /working-dir biocontainers/sickle:v1.33git20150314.f3d6ae3-1-deb_cv1 sickle pe -f P7741_R1.fastq.gz -r P7741_R2.fastq.gz -t sanger -q 20 -l 20 -g -o trimmed_R1.fasta.gz -p trimmed_R2.fasta.gz -s trimmed_S.fasta.gz
