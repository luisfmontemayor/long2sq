#!/usr/bin/awk -f 

BEGIN{
    FS=","
    OFS=","
    
    if (system("test -f " ARGV[1]) != 0){
        print "Error: Expected " ARGV[1] " to be a valid file. Please check and try again."
        exit 1
    }
}

NR == 1 {
    if (NF != 3) {
        print "Error: Expecting 3 fields, got " NF ". Please check and try again."> "/dev/stderr"
        exit 1
    }
        
    if ($3 ~ /^[0-9]+$/) {
        print "No header detected. Starting at line 1." > "/dev/stderr"
        
    } else {
        print "Header detected. Starting on line 2." > "/dev/stderr"
        next
    }
}

{
    if (!($1 in seen)){
        seen[$1]
        order[count++] = $1
    }
    
    if (!($2 in seen)){
        seen[$2]
        order[count++] = $2
    }
    
    output[$1][$2] = $3
    output[$2][$1] = $3

}


END{
    printf "%s", "key"
    for(i=0; i<count; i++){
        printf ",%s", order[i] 
    }
    printf "\n" 
    
    for(i=0; i<count; i++){
        row_key = order[i]
        printf "%s", row_key
        
        for(j=0; j<count; j++){
            col_key = order[j]
            
            if (row_key == col_key){
                val = "0"
                
            } else if (output[row_key][col_key] != "") {
                val = output[row_key][col_key]
                
            } else {
                print "BUG: no val for " col_key "and " row_key
                exit
            }            
            
            printf ",%s", val
        }
        
        printf "\n"
    }
}