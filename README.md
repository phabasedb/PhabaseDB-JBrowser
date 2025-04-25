## Descarga e instalación de JBrowse 2

Antes de empezar, asegúrate de tener en tu sistema las siguientes herramientas:

- **Samtools** (para creación de índices FASTA y procesar BAM/CRAM)
- **tabix** (para crear índices TABIX de BED/VCF/GFF)

### 1. Instalar el CLI de JBrowse

Para gestionar tu instancia de JBrowse 2:

```bash
npm install -g @jbrowse/cli
```

Verifica la instalacion con:

```bash
jbrowse --version
```

Nota. Si prefieres no instalar globalmente, usa npx @jbrowse/cli --version

### 2. Crear una nueva instancia

En el directorio donde quieras JBrowse 2, ejecuta:

```bash
jbrowse create jbrowse2
```

Esto descarga la última versión de jbrowse-web y la descomprime en ./jbrowse2

### 3. Verificar la descarga

La carpeta jbrowse2/ debería tener al menos:

```bash
asset-manifest.json
favicon.ico
index.html
manifest.json
robots.txt
static/
test_data/
version.txt
```

### 4. Correr el servidor web

JBrowse 2 **requiere** un servidor HTTP; no funciona abriendo `index.html` directamente :contentReference[oaicite:7]{index=7}.
Para servirlo en el puerto 5000:

```bash
cd jbrowse2/
npx serve -l 5000 .
```

Luego abre en tu navegador: http://localhost:5000

## Generación e indexado de archivos GFF3 y FASTA

A continuación se muestran los pasos para comprimir e indexar tus datos sin dejar archivos intermedios innecesarios.

### A. GFF3

```bash
# Ordena y comprime directamente:
(
  grep '^#' jamapa_genes.gff3
  grep -v '^#' jamapa_genes.gff3 | sort -k1,1 -k4,4n
) | bgzip -c > jamapa_genes.sorted.gff3.gz

# Crea índice .tbi
tabix -p gff jamapa_genes.sorted.gff3.gz0
```

Genera:

- `jamapa_genes.sorted.gff3.gz`
- `jamapa_genes.sorted.gff3.gz.tbi`

### B. FASTA

```bash
# Comprime con bgzip
bgzip -c jamapa_genome.fa > jamapa_genome.fa.gz

# Indexa con samtools faidx
samtools faidx jamapa_genome.fa.gz
```

Genera:

- `jamapa_genome.fa.gz`
- `jamapa_genome.fa.gz.fai`
- `jamapa_genome.fa.gz.gzi`

JBrowse 2 también soporta FASTA comprimidos con bgzip e indexados para ensamblajes

### Requisitos finales

Verifica que los comandos estén disponibles en tu $PATH:

````bash
which bgzip
which tabix
which samtools
which jbrowse
which npx
```
````
