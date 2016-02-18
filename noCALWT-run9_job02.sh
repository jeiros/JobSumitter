#PBS -lselect=1:ncpus=1:ngpus=1:mem=1000mb:gpu_type=K80
#PBS -q gpgpu
#PBS -M je714@ic.ac.uk
#PBS -m abe

module load cuda/6.5.19

prmtop=noCAL_WT-ff14SB_25-20-35Abox_hmr.prmtop
sim=0009-0018

prevrst=noCALWT-run9_0000-0009ns.rst
prevsim=0000-0009
cd /tmp/pbs.${PBS_JOBID}
cp /work/je714/noCAL_WT/run9/05_Prod.in .
cp /work/je714/noCAL_WT/run9/${prevrst} .
cp /work/je714/noCAL_WT/run9/${prmtop} .

pbsexec -grace 15 /home/igould/pmemd.cuda_SPFP -O -i 05_Prod.in -o noCALWT-run9_${sim}ns.out -c ${prevrst} -p ${prmtop} -r noCALWT-run9_${sim}ns.rst -x noCALWT-run9_${sim}ns.nc

cp /tmp/pbs.${PBS_JOBID}/noCALWT-run9_${sim}ns.rst /work/je714/noCAL_WT/run9/
rm /tmp/pbs.${PBS_JOBID}/${prevrst}
tar -zcvf /work/je714/noCAL_WT/run9/results/noCALWT-run9_${sim}ns.tgz *

scp /work/je714/noCAL_WT/run9/results/noCALWT-run9_${sim}ns.tgz je714@ch-knuth.ch.ic.ac.uk:/Users/je714/Troponin/IAN_Troponin/completehowarthcut/noCAL_WT/run9/
