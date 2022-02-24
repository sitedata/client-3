#!/usr/bin/env bash

# $1 - GUI_TEST_REPORT_DIR
# $2 - DRONE_REPO
# $3 - DRONE_BUILD_NUMBER

# create a github comment file only if guiTestUpload Folder is not empty
if [[ $(find $1 -maxdepth 0 -empty) ]]; then
    echo "No test results to upload"
    echo "Exiting..."

else
    echo "creating comment for GUI log"
    # if there is index.html generated by squishrunner then create a comment indicating link of GUI result
    if [[ -f $1/index.html ]]; then
        echo ":boom: The GUI tests failed."
        echo "GUI Logs: (${CACHE_ENDPOINT}/${CACHE_BUCKET}/$2/$3/guiReportUpload/index.html)" >> $1/comments.file
    fi

    # if there is serverlog.log generated by squishserver then create a comment indicating link of server result
    if [[ -f $1/serverlog.log ]]; then
        echo "creating comment for server log"
        echo "Server Logs: (${CACHE_ENDPOINT}/${CACHE_BUCKET}/$2/$3/guiReportUpload/serverlog.log)" >> $1/comments.file
    fi
fi