#!/bin/bash
#SBATCH -N 1 # Numero de nodos
#SBATCH -n 1 # Numero de nucleos
#SBATCH -t 0-00:10 # limite de tiempo (D-HH:MM)
#SBATCH -o salida.out # Salida STDOUT
#SBATCH -e error.err # Salida STDERR
#SBATCH --mail-user=juans.sarmiento@urosario.edu.co #Direccion e-mail a donde notificar el estado del trabajo
#SBATCH --mail-type=END	#Especifica que eventos notificar al correo (ALL, BEGIN, END, REQUEUE, FAIL)

# Load any modules you need, here Python 3.11.8.
module load python

# Run your Python script
python script.py
