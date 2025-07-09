switch(2,"red","green","blue")
switch("length","color"="red","shape"="square","length"=9)

# i<- 2
# while(i < 7)
# {
#   print(i)
#   i<-i+1
# }




#break after a particular number
# i<-1
# while(i<8)
# {
#   print(i)
#   i<-i+1
#   if(i == 3 ){
#      break
#}
#    
#   
# }



#skip a particular value
# i<-0
# while(i<6)
# {
#   i<-i+1
#   if(i == 3)
#   {
#     next
#   }
#   print(i)
#     
# }



# for(x in 1:10)
# {
#   print(x)
# }

#for  capital letter
# for (letter in LETTERS)
# {
#   print(letter)
# }


#for small letter
# for(letter in letters)
# {
#   print(letter)
# }



#nested for loop
 for(y in 1:2)
{
  for (i in 1:3)
   {
     print(y*i)
   }
   
 }



#function
#to create a function function keyword is used
 myfunction<-function(a,b)
 {
   sum<-a*b
   return(sum)
}
 print(myfunction(4,6))


#data structure
#vector
# to create a vector combine function "c()" is used
a<-c(1,2,100,4,5)
print(a)
b<-c("a","b","c")
print(b)
c<-c(TRUE,FALSE,TRUE,TRUE)
print(c)
print(min(a))
print(max(a))
print(mean(a))
print(sum(a))
print(mode(a))
print(sd(a))

name<-"hello world"
Name<-c("hello","world")
length(name)
length(Name)
nchar(name)
nchar(Name)


s<-c(3,5,6)
s+3
s*5


num<-c(23,45,11,32,10,8,24) # by default ascending order
sort(num, decreasing= TRUE) # if decreasing is set to true the values will sort in descending order 

lett<-c("d","e","a","z")
sort(lett)

#access vector
#in r index of vector will start from 1
w<-c(2,4,1,5,7,8,3)
w[1]
w[2]
w[4]
for(a in w)
{
  print(a[])
}

w[1:6]
#for selected index
w[c(4,7)]


#Matrices
#by default values are filled column wise

mymatrix<-matrix(1:20,nrow=5, ncol=4,byrow=TRUE, dimname=list(c("a","b","C","d","e"),c("x","y","z","n")))
mymatrix

mymatrix[2,]
mymatrix[,2]
mymatrix[1,4]
mymatrix[5,c(2,3)]
mymatrix[c(1,4),c(2,3)] #to access multiple values at the same time
mymatrix[,2:4]# to access consecutive columns


#Arrays

myarray<- array(1:24,c(3,4,3))
myarray
myarray[1,2,3]



#Data frames
# frame is created with "data.frame()" function
patientID<-c(1,2,3,4)
age<-c(25,24,34,53)
diabetes<-c("type1","type2","type1","type1")
status<-c("poor","improved","excellent","poor")
patientdata<-data.frame(patientID,age,diabetes,status)
patientdata












