## Excede a jbrowse2 y Ejecutar comando, usara el puerto 5000

```bash
npx serve -l 5000 .


```

# Generación e indexado de archivos GFF3 y FASTA

Este README describe los pasos para ordenar, comprimir e indexar los archivos GFF3 y FASTA correspondientes.

## Pasos para GFF3

```bash
(
  grep '^#' jamapa_genes.gff3
  grep -v '^#' jamapa_genes.gff3 | sort -k1,1 -k4,4n
) | bgzip -c > jamapa_genes.sorted.gff3.gz

tabix -p gff jamapa_genes.sorted.gff3.gz
```

De esta forma solo generas:

jamapa_genes.sorted.gff3.gz
jamapa_genes.sorted.gff3.gz.tbi

y no ocupas espacio extra con el .sorted.gff3 sin comprimir.

## Pasos para FASTA

Comprime con bgzip:

```bash
bgzip -c jamapa_genome.fa > jamapa_genome.fa.gz

```

Crea índices .fai y .gzi:

```bash
samtools faidx jamapa_genome.fa.gz

```

Esto genera:

jamapa_genome.fa.gz

jamapa_genome.fa.gz.fai

jamapa_genome.fa.gz.gzi

## Requisitos

which bgzip
which tabix
which samtools
