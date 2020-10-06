# texlive-full-biber-docker

Latex and Biber to generate PDF

# Generate PDF with Biber 

* Uses Tex Live to generate code
  * Current version supports icons
* Run `pdflatex`, then `biber`, then `pdflatex`

Inputs: see `docker-compose.yaml` with possible env vars:

| Option | Description |
| ------ | ----------- |
| TEX_FILENAME=main | Name of the tex file. Say "main.tex". Running latexpdf might generate main.aux (if references are included set WITH_BIB=true) |
| WITH_BIB=true | If you have Bib references, just say so. |
| CLEAN_LATEX_LOGS=true | Clean the logs generated |
| RENAME_PDF_AS=marcello-desales-resume | Rename the final PDF with the name. Say "main.pdf -> RENAME_PDF_AS.pdf |

```yaml
version: "3.3"

services:

  tex_to_pdf:
    image: marcellodesales/texlive-full-biber
    working_dir: /resume
    environment:
      # Name of the tex file. Say "main.tex". Running latexpdf might generate main.aux (if references are included set WITH_BIB=true)
      - TEX_FILENAME=main
      # If you have Bib references, just say so.
      - WITH_BIB=true
      # Clean the logs generated
      - CLEAN_LATEX_LOGS=true
      # Rename the final PDF with the name. Say "main.pdf -> RENAME_PDF_AS.pdf
      - RENAME_PDF_AS=marcello-desales-resume
    volumes:
      - "${PWD}:/resume"
```

# Building Image

```
$ docker-compose build
Building tex_to_pdf
Step 1/5 : FROM thomasweise/docker-texlive-full
 ---> e929eef60cba
Step 2/5 : RUN apt-get update && apt-get install biber -y
 ---> Using cache
 ---> 1ec7828e3616
Step 3/5 : LABEL vendor=Open-source       com.github.marcellodesales.is-beta=false       com.github.marcellodesales.is-production=true       com.github.marcellodesales.version="1.0.0"       com.git"
 ---> Using cache
 ---> a1ac7424ee2f
Step 4/5 : COPY entrypoint.sh /entrypoint.sh
 ---> Using cache
 ---> 3aa29ad9ee30
Step 5/5 : ENTRYPOINT ["/usr/bin/bash", "/entrypoint.sh"]
 ---> Using cache
 ---> 7c18ed8633c6

Successfully built 7c18ed8633c6
Successfully tagged marcellodesales/texlive-full-biber:latest
```
