#!/bin/bash

echo "showing results from /etc/passwd"

awk 'BEGIN {

    FS=":";
    username="Username";
    userid="User ID";
    groupid="GroupID";
    home="Home";
    shell="Shell";
    print
    printf("| \033[34m%-15s\033[0m | \033[34m%-15s\033[0m | \033[34m%-15s\033[0m | \033[34m%-15s\033[0m | \033[34m%-15s\033[0m |\n", username,userid,groupid,home,shell);
    for(c=1;c<=91;c++) printf "-";
    printf "\n";
}

/\/bin\/bash/ {
    	printf("| \033[33m%-15s\033[0m | %-15s | %-15s | %-15s | %-15s | \n", $1, $3, $4, $6, $7);

}
END {
for(c=0;c<91;c++) printf "-";
print ""
}' /etc/passwd
