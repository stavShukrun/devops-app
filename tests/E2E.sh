#!bin/bash

curl $1:$2
curl -X POST -F 'username= stav' 'password= 123456' $1:$2