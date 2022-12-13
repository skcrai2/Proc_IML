PROC IMPORT OUT= weight 
DATAFILE= 'file location/Weight.txt' 
DBMS=TAB REPLACE; 
GETNAMES=NO; 
DATAROW=2; 
guessingrows=100; 
RUN;
 
DATA weight; 
SET WEIGHT; 
RENAME 	Var1=Age 
Var2=Weight; 
run; 

Proc Reg data = weight; 
model weight=age; 
run; 

proc iml; * Read data into IML ; 
use weight; 
read all var {Weight} into y ; 
read all var {Weight Age} into x; 
x[,1]=1; 
j=j(40,40,1); 
i=I(40); 
nx=nrow(x); ** create the intercept vector; 
beta=(inv(x`*x))*x`*y; 
SST=y`*(i-(1/nx)*j)*y; 
SSE=y`*(i-x*(inv(x`*x))*x`)*y; 
SSR=SST-SSE; 
Print beta SST SSE SSR; 
quit; 
