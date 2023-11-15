

mkdir -p res/genome
wget -O res/genome/ecoli.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz

gunzip res/genome/ecoli.fasta.gz

echo "Running STAR index..."
mkdir -p res/genome/star_index
STAR --runThreadN 4 --runMode genomeGenerate \
--genomeDir res/genome/star_index/ \
--genomeFastaFiles res/genome/ecoli.fasta \
--genomeSAindexNbases 9

for $sampleid in $(ls data/*.fastq.gz | cut -d"_" -f1 | sed "s:data/::" | sort | uniq)
do
    bash analyse_sample.sh data/${sampleid}_1
    bash analyse_sample.sh data/${sampleid}_2
done
