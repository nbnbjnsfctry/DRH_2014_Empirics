

clear
set memory 12m
set matsize 250

use emp19502005.dta

foreach num of numlist 1950 1970 1980 1990 2000 2005 { 
	gen loginddens`num'=log(indemp`num'/area)
	gen logservdens`num'=log(servemp`num'/area)
	drop if loginddens`num'==.
	drop if logservdens`num'==.
	}
	
foreach num of numlist 1950 1970 1980 1990 2000 2005 { 
	sum loginddens`num'
	scalar sdind`num'=r(sd)
	_pctile loginddens`num', percentiles(30 70)
	scalar pc30ind`num'=r(r1)
	scalar pc70ind`num'=r(r2)
	scalar pc7030ind`num'=pc70ind`num'-pc30ind`num'
	}

foreach num of numlist 1950 1970 1980 1990 2000 2005 { 
	sum logservdens`num'
	scalar sdserv`num'=r(sd)
	_pctile logservdens`num', percentiles(30 70)
	scalar pc30serv`num'=r(r1)
	scalar pc70serv`num'=r(r2)
	scalar pc7030serv`num'=pc70serv`num'-pc30serv`num'	
	scalar sdindserv`num'=sdind`num'/sdserv`num'
	scalar pc7030indserv`num'=pc7030ind`num'/pc7030serv`num'
	}
	 
display sdind1950 
display sdind1970 
display sdind1980 
display sdind1990
display sdind2000 
display sdind2005  	 

display sdserv1950 
display sdserv1970 
display sdserv1980
display sdserv1990 
display sdserv2000 
display sdserv2005  	

display sdindserv1950 
display sdindserv1970 
display sdindserv1980
display sdindserv1990 
display sdindserv2000 
display sdindserv2005  
 
	 
display pc7030ind1950
display pc7030ind1970
display pc7030ind1980
display pc7030ind1990
display pc7030ind2000
display pc7030ind2005

display pc7030serv1950
display pc7030serv1970
display pc7030serv1980
display pc7030serv1990
display pc7030serv2000
display pc7030serv2005

display pc7030indserv1950
display pc7030indserv1970
display pc7030indserv1980
display pc7030indserv1990
display pc7030indserv2000
display pc7030indserv2005

