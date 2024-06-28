#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np #as : alias
# pip install numpy


# In[2]:


arr = np.array([12,3,4,5,6,7,8,9])
print(arr)
print(type(arr))
print(arr.ndim) # ndim : number of dimensions


# In[166]:


# in case we introduce a float value
arr = np.array([12,3,4,5,6,7,8,9,11.13])
print(arr)

# entire array gets converted to float dtype


# In[4]:



for i in range(5):
    print(i)


# In[167]:


np.arange(20) #range function


# In[2]:


a = list(range(0,20)) # start, end-1
print(a)


# In[168]:


np.arange(12,40)


# In[4]:


np.arange(2.5,40)


# In[170]:


np.arange(12,40,3)


# In[5]:


# creating array from list data Structure
import numpy as np

List_Nums= list(range(15))
print(List_Nums)

print(type(List_Nums))

arr = np.array(List_Nums,dtype="int64")

print(arr)
print(type(arr))
print(arr.dtype)
n = arr.ndim
print(f"The n dimension value of arr is {n}")


# In[9]:


# converting dictionary to list to np.array

dict_new = {'Name':'Chirantan',
           'Organization':'Futurense',
           'Age':29}
print(dict_new)


print(dict_new.keys())
print(dict_new.values())



# loop
# convert to list
# list to np.array


# In[183]:


# convert that to a list

dict_tolist = list(dict_new)
dict_tolist
type(dict_tolist)


# In[182]:


arr = np.array(dict_tolist)
print(arr)
type(arr)


# In[195]:


#create 0-D array

x = np.array(30)
print(x)
print(type(x))
print(x.ndim)


# In[194]:


# create 1-D array

y = np.array([1,2,3,4,4,6])
print(y)
print(type(y))
print(y.ndim)


# In[193]:


#create 2-D array

# np.array([[1],[2]])
z = np.array([[1,2,3],[4,5,6]])
print(z)
print(type(z))
print(z.ndim)


# In[200]:


# create 3-D array

w = np.array([[[12,13,14],[15,16,17],[18,19,20]]])
print(w)
print(type(w))
print(w.ndim)


# In[202]:


# create 3-D array

ThreeDArray = np.arange(60)
ThreeDArray.shape = (2,6,5)
ThreeDArray


# In[203]:


ThreeDArray.ndim


# In[204]:


# boolean mask array

x = np.arange(1,200)
print(x)


# In[206]:


# we want number that are completely divisble by 7
(x % 7)

# this only gives you the remainder


# In[207]:


(x % 7) == 0


# In[208]:


Divisbleby7 = x[(x % 7) == 0]
Divisbleby7


# In[214]:


# but if we wanted to achieve the same output with list, it would have been tedious

list1 = list(range(1,200))

divisibleby7 = [i for i in list1 if i % 7 == 0]

divisibleby7


# In[10]:


# random array

np.random.random(5)

# random numbers between 0 to 1 with float data type


# In[219]:


np.random.random(13)


# In[11]:


np.random.random((2,4,6))


# In[222]:


# np.random.rand

np.random.rand(4,3)

# random values between 0 to 1


# In[12]:


# np.random.randint
# here we mention a low and high range and the size in which we want the output 

np.random.randint(15,size=(3,4))


# In[15]:


# or you can also mention a low and high range

np.random.randint(low = 10,high = 25,size=(2,4))


# In[17]:


np.random.randint(low = -4,
                 high = 10,
                 size = (5,6))


# In[21]:


# if you just want to extract a random integer between a range

np.random.randint(25,75)


# In[244]:


# create a 1-D array and convert it into 3-D array

OneDArray = np.random.randint(1,30,16)
print(OneDArray)
print(OneDArray.ndim)


# In[247]:


# convert this to 3-D array, use reshape

ThreeDArray = np.random.randint(1,30,16).reshape(2,4,2)
print(ThreeDArray)
print(ThreeDArray.ndim)


# In[248]:


# create array containing 20 random numbers
# replace every even number by -1

# use seed method


# In[33]:


for i in range(10):
    np.random.seed(512)
    print(np.random.randint(1,100))
    
    # saves the state of randomness
    # change the value of seed and you can see the numbers changing
    # if you're not using seed method, with every refresh you will get different number


# In[42]:


for i in range(10):  
    np.random.seed(9)
    print(np.random.randint(1,100))


# In[29]:


# for example,

np.random.seed(15)
print(np.random.randint(100,800))

# every time we run this we get the same output, because of seed and that is how it saves the state of randomness
# change the seed value and the output gets changed too


# In[4]:


#random choice method
import numpy as np

ListOfNames = ['Chirantan','Amit','Vishal','Xavier','Santhosh','Morgan','Freeman','Chirantan']

# if we want to extract any 3 names at random , we use random.choice

np.random.choice(ListOfNames, size=3, replace=False)

# dtype='<U9',specifies dtype of the given array object is '<U9' 
# where 9 is the length of the longest string in the given array object.


# In[36]:


# np.repeat

# repeating an array

arr = np.array([1,2,4])
np.repeat(arr,3)


# In[43]:


#empty array
# create an empty array

list =[1,2,34]
list*2


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# ## Numpy splitting operations

# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# ## where | extract | delete

# In[1]:


import numpy as np


# In[2]:


# np.where - where in the numpy array is the condition met

# we can use np.where with single condition, multiple condition and without condition


# In[3]:


arr = np.array([1,2,3,4,5,6,7,7,8])
print(arr)


# In[4]:


result = np.where(arr<6)
print(result)

# the output is in the form of index
# elements which are less than 6 and what index do they lie


# In[5]:


result = np.where(arr>6)
print(result)


# In[6]:


arr = np.arange(20)
print(arr)


# In[7]:


# passing condition in np.where

# np.where(condition, Option A, Option B)
# if condition is true Option A will be executed, if condition is false, condition B will be executed


# In[8]:


np.where(arr > 15, "Greater", "Lower")

# similar to if-else


# In[9]:


# we can see all the indexes with LOWER where the condition is false, and where the condition is true we get Greater


# In[44]:


x = np.array([1,2,3,4,5,6,7,8,9,10])
print(x)
result = np.where(x>2, x+3, x-3)

print(result)


# In[47]:


# mutliple conditions

x = np.arange(50)
print(x)


# In[48]:


result = np.where((x >=0) & (x<=30), "0-30", "30 and above")
print(result)


# In[13]:


# x is a 2D array 

x = np.array([[1,2],
            [3,4],
            [5,6]])

print(x)


# In[14]:


np.where(x>3,10,5) # if x is greater than 3 then 10 else 5


# In[15]:


# using np.where on a dataframe

import pandas as pd

df = pd.read_excel('Global Superstore.xlsx')
df.head()


# In[ ]:





# In[16]:


# Create sales buckets
# "0-500" "Between 0-500"
# "501-5000" "Between 501-5000"
# >5000 "Greater than 5000"


# In[18]:


df['Sales_Buckets'] = np.where((df['Sales']>=0) & (df['Sales']<=500),"Between 0 -500",
                               np.where((df['Sales'] >= 501) & (df['Sales'] <= 5000),"Between 501 - 5000",
                                        ">5000"))


# In[19]:


df.head()


# In[20]:


df['Sales_Buckets'].value_counts()


# In[21]:


# verify

df[df['Sales'] <= 500].shape


# ## np.delete()

# In[25]:


# np.delete(array,object,axis=None)


# In[32]:


x = np.array([4,4,6,7,9,10,11,12,13])
print(x)


# In[33]:


# if you want to delete the 3rd index element
np.delete(x,3)


# In[34]:


np.delete(x,4)


# In[35]:


# if deleting multiple indexes
np.delete(x,[0,2])


# In[36]:


# giving negative indexes
np.delete(x,[4,-1])


# In[38]:


# using np.delete on 2D array

x = np.array([[4,5],
             [6,7],
             [8,9]])

print(x)


# In[39]:


np.delete(x,2)

#here we can see the 2nd index got deleted


# In[40]:


# change the axis
# axis = None be default, deleting an element based on index

np.delete(x,1,axis=0) #deleting specific row , here 6,7 is getting deleted


# In[44]:


# deleting multiple rows

np.delete(x,[1,2],axis=0) # delete 1st and 2nd row ,axis=0)


# In[45]:


# we can delete column as well using axis = 1

np.delete(x,1,axis=1)


# In[47]:


np.delete(x,0,axis=1)


# In[48]:


x = np.arange(20).reshape(4,5)
print(x)


# In[50]:


np.delete(x,[0,-1],axis=1)

# 1st and last column is being deleted here


# In[51]:


np.delete(x,[0,-1],axis=0)


# In[ ]:


# delete elements in numpy array based on multiple conditions


# In[63]:


arr = np.random.randint(100,size=50)
print(arr)


# In[65]:


# we want to remove all the values except between 50 to 90

arr = arr[(arr>=50) & (arr <=90)]
print(arr)


# In[66]:


# deleting specific value -- say 88
# find index

# if you get 2 indexes , it means the number is getting repeated in the array
    
    
np.argwhere(arr == 88)


# In[67]:


# verify
arr[19]


# In[68]:


np.delete(arr,[19])

# arr, index number we can see that number 88 is deleted


# In[3]:


# another way

x = np.random.randint(100,size = 60)
print(x)


# In[4]:


# verify
x.size


# In[5]:


# let say number 22 is getting repeated here and we want to delete it
# know the index

np.argwhere(x == 22)


# In[6]:


# verify\
print(x[9])
print(x[48])


# In[7]:


# 22 is at index 9 and 48


# In[8]:


# another way of deleting the element

x_del = np.delete(x, np.argwhere(x == 22))
print(x_del)


# In[9]:


# what if we want to delete all the values from the above array that are even

np.argwhere(x_del % 2 == 0)


# In[10]:


# we got the indexes of even elements from the array
import numpy as np

arr = np.delete(x_del,np.argwhere(x_del%2==0))
print(arr)

# we have now deleted all the even elements from the array


# In[11]:


# another example

x1 = np.random.randint(100,size=50)
print(x1)


# In[14]:


# deleting numbers between 50 and 90 using np.argwhere

x1 = np.delete(x1,
              np.argwhere((x1 >= 50) & (x1 <= 90)))

print(x1)


# In[13]:


# np.extract method


# In[88]:


# based on a condition we extract a number

x1


# In[91]:


# finding even values from the above array
# format -- np.extract(condition,array)

np.extract(x1%2 == 0,
          x1)

# all even values in the output


# In[90]:


np.extract(x1%2 != 0,
          x1)


# In[93]:


# extract numbers that are completely divisible by 3 and 5

arr1 = np.random.randint(100,size=150)
print(arr1)


# In[94]:


condition = (arr1 % 3 == 0) & (arr1 % 5 == 0)


# In[96]:


np.extract(condition,arr1)

# output are numbers completely divisble by 3 and 5


# ## Math operations using numpy

# In[97]:


np.arange(50)


# In[98]:


# but, 
np.arange(5000)


# In[99]:


# to print all numbers, import sys module

import sys

np.set_printoptions(threshold=sys.maxsize)


# In[100]:


np.arange(5000)

# here because of sys module we are able to print all the numbers from 0 to 5000
# but before sys module, all numbers were not getting print and showed us a range like 0,1,2,3,.....,4999


# In[102]:


arr = np.arange(12).reshape(3,4)
print(arr)


# In[103]:


# if you want the sum of array based on column 

sum(arr)


# In[106]:


arr = np.array([1,2,3,4,5,6])
print(arr)


# In[107]:


# mutliply each element by 2

arr * 2


# In[109]:


# but the same multiplication operation cannot be used on a list

list1 = [1,2,3,4,5,6]
list1 *2

# it prints the list 2 times


# In[110]:


# it repeats the list 2 times, so we cannot perform arithmetic operations like this on list


# In[113]:


for i in list1:
    print(i * 2,end=' ')


# In[114]:


list1 - 2


# In[115]:


arr


# In[117]:


# divide each element of arr by 2

print(arr/2)

# similarly
print(arr + 2)

print(arr - 2)


# In[120]:


np.array([3,4,5,6,7,8]) % 3

# this gives us the remainder


# In[124]:


arr


# In[125]:


# power of each number

arr ** 2


# In[128]:


# arrays must be of same length when adding

x = np.array([1,2,3,4,5])
print(x)


# In[129]:


x + np.array([6,7,8,9,10])


# In[131]:


# trigonometric operations

arr2 = np.array([10,30,40,60,90])

print(np.sin(arr2))
print(np.cos(arr2))
print(np.tan(arr2))


# In[132]:


# np.add

a = np.array([1,2,3,4])
b = np.array([5,6,7,8])

np.add(a,b)


# In[133]:


# changing size of array, will throw error


# In[134]:


np.subtract(a,b)


# In[135]:


np.multiply(a,b)


# In[136]:


a * b


# In[140]:


a = np.array([10,20,30,40])
b = np.array([3,5,7,9])


# In[143]:


print(a)
print(b)


# In[145]:


np.remainder(a,b)

# what is the remainder after dividing 10/3 , 20/5 , 30/7 , 40/9


# In[146]:


np.power(a,b)

# 10 to the power 3, 20 to the power 5,


# In[148]:


np.floor_divide(a,b)

# this gives you the quotient


# In[149]:


print("Quotient and Remainder of a and b is: ", np.divmod(a,b))


# In[150]:


a = np.array([10,20,30,40])
b = np.array([3,5,7,9])


# In[151]:


np.log(a)


# In[152]:


np.exp(a)


# In[155]:


a = np.array([1.24,4.167,3.9576])

np.round(a,1)

# rounding off the values


# In[160]:


arr_1 = np.array([10,20,30,40])
arr_2 = np.array([3,5,7,9])


# In[161]:


np.maximum(arr_1,arr_2)


# In[162]:


np.minimum(arr_1,arr_2)


# ## Split operations in numpy

# In[1]:


#split function
# using split we can split array into multiple sub arrays of equal size
# ths method takes in 3 arguements
# your array, indices(chunk size),axis -- be default axis=0
# returns the list of subarays


# In[3]:


import numpy as np
arr = np.arange(10)
arr


# In[7]:


np.split(arr,5) #this divides the array into 5 chunks of equal sizes


# In[8]:


np.split(arr,4)

# this array cannot be divided into 4 equal parts, hence the exception


# In[9]:


np.split(arr,2)


# In[11]:


arr


# In[14]:


np.split(arr,[2,4,5,6])

# based on index postions
# 1st index -> 2 -> [0:2]


# In[19]:


print(arr[:2])
print(arr[2:4])
print(arr[4:5])
print(arr[5:6])
print(arr[6:])


# In[18]:


np.split(arr,[2,5,7])


# In[20]:


# split 2D array

arr = np.arange(16).reshape(4,4)
arr


# In[21]:


print(arr.ndim)


# In[22]:


np.split(arr, indices_or_sections=[1,3])

# it will split in 3 arrays
## starts at 0 -> index 0 becomes one array since [0:1], then 1:3 i.e, 1 a d 2 index becomes 2nd array, and then 3 onwards


# In[23]:


arr = np.arange(25).reshape(5,5)
arr


# In[24]:


np.split(arr,indices_or_sections=[1,3])


# In[26]:


arr


# In[25]:


# split array by columns

np.split(arr,indices_or_sections=[2,3],axis=1)

# for 2 -> 0:!
# for 2,3 -> 2:3 ,i.e, 2nd index position
# 3 onwards all columns


# In[27]:


# array_split()

# the difference between array split and split is ,array_split allows unequal division
# based on chunksize and indices


# In[29]:


arr = np.arange(10)
arr


# In[30]:


np.array_split(arr,4)

# the split is unequal


# In[31]:


# but we will face error with split function

np.split(arr,4)


# In[33]:


arr = np.array([4,5,6,7,8,9])
arr


# In[34]:


np.array_split(arr, (2,3))


# In[36]:


print(arr[:2])
print(arr[2:3])
print(arr[3:])


# In[37]:


arr = np.arange(8).reshape(2,4)
arr


# In[38]:


np.array_split(arr,2,axis=0)


# In[40]:


np.array_split(arr,2,axis=1)


# In[42]:


np.array_split(arr,[2,3],axis=1)


# In[43]:


# np. hsplit() method : horizontal split , similar to split with axis=1

arr = np.arange(20).reshape(5,4)
arr


# In[45]:


np.hsplit(arr,2)

# first 2 columns - 0 and 1
# then 2 and 3


# In[46]:


np.hsplit(arr,[3,4])

# 0,1,2
# then between 3 and 4 i.e.3 
# and then 4 onwards


# In[47]:


np.split(arr,[3,4],axis=1)


# In[48]:


# vsplit() : similar to split with axis = 0

arr = np.arange(1,10).reshape(3,3)
arr


# In[49]:


np.vsplit(arr,3)


# In[50]:


np.split(arr,3,axis=0)


# In[51]:


x = np.arange(24).reshape(2,2,6)
x


# In[56]:


x


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




