#!/bin/bash
#SBATCH -N 1 # Numero de nodos
#SBATCH -n 1 # Numero de nucleos
#SBATCH -t 0-10:00 # limite de tiempo (D-HH:MM)
#SBATCH -o salida.out # Salida STDOUT
#SBATCH -e error.err # Salida STDERR
#SBATCH --mail-user=juans.sarmiento@urosario.edu.co #Direccion e-mail a donde notificar el estado del trabajo
#SBATCH --mail-type=ALL	#Especifica que eventos notificar al correo (ALL, BEGIN, END, REQUEUE, FAIL)

module load R/4.2.0

Rscript phrapl.R
