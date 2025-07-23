# JBrowse 2 Setup and Data Preparation

## About this Repository

This repository **already contains the necessary files from the JBrowse 2 web distribution**, which were downloaded using the official CLI tool (`@jbrowse/cli`).  
You can find more about the tool here: https://jbrowse.org/jb2/docs/

If you wish to regenerate or update these files, see instructions below.

## Prerequisites

Ensure the following tools are available in your system:

- **Samtools** – for indexing FASTA files (`.fai`) and generating `.gzi` files
- **Tabix** – for compressing and indexing GFF3 files (or BED/VCF) into `.gz` and `.tbi`
- **bgzip** – typically included with `htslib`, used for block compression

**Note:** If you already have the required `.gz`, `.fai`, `.gzi`, and `.tbi` files (e.g. downloaded or prepared elsewhere), you can skip the compression/indexing steps below.

## Install JBrowse CLI (Optional)

Only needed if you want to regenerate or update the current instance.

```bash
npm install -g @jbrowse/cli
```

Verify your installation:

```bash
jbrowse --version
```

Alternatively, you can use it with npx:

```bash
npx @jbrowse/cli --version
```

### A. Create an instance of JBrowse 2 (optional)

To generate the contents of the current folder from scratch:

```bash
jbrowse create jbrowse2
```

This downloads the latest version of jbrowse-web into the jbrowse2/ folder.

Expected contents:

```
asset-manifest.json
favicon.ico
index.html
manifest.json
robots.txt
static/
test_data/
version.txt
```

### B. Run web server

JBrowse 2 requires a web server to run (you cannot open index.html directly).

Serve with:

```bash
cd jbrowse2/
npx serve -l 5000 .
```

Then open your browser at: http://localhost:5000

## Preparation of GFF3 and FASTA files

These steps generate correctly compressed and indexed files required by JBrowse 2.

### A. GFF3

```bash
# Sort and compress
(
  grep '^#' jamapa_genes.gff3
  grep -v '^#' jamapa_genes.gff3 | sort -k1,1 -k4,4n
) | bgzip -c > jamapa_genes.sorted.gff3.gz

# Index with Tabix
tabix -p gff jamapa_genes.sorted.gff3.gz

```

Generated:

- `jamapa_genes.sorted.gff3.gz`
- `jamapa_genes.sorted.gff3.gz.tbi`

### B. FASTA

```bash
# Compress FASTA
bgzip -c jamapa_genome.fa > jamapa_genome.fa.gz

# Create .fai and .gzi indexes
samtools faidx jamapa_genome.fa.gz

```

Genera:

- `jamapa_genome.fa.gz`
- `jamapa_genome.fa.gz.fai`
- `jamapa_genome.fa.gz.gzi`

Browse 2 supports indexed and compressed FASTA files for genome assemblies.

## Configuration: `config.json`

JBrowse 2 uses a `config.json` file to define and display tracks, assemblies, and data sources.

**Important:** After generating your `.gz`, `.tbi`, `.fai`, and `.gzi` files, you must **update the `config.json` file** so JBrowse 2 can properly load and display your data.
