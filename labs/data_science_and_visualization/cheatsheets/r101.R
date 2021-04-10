#!/usr/bin/Rscript

system("clear")

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN_ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[0;37m'
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

cat(paste0(LIGHT_RED,"R 101 CHEATSHEET\n",NC))

disp_packages = function(){

	###INSTALL PACKAGES
	cat(paste0(LIGHT_BLUE,"\n###INSTALL PACKAGES\n\n",NC))
	cat(paste0(GREEN,'install.packages("dplyr")\n',NC))
	cat(paste0(GREEN,'install.packages("readr")\n',NC))
	cat(paste0(GREEN,'install.packages("tidyr")\n',NC))
	cat(paste0(GREEN,'install.packages("ggplot2")\n',NC))

}

disp_basictypes = function(){

	###BASIC TYPES
	cat(paste0(LIGHT_BLUE,"\n###BASIC TYPES\n",NC))

	##VECTORS
	cat(paste0(YELLOW,"\n##VECTORS\n",NC))
	cat(paste0(BROWN_ORANGE,"- allows to store elements of the same type\n",NC))
	cat(paste0(BROWN_ORANGE,"- basic operations: c, length, seq, rep, logical indexing\n",NC))
	cat(paste0(BROWN_ORANGE,"- numbering starts at 1! \n",NC))
	#vectors
	cat(paste0(RED,"#vectors\n",NC))
	cat(paste0(GREEN,'a = c(1,5,10); class(a)\n',NC)); a = c(1,5,10); print(class(a))
	#character vectors
	cat(paste0(RED,"#character vectors\n",NC))
	cat(paste0(GREEN,'b = c("a","g","t","c","g"); class(b)\n',NC)); b = c("a","g","t","c","g"); print(class(b))
	#basic operations
	cat(paste0(RED,"#basic operations\n",NC))
	cat(paste0(GREEN,'length(a)\n',NC)); print(length(a))
	cat(paste0(GREEN,'a[1:2]\n',NC)); print(a[1:2])
	cat(paste0(GREEN,'i = 1:2; a[i]\n',NC)); i = 1:2; print(a[i])
	cat(paste0(GREEN,'i = (b=="g"); b[i]\n',NC)); i = (b=="g"); print(b[i])
	cat(paste0(GREEN,'i = seq(1,length(b),2); b[i]\n',NC)); i = seq(1,length(b),2); print(b[i])
	cat(paste0(GREEN,'rep(1.5); b[i]\n',NC)); i = rep(1.5); print(b[i])
	cat(paste0(GREEN,'i = rep(c(1,2),5); b[i]\n',NC)); i = rep(c(1,2),5); print(b[i])
	cat(paste0(GREEN,'i = rep(c(1,2),each=3); b[i]\n',NC)); i = rep(c(1,2),each=3); print(b[i])

	##FACTORS
	cat(paste0(YELLOW,"\n##FACTORS\n",NC))
	cat(paste0(BROWN_ORANGE,"- special type of vectors for coding categorical variables “the levels”.\n",NC))
	cat(paste0(BROWN_ORANGE,"- basic operations: c, length, levels, unclass\n",NC))
	cat(paste0(BROWN_ORANGE,"- ! interpretation of strings as factors when creating a data.frame \n",NC))
	#basic operations
	cat(paste0(RED,"#basic operations\n",NC))
	cat(paste0(GREEN,'b = c("a","g","t","c","g")\n',NC)); b = c("a","g","t","c","g")
	cat(paste0(GREEN,'c = factor(b,levels=c("a","t","g","c")); levels(c)\n',NC)); c = factor(b,levels=c("a","t","g","c")); print(levels(c)) 
	cat(paste0(GREEN,'unclass(c)\n',NC)); print(unclass(c))

	##MATRIX
	cat(paste0(YELLOW,"\n##MATRIX\n",NC))
	cat(paste0(BROWN_ORANGE,"- allows to store elements of the same type\n",NC))
	cat(paste0(BROWN_ORANGE,"- basic operations: dim, rbind, cbind, logical indexing \n",NC))
	#integer matrix
	cat(paste0(RED,"#integer matrix\n",NC))
	cat(paste0(GREEN,'a = matrix(c(1,5,10,10),2,2)\n',NC)); a = matrix(c(1,5,10,10),2,2)
	#string matrix
	cat(paste0(RED,"#string matrix\n",NC))
	cat(paste0(GREEN,'b = rbind(c("a","g"),c("t","t"),c("c","g"))\n',NC)); b = rbind(c("a","g"),c("t","t"),c("c","g"))
	cat(paste0(GREEN,'c = cbind(c("a","g"),c("t","t"),c("c","g"))\n',NC)); c = cbind(c("a","g"),c("t","t"),c("c","g"))
	#basic operations
	cat(paste0(RED,"#basic operations\n",NC))
	cat(paste0(GREEN,'b\n',NC)); print(b)
	cat(paste0(GREEN,'dim(b)\n',NC)); print(dim(b))
	cat(paste0(GREEN,'t(b)\n',NC)); print(t(b))
	cat(paste0(GREEN,'dim(t(b))\n',NC)); print(dim(t(b)))
	cat(paste0(GREEN,'a[1,]\n',NC)); print(a[1,])
	cat(paste0(GREEN,'b[,2]\n',NC)); print(b[,2])
	cat(paste0(GREEN,'c[c[,1]=="a",]\n',NC)); print(c[c[,1]=="a",])

	##ARRAYS
	cat(paste0(YELLOW,"\n##ARRAYS\n",NC))
	cat(paste0(BROWN_ORANGE,"- allows to store elements of the same type\n",NC))
	cat(paste0(BROWN_ORANGE,"- basic operations: dim, logical indexing \n",NC))
	#tensor 3 dimensions
	cat(paste0(RED,"#tensor 3 dimensions\n",NC))
	cat(paste0(GREEN,'a = array(runif(50),dim=c(5,5,2))\n',NC)); a = array(runif(50),dim=c(5,5,2))
	cat(paste0(GREEN,'a[1,,]\n',NC)); print(a[1,,])
	cat(paste0(GREEN,'a[,5,]\n',NC)); print(a[,5,])
	cat(paste0(GREEN,'a[,2,1]\n',NC)); print(a[,2,1])

	##LISTS
	cat(paste0(YELLOW,"\n##LISTS\n",NC))
	cat(paste0(BROWN_ORANGE,"- allows to store elements of different types\n",NC))
	cat(paste0(BROWN_ORANGE,"- basic operations: length, c\n",NC))
	#basic operations
	cat(paste0(RED,"#basic operations\n",NC))
	cat(paste0(GREEN,'l = list(a,b,c)\n',NC)); l = list(a,b,c)
	cat(paste0(GREEN,'length(l)\n',NC)); print(length(l))
	cat(paste0(GREEN,'l[[2]]\n',NC)); print(l[[2]])
	cat(paste0(GREEN,'l = list(a=a,b=b,c=c)\n',NC)); l = list(a=a,b=b,c=c)
	cat(paste0(GREEN,'l$c\n',NC)); print(l$c)

	##DATA.FRAME
	cat(paste0(YELLOW,"\n##DATA.FRAME\n",NC))
	cat(paste0(BROWN_ORANGE,"- allows to store elements of different types\n",NC))
	cat(paste0(BROWN_ORANGE,"- = list of named vectors indexable and manipulable as a matrix\n",NC))
	cat(paste0(BROWN_ORANGE,"- basic operations: dim, cbind, rbind, names, summary \n",NC))
	#basic operations
	cat(paste0(RED,"#basic operations\n",NC))
	cat(paste0(GREEN,'d = data.frame(v1=rep("a",10),v2=1:10,v3=runif(10))\n',NC)); d = data.frame(v1=rep("a",10),v2=1:10,v3=runif(10))
	cat(paste0(GREEN,'dim(d)\n',NC)); print(dim(d))
	cat(paste0(GREEN,'d$v1\n',NC)); print(d$v1)
	cat(paste0(GREEN,'d$v4 = factor(rep(c("a","b")),levels=c("a","b"))\n',NC)); d$v4 = factor(rep(c("a","b")),levels=c("a","b"))
	cat(paste0(GREEN,'d[d$v4=="a",]\n',NC)); print(d[d$v4=="a",])
	cat(paste0(GREEN,'d[,"v2"]\n',NC)); print(d[,"v2"])
	cat(paste0(GREEN,'d[,c(3,1)]\n',NC)); print(d[,c(3,1)])
	cat(paste0(GREEN,'d[,c("v2","v4")]\n',NC)); print(d[,c("v2","v4")])
	cat(paste0(GREEN,'names(d)\n',NC)); print(names(d))
	cat(paste0(GREEN,'summary(d)\n',NC)); print(summary(d))

}

disp_functions = function(){

	###FUNCTIONS
	cat(paste0(LIGHT_BLUE,"\n###FUNCTIONS\n",NC))

	##FUNCTIONS
	cat(paste0(YELLOW,"\n##FUNCTIONS\n",NC))
	cat(paste0(BROWN_ORANGE,"- named argument and default value\n",NC))
	cat(paste0(BROWN_ORANGE,"- no need for explicit return \n",NC))
	#declaration
	cat(paste0(RED,"#declaration\n",NC))
	cat(paste0(GREEN,'substract = function(a,b){\n\treturn(a-b)\n}\n',NC))
	substract = function(a,b){
		return(a-b)
	}
	cat(paste0(GREEN,'divide = function(a=60,b=12){\n\ta/b\n}\n',NC))
	divide = function(a=60,b=12){
		a/b
	}
	#call
	cat(paste0(RED,"#call\n",NC))
	cat(paste0(GREEN,'substract(5,6)\n',NC)); print(substract(5,6))
	cat(paste0(GREEN,'substract(b=5,a=6)\n',NC)); print(substract(b=5,a=6))
	cat(paste0(GREEN,'divide()\n',NC)); print(divide())
	cat(paste0(GREEN,'divide(100,10)\n',NC)); print(divide(100,10))
	cat(paste0(GREEN,'divide(b=100,a=10)\n',NC)); print(divide(b=100,a=10))

}

disp_readdata = function(){
	
	###READ DATA
	cat(paste0(LIGHT_BLUE,"\n###READ DATA\n\n",NC))
	cat(paste0(GREEN,'data = read.table("filename")\n',NC))
	cat(paste0(GREEN,'data = read.csv("filename")\n',NC))
	cat(paste0(RED,"#performant version\n",NC))
	cat(paste0(GREEN,'library(readr)\n',NC))
	cat(paste0(GREEN,'data = read_csv("filname")\n',NC))
	cat(paste0(GREEN,'data = read_delim("filename")\n',NC))
}

disp_loops = function(){
	
	###LOOPS
	cat(paste0(LIGHT_BLUE,"\n###LOOPS\n",NC))
	
	##LOOPS AND FLOW CONTROL
	cat(paste0(YELLOW,"\n##LOOPS AND FLOW CONTROL\n",NC))
	cat(paste0(BROWN_ORANGE,"- ! avoid for loops (vectorial operations) \n",NC))
	cat(paste0(GREEN,'for (i in 1:length(a)){}\n',NC))
	cat(paste0(GREEN,'while(i > 4){i=i-1}\n',NC))
	#loop operations
	cat(paste0(RED,"#loop operations\n",NC))
	cat(paste0(GREEN,'a = runif(100000)\nt=Sys.time()\nfor (i in 1:length(a)){a[i]=a[i]+5}\nt1=Sys.time()-t\nt1\n',NC))
	a = runif(100000)
	t=Sys.time()
	for (i in 1:length(a)){a[i]=a[i]+5} 
	t1=Sys.time()-t
	print(t1)
	#vectorial operations
	cat(paste0(RED,"#vectorial operations\n",NC))
	cat(paste0(GREEN,'t=Sys.time()\na=a+5\nt2=Sys.time()-t\nt2\n',NC))
	t=Sys.time()
	a=a+5
	t2=Sys.time()-t
	print(t2)
	cat(paste0(GREEN,'as.numeric(t1)/as.numeric(t2)\n',NC)); print(as.numeric(t1)/as.numeric(t2))

}

disp_vectorfunctions = function(){

	###VECTOR FUNCTIONS
	cat(paste0(LIGHT_BLUE,"\n###VECTOR FUNCTIONS\n",NC))
	
	##VECTOR FUNCTIONS
	cat(paste0(YELLOW,"\n##VECTOR FUNCTIONS\n",NC))
	cat(paste0(BROWN_ORANGE,"- sum, cumulated sum (cumsum), finite differences (diff), max, min …\n",NC))
	cat(paste0(GREEN,'a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))\n',NC)); a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))
	#basic algebraic operations
	cat(paste0(RED,"#basic algebraic operations\n",NC))
	cat(paste0(GREEN,'a$v1+a$v2\n',NC)); print(head(a$v1+a$v2,5)); cat('...\n')
	cat(paste0(GREEN,'a$v1*a$v2\n',NC)); print(head(a$v1*a$v2,5)); cat('...\n')
	cat(paste0(GREEN,'a$v1/a$v2\n',NC)); print(head(a$v1/a$v2,5)); cat('...\n')
	#matrix product
	cat(paste0(RED,"#matrix product\n",NC))
	cat(paste0(GREEN,'t(a$v1)%*%a$v2\n',NC)); print(t(a$v1)%*%a$v2)
	#sum and cumulative sum
	cat(paste0(RED,"#sum and cumulative sum\n",NC))
	cat(paste0(GREEN,'sum(a$v2)\n',NC)); print(sum(a$v2))
	cat(paste0(GREEN,'cumsum(a$v1)\n',NC)); print(head(cumsum(a$v1),5)); cat('...\n')
	#difference
	cat(paste0(RED,"#difference\n",NC))
	cat(paste0(GREEN,'diff(a$v2)\n',NC)); print(head(diff(a$v2),5)); cat('...\n')
	#max, min
	cat(paste0(RED,"#max, min\n",NC))
	cat(paste0(GREEN,'max(a$v3)\n',NC)); print(max(a$v3))
	cat(paste0(GREEN,'which.max(a$v1)\n',NC)); print(which.max(a$v1))
	cat(paste0(GREEN,'which(a$v1>0.2)\n',NC)); print(head(which(a$v1>0.2),5)); cat('...\n')
	#string concatenation
	cat(paste0(RED,"#string concatenation\n",NC))
	cat(paste0(GREEN,'paste(a$v1,a$v2)\n',NC)); print(head(paste(a$v1,a$v2),5)); cat('...\n')
	cat(paste0(GREEN,'paste0(a$v1,a$v2)\n',NC)); print(head(paste0(a$v1,a$v2),5)); cat('...\n')
	#are on the matrices
	cat(paste0(RED,"#are on the matrices\n",NC))
	cat(paste0(GREEN,'b=matrix(runif(100),10,10)\n',NC)); b=matrix(runif(100),10,10)
	cat(paste0(GREEN,'sum(b)\n',NC)); print(sum(b))
	cat(paste0(GREEN,'rowSums(b)\n',NC)); print(rowSums(b))
	cat(paste0(GREEN,'colSums(b)\n',NC)); print(colSums(b))

}

disp_applylapplysapply = function(){

	###APPLY
	cat(paste0(LIGHT_BLUE,"\n###APPLY\n",NC))
	
	##APPLY, LAPPLY, SAPPLY
	cat(paste0(YELLOW,"\n##APPLY, LAPPLY, SAPPLY\n",NC))
	cat(paste0(BROWN_ORANGE,"- apply a function to each element of an object\n",NC))
	cat(paste0(BROWN_ORANGE,"- preferable to loops…\n",NC))
	cat(paste0(GREEN,'a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))\n',NC)); a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))
	#apply to each line
	cat(paste0(RED,"#apply to each line\n",NC))
	cat(paste0(GREEN,'r=apply(a,1,sum)\n',NC)); r=apply(a,1,sum)
	cat(paste0(GREEN,'head(r)\n',NC)); print(head(r))
	cat(paste0(GREEN,'class(r)\n',NC)); print(class(r))
	cat(paste0(GREEN,'dim(r)\n',NC)); print(dim(r))
	#apply to each column
	cat(paste0(RED,"#apply to each column\n",NC))
	cat(paste0(GREEN,'r=apply(a,2,function(col){c(max(col),which.max(col))})\n',NC)); r=apply(a,2,function(col){c(max(col),which.max(col))})
	cat(paste0(GREEN,'r\n',NC)); print(r)
	cat(paste0(GREEN,'class(r)\n',NC)); print(class(r))
	cat(paste0(GREEN,'dim(r)\n',NC)); print(dim(r))
	#apply to all elements of a list
	cat(paste0(RED,"#apply to all elements of a list\n",NC))
	cat(paste0(GREEN,'b=list(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))\n',NC)); b=list(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))
	cat(paste0(GREEN,'r=lapply(b,which.max)\n',NC)); r=lapply(b,which.max)
	cat(paste0(GREEN,'r\n',NC)); print(r)
	cat(paste0(GREEN,'class(r)\n',NC)); print(class(r))
	#simplification of the result
	cat(paste0(RED,"#simplification of the result\n",NC))
	cat(paste0(GREEN,'r=sapply(b,which.max)\n',NC)); r=sapply(b,which.max)
	cat(paste0(GREEN,'r\n',NC)); print(r)
	cat(paste0(GREEN,'class(r)\n',NC)); print(class(r))

}

disp_subset = function(){

	###SUBSET
	cat(paste0(LIGHT_BLUE,"\n###SUBSET\n",NC))

	##SAMPLE, LOGICAL INDEXING
	cat(paste0(YELLOW,"\n##SAMPLE, LOGICAL INDEXING\n",NC))
	cat(paste0(BROWN_ORANGE,"- select a part of the data\n",NC))
	cat(paste0(GREEN,'a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))\n',NC)); a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))
	#logical indexing
	cat(paste0(RED,"#logical indexing\n",NC))
	cat(paste0(GREEN,'a[a$v1>0.98 & a$v3==3,]\n',NC)); print(a[a$v1>0.98 & a$v3==3,])
	#substitute function
	cat(paste0(RED,"#substitute function\n",NC))
	cat(paste0(GREEN,'subset(a,v1>0.98 & v3==3)\n',NC)); print(subset(a,v1>0.98 & v3==3))

}

disp_binning = function(){

	###BINNING
	cat(paste0(LIGHT_BLUE,"\n###BINNING\n",NC))

	##CUT
	cat(paste0(YELLOW,"\n##CUT\n",NC))
	cat(paste0(BROWN_ORANGE,"- pretreat variables to construct factors // intervals\n",NC))
	cat(paste0(GREEN,'a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))\n',NC)); a=data.frame(v1=runif(5000),v2=rnorm(5000),v3=rbinom(5000,5,0.2))	
	#cut
	cat(paste0(RED,"#cut\n",NC))
	cat(paste0(GREEN,'r=cut(a$v2,c(-Inf,-3,-2,2,1,Inf))\n',NC)); r=cut(a$v2,c(-Inf,-3,-2,2,1,Inf))
	cat(paste0(GREEN,'class(r)\n',NC)); print(class(r))
	cat(paste0(GREEN,'head(r)\n',NC)); print(head(r))
	#SETDIFF, INTERSECT, %IN%, MATCH
	cat(paste0(YELLOW,"\n##SETDIFF, INTERSECT, %IN%, MATCH\n",NC))
	cat(paste0(BROWN_ORANGE,"- pretreat variables to construct factors // intervals\n",NC))
	cat(paste0(GREEN,'a=10:100\n',NC)); a=10:100
	cat(paste0(GREEN,'b=50:110\n',NC)); b=50:110		
	#setdiff
	cat(paste0(RED,"#setdiff\n",NC))
	cat(paste0(GREEN,'setdiff(a,b)\n',NC)); print(setdiff(a,b))
	#intersect
	cat(paste0(RED,"#intersect\n",NC))
	cat(paste0(GREEN,'intersect(a,b)\n',NC)); print(intersect(a,b))
	#%in%
	cat(paste0(RED,"#%in%\n",NC))
	cat(paste0(GREEN,'a %in% b\n',NC)); print(a %in% b)
	#match
	cat(paste0(RED,"#match\n",NC))
	cat(paste0(GREEN,'match(a,b)\n',NC)); print(match(a,b))

}

disp_counting = function(){

	###COUNTING
	cat(paste0(LIGHT_BLUE,"\n###COUNTING\n",NC))

	##TABLE
	cat(paste0(YELLOW,"\n##TABLE\n",NC))
	cat(paste0(GREEN,'data=data.frame(v1=rep(c("a","t","g","c"),500/4),v2=rbinom(500,10,0.4))\n',NC)); data=data.frame(v1=rep(c("a","t","g","c"),500/4),v2=rbinom(500,10,0.4))
	#table
	cat(paste0(RED,"#table\n",NC))
	cat(paste0(GREEN,'table(data$v1)\n',NC)); print(table(data$v1))
	cat(paste0(GREEN,'table(data[,c(\'v1\',\'v2\')])\n',NC)); print(table(data[,c('v1','v2')]))

}

disp_dplyrtidyr = function(){

	###DPLYR, TIDYR
	cat(paste0(LIGHT_BLUE,"\n###DPLYR, TIDYR\n",NC))

	##PIPE OPERATOR
	cat(paste0(YELLOW,"\n##PIPE OPERATOR\n",NC))
	#%>%
	cat(paste0(RED,"#%>%\n",NC))
	cat(paste0(GREEN,'x %>% f(y) becomes f(x,y)\n',NC))
	cat(paste0(GREEN,'x %>% f(y) %>% g(z) becomes g(f(x,y),z)\n',NC))

	##LINE SELECTION
	cat(paste0(YELLOW,"\n##LINE SELECTION\n",NC))
	#filter
	cat(paste0(RED,"#filter\n",NC))
	cat(paste0(GREEN,'data %>% filter(condition)\n',NC))
	cat(paste0(GREEN,'data %>% distinct(v1)\n',NC))
	cat(paste0(GREEN,'data %>% sample_n(15,replace=FALSE)\n',NC))
	cat(paste0(GREEN,'data %>% sample_frac(0.2)\n',NC))
	cat(paste0(GREEN,'data %>% top_n(5,v1)\n',NC))
	cat(paste0(GREEN,'data %>% slice(20:30)\n',NC))

	##COLUMN SELECTION
	cat(paste0(YELLOW,"\n##COLUMN SELECTION\n",NC))
	#select
	cat(paste0(RED,"#select\n",NC))
	cat(paste0(GREEN,'data %>% select(v1,v2)\n',NC))
	cat(paste0(GREEN,'data %>% select(contains(\'var\'))\n',NC))
	cat(paste0(GREEN,'data %>% select(-v3)\n',NC))
	cat(paste0(GREEN,'data %>% pull(v3)\n',NC))

	##TRANSFORMATION
	cat(paste0(YELLOW,"\n##TRANSFORMATION\n",NC))
	#mutate
	cat(paste0(RED,"#mutate\n",NC))
	cat(paste0(GREEN,'data %>% mutate(v3=v1/v2)\n',NC))
	cat(paste0(GREEN,'data %>% rename(v4=v1)\n',NC))
	cat(paste0(GREEN,'data %>% arrange(v4)\n',NC))
	cat(paste0(GREEN,'data %>% arrange(desc(v4))\n',NC))

	##SUMMARIZATION
	cat(paste0(YELLOW,"\n##SUMMARIZATION\n",NC))
	#summarize
	cat(paste0(RED,"#summarize\n",NC))
	cat(paste0(GREEN,'data %>% summarize(v1m=mean(v1))\n',NC))
	cat(paste0(RED,"#with grouped data: group_by\n",NC))
	cat(paste0(GREEN,'data %>% group_by(group) %>% summarize(v1m=mean(v1))\n',NC))
	cat(paste0(GREEN,'data %>% group_by(group) %>% summarize(v1med=median(v1))\n',NC))
	cat(paste0(RED,"#aggregation functions: mean,median,n,sum,max,min ... \n",NC))
	cat(paste0(GREEN,'data %>% group_by(v4) %>% summarize(n=n())\n',NC))
	cat(paste0(GREEN,'data %>% count(v4)\n',NC))

	##VECTOR FUNCTIONS
	cat(paste0(YELLOW,"\n##VECTOR FUNCTIONS\n",NC))
	cat(paste0(BROWN_ORANGE,"- ! after a group_by to mutate by groups.\n",NC))
	cat(paste0(GREEN,'data1 %>% mutate(v2=cumsum(v1))\n',NC))
	cat(paste0(GREEN,'data1 %>% mutate(v2=if_else(v1==32,"a","b"))\n',NC))
	cat(paste0(GREEN,'data1 %>% mutate(v2=case_when(v1==32 ~ "a", v1==33 & v4<5 ~ "b", TRUE ~ c))\n',NC))

	##OFFSET
	cat(paste0(YELLOW,"\n##OFFSET\n",NC))
	cat(paste0(BROWN_ORANGE,"- ! after a group_by to mutate by groups.\n",NC))
	cat(paste0(GREEN,'data1 %>% mutate(v2=lag(v1))\n',NC))
	cat(paste0(GREEN,'data1 %>% mutate(v2=lead(v4))\n',NC))

	##JOIN TABLES
	cat(paste0(YELLOW,"\n##JOIN TABLES\n",NC))
	#x_join
	cat(paste0(RED,"#x_join\n",NC))
	cat(paste0(GREEN,'data1 %>% left_join(data2, by=c("v1"="v2"))\n',NC))
	cat(paste0(GREEN,'data1 %>% right_join(data2)\n',NC))
	cat(paste0(GREEN,'data1 %>% inner_join(data2)\n',NC))
	cat(paste0(GREEN,'data1 %>% full_join(data2)\n',NC))

	##TYDIR FORMATS
	cat(paste0(YELLOW,"\n##TYDIR FORMATS\n",NC))
	cat(paste0(BROWN_ORANGE,"- pivot_longer: wide format -> long format\n",NC))
	cat(paste0(BROWN_ORANGE,"- pivot_wider: long format -> wide format\n",NC))
	cat(paste0(BROWN_ORANGE,"- separate: split of columns\n",NC))
	cat(paste0(BROWN_ORANGE,"- unite: concatenation of columns\n",NC))
	#long format
	cat(paste0(RED,"#long format\n",NC))
	cat(paste0(GREEN,'library(dplyr)\n',NC))
	cat(paste0(GREEN,'library(tidyr)\n',NC))
	cat(paste0(GREEN,'df=expand_grid(year=2015:2020,countries=c("France","Italy","Morocco"))\n',NC))
	cat(paste0(GREEN,'df$value=runif(nrow(df))\n',NC))
	cat(paste0(GREEN,'df\n',NC))
	#long format -> wide format
	cat(paste0(RED,"#long format -> wide format\n",NC))
	cat(paste0(GREEN,'dflarge=df %>% pivot_wider(names_from=year,values_from=value)\n',NC))
	cat(paste0(GREEN,'dflarge\n',NC))
	#wide format -> long format
	cat(paste0(RED,"#wide format -> long format\n",NC))
	cat(paste0(GREEN,'dflong=dflarge %>% pivot_longer(cols=-1,values_to="values",names_to="year")\n',NC))
	cat(paste0(GREEN,'dflong\n',NC))

}

#cat(paste0(LIGHT_BLUE,"\n###\n",NC))
#cat(paste0(YELLOW,"\n##\n",NC))
#cat(paste0(BROWN_ORANGE,"- \n",NC))
#cat(paste0(RED,"#\n",NC))
#cat(paste0(GREEN,'\n',NC)); 
#cat(paste0(GREEN,'\n',NC)); print()

disp_help = function(){
	cat(paste0(LIGHT_CYAN,'\nSYNOPSIS\n',NC))
	cat(paste0('\t./r101.R [',LIGHT_GREEN,'CHEATSHEET',NC,']\n\n'))
	cat(paste0(LIGHT_CYAN,'DESCRIPTION\n',NC))
	cat(paste0('\tDisplay ',LIGHT_GREEN,'CHEATSHEET',NC,':\n'))
	cat(paste0(LIGHT_CYAN,'\t\tall\n',NC,'\t\t\t- all cheatsheets.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tinstall\n',NC,'\t\t\t- install packages.\n'))
	cat(paste0(LIGHT_CYAN,'\t\ttypes\n',NC,'\t\t\t- basic types: vectors, factors, matrix, arrays, lists, dataframes.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tfunctions\n',NC,'\t\t\t- functions.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tread\n',NC,'\t\t\t- read data.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tloops\n',NC,'\t\t\t- loops and flow control.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tvfunctions\n',NC,'\t\t\t- vector functions: algebraic operations, matrix product, sum, cumulative sum, difference, max, min, string concatenation, matrix sums.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tapply\n',NC,'\t\t\t- apply, lapply, sapply.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tsubset\n',NC,'\t\t\t- subset: sample, logical indexing.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tbinning\n',NC,'\t\t\t- binning: cut, setdiff, intersect, %in%, match.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tcounting\n',NC,'\t\t\t- counting: table.\n'))
	cat(paste0(LIGHT_CYAN,'\t\tdplyr\n',NC,'\t\t\t- dplyr, tidyr: pipe operator, line selection, column selection, transformation, summarization, vector functions, offset, join tables, tydir formats.\n'))
	cat('\n')
}

args = commandArgs(trailingOnly=TRUE)

if (length(args)==1) {
	if(args[1]=="all") {
		disp_packages()
		disp_basictypes()
		disp_functions()
		disp_readdata()
		disp_loops()
		disp_vectorfunctions()
		disp_applylapplysapply()
		disp_subset()
		disp_binning()
		disp_counting()
		disp_dplyrtidyr()
	}
	else if(args[1]=="install") { disp_packages() }
	else if(args[1]=="types") { disp_basictypes() }
	else if(args[1]=="functions") { disp_functions() }
	else if(args[1]=="read") { disp_readdata() }
	else if(args[1]=="loops") { disp_loops() }
	else if(args[1]=="vfunctions") { disp_vectorfunctions() }
	else if(args[1]=="apply") { disp_applylapplysapply() }
	else if(args[1]=="subset") { disp_subset() }
	else if(args[1]=="binning") { disp_binning() }
	else if(args[1]=="counting") { disp_counting() }
	else if(args[1]=="dplyr") { disp_dplyrtidyr() }
	else { disp_help() }
} else { disp_help() }

cat("\n\n")


