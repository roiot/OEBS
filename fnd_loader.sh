# -----------------------------------
# Download for several Languages
# select language_code, nls_language||'_'||nls_territory from fnd_languages where installed_flag not in ('D')

#!/usr/bin/bash
NLS_LANG_OLD=$NLS_LANG

#SetNLSUTF8 Russian_CIS
export NLS_LANG=Russian_CIS.UTF8
FNDLOAD apps/apps O Y DOWNLOAD $FND_TOP/patch/115/import/aflvmlu.lct XX_CUSTOM_LKP.ldt FND_LOOKUP_TYPE APPLICATION_SHORT_NAME="XXCUST" LOOKUP_TYPE="XX_LOOKUP_TYPE"

#SetNLSUTF8 American_America
export NLS_LANG=American_America.UTF8
FNDLOAD apps/apps O Y DOWNLOAD $FND_TOP/patch/115/import/aflvmlu.lct XX_CUSTOM_LKP.ldt FND_LOOKUP_TYPE APPLICATION_SHORT_NAME="XXCUST" LOOKUP_TYPE="XX_LOOKUP_TYPE"

export NLS_LANG=$NLS_LANG_OLD

# -----------------------------------
# XML Publisher Data Definition - Download
FNDLOAD apps/apps 0 Y DOWNLOAD $XDO_TOP/patch/115/import/xdotmpl.lct xxopm_b194.ldt XDO_DS_DEFINITIONS APPLICATION_SHORT_NAME=XXOPM DATA_SOURCE_CODE=XXOPM_B194

# XML Publisher Data Definition - Upload
FNDLOAD apps/apps 0 Y UPLOAD $XDO_TOP/patch/115/import/xdotmpl.lct $basedir/fnd/US/xxopm_b194.ldt


# -----------------------------------
# XML Publisher RTF Template - Upload
java oracle.apps.xdo.oa.util.XDOLoader UPLOAD -DB_USERNAME APPS -DB_PASSWORD $APPSPWD -JDBC_CONNECTION $JDBC_CON -LOB_TYPE TEMPLATE -APPS_SHORT_NAME XXOPM -LOB_CODE XXOPM_B194 -LANGUAGE en -TERRITORY US -XDO_FILE_TYPE RTF -FILE_NAME $basedir/template/US/XXOPM_B194.rtf -OWNER APPS -CUSTOM_MODE FORCE


# -----------------------------------
# Concurrent request - Download
FNDLOAD apps/apps O Y DOWNLOAD $FND_TOP/patch/115/import/afcpprog.lct xxopm_b194_concurrent.ldt PROGRAM APPLICATION_SHORT_NAME=XXOPM CONCURRENT_PROGRAM_NAME=XXOPM_B194


# -----------------------------------
# Lookup - Download
FNDLOAD apps/apps O Y DOWNLOAD $FND_TOP/patch/115/import/aflvmlu.lct XX_CUSTOM_LKP.ldt FND_LOOKUP_TYPE APPLICATION_SHORT_NAME="XXCUST" LOOKUP_TYPE="XX_LOOKUP_TYPE"