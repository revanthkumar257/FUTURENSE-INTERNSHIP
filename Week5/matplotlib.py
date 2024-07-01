#!/usr/bin/env python
# coding: utf-8

# In[3]:


import matplotlib.pyplot as plt
import numpy as np

xpoints = np.array([5, 5])
ypoints = np.array([10, 25])

plt.plot(xpoints, ypoints)
plt.show()


# In[4]:


xpoints = np.array([1, 2, 6, 8])
ypoints = np.array([3, 8, 1, 10])

plt.plot(xpoints, ypoints)
plt.show()


# In[5]:


ypoints = np.array([3, 8, 1, 10, 5, 7])

plt.plot(ypoints)
plt.show()


# In[7]:


ypoints = np.array([7, 8, 1])

plt.plot(ypoints, marker = 'o')
plt.show()


# In[8]:


import matplotlib.pyplot as plt
import numpy as np

exams = np.arange(1, 11)
average_marks = np.random.randint(50, 100, size=10)

plt.figure(figsize=(10, 6))
plt.plot(exams, average_marks, marker='o', label='Average Marks')
plt.title('Average Marks Over 10 Exams')
plt.xlabel('Exam Number')
plt.ylabel('Average Marks')
plt.legend()
plt.grid(True)
plt.show()


# In[9]:


import matplotlib.pyplot as plt
products = ['Product A', 'Product B', 'Product C', 'Product D']
sales = [150, 200, 300, 250]
plt.figure(figsize=(10, 6))
plt.bar(products, sales, color='skyblue')
plt.title('Sales of Different Products')
plt.xlabel('Products')
plt.ylabel('Sales')
plt.show()


# In[10]:


import matplotlib.pyplot as plt
import numpy as np
heights = np.random.normal(170, 10, 50)  
weights = np.random.normal(70, 15, 50)   
plt.figure(figsize=(10, 6))
plt.scatter(heights, weights, color='purple')
plt.title('Heights vs. Weights of Individuals')
plt.xlabel('Height (cm)')
plt.ylabel('Weight (kg)')
plt.grid(True)
plt.show()


# In[11]:


import matplotlib.pyplot as plt
import numpy as np
test_scores = np.random.randint(0, 101, size=1000)
plt.figure(figsize=(10, 6))
plt.hist(test_scores, bins=20, color='green', alpha=0.7)
plt.title('Distribution of Test Scores')
plt.xlabel('Test Scores')
plt.ylabel('Frequency')
plt.grid(True)
plt.show()


# In[12]:


import matplotlib.pyplot as plt
companies = ['Company A', 'Company B', 'Company C', 'Company D']
market_share = [20, 35, 30, 15]
plt.figure(figsize=(10, 6))
plt.pie(market_share, labels=companies, autopct='%1.1f%%', startangle=140, colors=['gold', 'lightcoral', 'lightskyblue', 'lightgreen'])
plt.title('Market Share of Different Companies')
plt.show()


# In[13]:


import matplotlib.pyplot as plt
import numpy as np
expenses = [
    np.random.normal(500, 100, 30),  # Food
    np.random.normal(200, 50, 30),   # Transport
    np.random.normal(150, 30, 30),   # Utilities
    np.random.normal(300, 70, 30)    # Entertainment
]
expense_categories = ['Food', 'Transport', 'Utilities', 'Entertainment']

plt.figure(figsize=(10, 6))
plt.boxplot(expenses, patch_artist=True, labels=expense_categories)
plt.title('Monthly Expenses in Different Categories')
plt.xlabel('Expense Categories')
plt.ylabel('Expenses')
plt.grid(True)
plt.show()


# In[17]:


import matplotlib.pyplot as plt
import numpy as np
x = np.arange(1, 11)
y1 = np.random.randint(1, 10, size=10)
y2 = np.random.randint(1, 10, size=10)
plt.figure(figsize=(10, 6))
plt.fill_between(x, y1, color="skyblue", alpha=0.4)
plt.fill_between(x, y2, color="orange", alpha=0.5)
plt.title('Area Chart')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.show()


# In[18]:


import matplotlib.pyplot as plt
import numpy as np
categories = ['Category 1', 'Category 2', 'Category 3']
subcat1 = [5, 3, 4]
subcat2 = [2, 4, 6]
subcat3 = [3, 2, 5]
plt.figure(figsize=(10, 6))
plt.bar(categories, subcat1, label='Subcategory 1')
plt.bar(categories, subcat2, bottom=subcat1, label='Subcategory 2')
plt.bar(categories, subcat3, bottom=np.array(subcat1) + np.array(subcat2), label='Subcategory 3')
plt.title('Stacked Bar Chart')
plt.xlabel('Categories')
plt.ylabel('Values')
plt.legend()
plt.show()


# In[19]:


import matplotlib.pyplot as plt
import numpy as np
data = np.random.rand(10, 10)
plt.figure(figsize=(10, 6))
plt.imshow(data, cmap='viridis', interpolation='nearest')
plt.colorbar()
plt.title('Heatmap')
plt.show()


# In[20]:


data = np.random.normal(0, 1, 1000)
plt.figure(figsize=(10, 6))
plt.hist(data, bins=30, density=True, alpha=0.6, color='b')
mu, sigma = 0, 1
x = np.linspace(-3, 3, 100)
plt.plot(x, 1/(sigma * np.sqrt(2 * np.pi)) * np.exp(-(x - mu)**2 / (2 * sigma**2)), linewidth=2, color='r')
plt.title('Normal Distribution')
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.grid(True)
plt.show()


# In[ ]:




