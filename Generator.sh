#!/bin/bash

Name="howareyou"
CPU="i18cpu"
NodeNum=4

#cd /work/k0409/k040901/$Name/

echo "#!/bin/sh
#QSUB -queue $CPU
#QSUB -node $NodeNum

cd \${PBS_O_WORKDIR}
. /etc/profile.d/modules.sh
module purge
module load intel
module load intel-mpi
QE_DIR=/home/k0409/k040901/qe-6.1
Calc_DIR=/home/k0409/k040901/$Name
mpijob \$QE_DIR/bin/pw.x <\$Calc_DIR/$Name.pw_scf.in> \$Calc_DIR/$Name.pw_scf.out -ni 8 -nk 4">subpw_scf.sh

#Generate qsub for pw_bands
echo "#!/bin/sh
#QSUB -queue $CPU
#QSUB -node $NodeNum

cd \${PBS_O_WORKDIR}
. /etc/profile.d/modules.sh
module purge
module load intel
module load intel-mpi
QE_DIR=/home/k0409/k040901/qe-6.1
Calc_DIR=/home/k0409/k040901/$Name
mpijob \$QE_DIR/bin/pw.x <\$Calc_DIR/$Name.pw_bands.in> \$Calc_DIR/$Name.pw_bands.out -ni 8 -nk 4">subpw_bands.sh

#Generate qsub for bands.x
echo "#!/bin/sh
#QSUB -queue $CPU
#QSUB -node $NodeNum

cd \${PBS_O_WORKDIR}
. /etc/profile.d/modules.sh
module purge
module load intel
module load intel-mpi
QE_DIR=/home/k0409/k040901/qe-6.1
Calc_DIR=/home/k0409/k040901/$Name
mpijob \$QE_DIR/bin/bands.x <\$Calc_DIR/$Name.bands.in> \$Calc_DIR/$Name.bands.out -ni 8 -nk 4">subbands.sh