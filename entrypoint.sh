!#/usr/bin/bash

LOG_PREFIX="🐳 AltaCV:"

: ${TEX_FILENAME:?"${LOG_PREFIX} Need to set TEX_FILENAME with only the tex file name without extension"}

echo ""
echo "${LOG_PREFIX} Executing pdflatex '${TEX_FILENAME}.tex'"
pdflatex ${TEX_FILENAME}.tex

if [ $? -gt 0 ]; then
  echo "${LOG_PREFIX} Can't process pdflatex for the first tiem (exit $?). See results above!"
  exit $?
fi

if [ ! -z "${WITH_BIB}" ]; then
  echo ""
  echo "${LOG_PREFIX} Executing biber '${TEX_FILENAME}'"
  biber ${TEX_FILENAME}
  
  if [ $? -gt 0 ]; then
    echo "${LOG_PREFIX} Can't process biber (exit $?). See results above!"
    exit $?
  fi
fi

echo ""
echo "${LOG_PREFIX} Executing pdflatex ${TEX_FILENAME}.tex"
pdflatex ${TEX_FILENAME}.tex

if [ $? -gt 0 ]; then
  echo ""
  echo "${LOG_PREFIX} Can't generate final pdf with pdflatex (exit $?). See results above!"
  exit $?
fi

echo ""
echo "Done."

if [ ! -z "${CLEAN_LATEX_LOGS}" ]; then
  echo ""
  echo "${LOG_PREFIX} Cleaning logs since env var 'CLEAN_LATEX_LOGS' is set."
  rm -f ${TEX_FILENAME}.aux ${TEX_FILENAME}.bbl ${TEX_FILENAME}.bcf pdfa.xmpi\
        ${TEX_FILENAME}.blg ${TEX_FILENAME}.log ${TEX_FILENAME}.out ${TEX_FILENAME}.run.xml
fi

if [ ! -z "${RENAME_PDF_AS}" ]; then
  echo ""
  echo "${LOG_PREFIX} Renaming PDF from ${TEX_FILENAME}.pdf as ${RENAME_PDF_AS}.pdf"
  mv ${TEX_FILENAME}.pdf ${RENAME_PDF_AS}.pdf
fi
