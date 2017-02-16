# XML Publisher Data Definition - Download
# Download
FNDLOAD apps/apps 0 Y DOWNLOAD $XDO_TOP/patch/115/import/xdotmpl.lct xxopm_b194.ldt XDO_DS_DEFINITIONS APPLICATION_SHORT_NAME=XXOPM DATA_SOURCE_CODE=XXOPM_B194

# XML Publisher Data Definition - Upload
FNDLOAD apps/apps 0 Y UPLOAD $XDO_TOP/patch/115/import/xdotmpl.lct $basedir/fnd/US/xxopm_b194.ldt

# XML Publisher RTF Template - Upload
java oracle.apps.xdo.oa.util.XDOLoader UPLOAD -DB_USERNAME APPS -DB_PASSWORD $APPSPWD -JDBC_CONNECTION $JDBC_CON -LOB_TYPE TEMPLATE -APPS_SHORT_NAME XXOPM -LOB_CODE XXOPM_B194 -LANGUAGE en -TERRITORY US -XDO_FILE_TYPE RTF -FILE_NAME $basedir/template/US/XXOPM_B194.rtf -OWNER APPS -CUSTOM_MODE FORCE


# Concurrent request - Download
FNDLOAD apps/apps O Y DOWNLOAD $FND_TOP/patch/115/import/afcpprog.lct xxopm_b194_concurrent.ldt PROGRAM APPLICATION_SHORT_NAME=XXOPM CONCURRENT_PROGRAM_NAME=XXOPM_B194